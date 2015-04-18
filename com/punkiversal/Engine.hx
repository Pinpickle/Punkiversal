package com.punkiversal;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.Lib;
import haxe.EnumFlags;
import haxe.Timer;
import com.punkiversal.utils.Input;
import com.punkiversal.Tweener;

/**
 * Main game Sprite class, added to the Flash Stage.
 * Manages the game loop.
 * 
 * Your main class **needs** to extends this.
 */
class Engine extends Sprite
{
	/**
	 * If the game should stop updating/rendering.
	 */
	public var paused:Bool;

	/**
	 * Cap on the elapsed time (default at 30 FPS). Raise this to allow for lower framerates (eg. 1 / 10).
	 */
	public var maxElapsed:Float;

	/**
	 * The max amount of frames that can be skipped in fixed framerate mode.
	 */
	public var maxFrameSkip:Int;

	/**
	 * The amount of milliseconds between ticks in fixed framerate mode.
	 */
	public var tickRate:Int;

	/**
	 * Constructor. Defines startup information about your game.
	 * @param	width			The width of your game.
	 * @param	height			The height of your game.
	 * @param	frameRate		The game framerate, in frames per second.
	 * @param	fixed			If a fixed-framerate should be used.
	 * @param   renderMode      Overrides the default render mode for this target
	 */
	public function new(width:Int = 0, height:Int = 0, frameRate:Float = 60, fixed:Bool = false, ?renderMode:RenderMode)
	{
		super();

		// global game properties
		PV.bounds = new Rectangle(0, 0, width, height);
		PV.assignedFrameRate = frameRate;
		PV.fixed = fixed;

		// global game objects
		PV.engine = this;
		PV.width = width;
		PV.height = height;

		if (renderMode != null)
		{
			PV.renderMode = renderMode;
		}
		else
		{
			PV.renderMode = #if (flash || js) RenderMode.BUFFER #else RenderMode.HARDWARE #end;
		}

		// miscellaneous startup stuff
		if (PV.randomSeed == 0) PV.randomizeSeed();

		PV.entity = new Entity();
		PV.time = Lib.getTimer();

		paused = false;
		maxElapsed = 0.0333;
		maxFrameSkip = 5;
		tickRate = 4;
		_frameList = new Array<Int>();
		_systemTime = _delta = _frameListSum = 0;
		_frameLast = 0;

		// on-stage event listener
#if flash
		if (Lib.current.stage != null) onStage();
		else Lib.current.addEventListener(Event.ADDED_TO_STAGE, onStage);
#else
		addEventListener(Event.ADDED_TO_STAGE, onStage);
		Lib.current.addChild(this);
#end
	}

	/**
	 * Override this, called after Engine has been added to the stage.
	 */
	public function init() { }

	/**
	 * Override this, called when game gains focus
	 */
	public function focusGained() { }

	/**
	 * Override this, called when game loses focus
	 */
	public function focusLost() { }

	/**
	 * Updates the game, updating the Scene and Entities.
	 */
	public function update()
	{
		_scene.updateLists();
		checkScene();
		if (PV.tweener.active && PV.tweener.hasTween) PV.tweener.updateTweens();
		if (_scene.active)
		{
			if (_scene.hasTween) _scene.updateTweens();
			_scene.update();
		}
		_scene.updateLists(false);
		PV.screen.update();
	}

	/**
	 * Renders the game, rendering the Scene and Entities.
	 */
	@:dox(hide)
	public function render()
	{
		if (PV.screen.needsResize) PV.resize(PV.windowWidth, PV.windowHeight);

		// timing stuff
		var t:Float = Lib.getTimer();

		if (_scene.visible) _scene.render();

		// more timing stuff
		t = Lib.getTimer();
		_frameListSum += (_frameList[_frameList.length] = Std.int(t - _frameLast));
		if (_frameList.length > 10) _frameListSum -= _frameList.shift();
		PV.frameRate = 1000 / (_frameListSum / _frameList.length);
		_frameLast = t;
	}

	/**
	 * Sets the game's stage properties. Override this to set them differently.
	 */
	private function setStageProperties()
	{
		PV.stage.frameRate = PV.assignedFrameRate;
		PV.stage.align = StageAlign.TOP_LEFT;
#if !js
		PV.stage.quality = StageQuality.HIGH;
#end
		PV.stage.scaleMode = StageScaleMode.NO_SCALE;
		PV.stage.displayState = StageDisplayState.NORMAL;
		PV.windowWidth = PV.stage.stageWidth;
		PV.windowHeight = PV.stage.stageHeight;

		resize(); // call resize once to initialize the screen

		// set resize event
		PV.stage.addEventListener(Event.RESIZE, function (e:Event) {
			resize();
		});

		PV.stage.addEventListener(Event.ACTIVATE, function (e:Event) {
			PV.focused = true;
			focusGained();
			_scene.focusGained();
		});

		PV.stage.addEventListener(Event.DEACTIVATE, function (e:Event) {
			PV.focused = false;
			focusLost();
			_scene.focusLost();
		});

#if (!(flash || html5) && openfl_legacy)
		flash.display.Stage.shouldRotateInterface = function(orientation:Int):Bool {
			if (PV.indexOf(PV.orientations, orientation) == -1) return false;
			var tmp = PV.height;
			PV.height = PV.width;
			PV.width = tmp;
			resize();
			return true;
		}
#end
	}

	/** @private Event handler for stage resize */
	private function resize()
	{
		if (PV.width == 0) PV.width = PV.stage.stageWidth;
		if (PV.height == 0) PV.height = PV.stage.stageHeight;
		// calculate scale from width/height values
		PV.windowWidth = PV.stage.stageWidth;
		PV.windowHeight = PV.stage.stageHeight;
		PV.screen.scaleX = PV.stage.stageWidth / PV.width;
		PV.screen.scaleY = PV.stage.stageHeight / PV.height;
		PV.resize(PV.stage.stageWidth, PV.stage.stageHeight);
	}

	/** @private Event handler for stage entry. */
	private function onStage(e:Event = null)
	{
		// remove event listener
#if flash
		if (e != null)
			Lib.current.removeEventListener(Event.ADDED_TO_STAGE, onStage);
		PV.stage = Lib.current.stage;
		PV.stage.addChild(this);
#else
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		PV.stage = stage;
#end
		setStageProperties();

		// enable input
		Input.enable();

		// switch scenes
		checkScene();

		// game start
		init();

		// start game loop
		_rate = 1000 / PV.assignedFrameRate;
		if (PV.fixed)
		{
			// fixed framerate
			_skip = _rate * (maxFrameSkip + 1);
			_last = _prev = Lib.getTimer();
			_timer = new Timer(tickRate);
			_timer.run = onTimer;
		}
		else
		{
			// nonfixed framerate
			_last = Lib.getTimer();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		// Warnings when forcing RenderMode
		if (PV.renderMode == RenderMode.BUFFER)
		{
			#if (!(flash || js) && debug)
			PV.console.log(["Warning: Using RenderMode.BUFFER on native target may result in bad performance"]);
			#end
		}
		else
		{
			#if ((flash || js) && debug)
			PV.console.log(["Warning: Using RenderMode.HARDWARE on flash/html5 target may result in corrupt graphics"]);
			#end
		}

		// HTML 5 warning
		#if (js && debug)
		PV.console.log(["Warning: the HTML 5 target is currently experimental"]);
		#end
	}

	/** @private Framerate independent game loop. */
	private function onEnterFrame(e:Event)
	{
		// update timer
		_time = _gameTime = Lib.getTimer();
		PV._systemTime = _time - _systemTime;
		_updateTime = _time;
		PV.elapsed = (_time - _last) / 1000;
		if (PV.elapsed > maxElapsed) PV.elapsed = maxElapsed;
		PV.elapsed *= PV.rate;
		_last = _time;

		// update loop
		if (!paused) update();

		// update console
		if (PV.consoleEnabled()) PV.console.update();

		// update input
		Input.update();

		// update timer
		_time = _renderTime = Lib.getTimer();
		PV._updateTime = _time - _updateTime;

		// render loop
		if (paused) _frameLast = _time; // continue updating frame timer
		else render();

		// update timer
		_time = _systemTime = Lib.getTimer();
		PV._renderTime = _time - _renderTime;
		PV._gameTime = _time - _gameTime;
	}

	/** @private Fixed framerate game loop. */
	private function onTimer()
	{
		// update timer
		_time = Lib.getTimer();
		_delta += (_time - _last);
		_last = _time;

		// quit if a frame hasn't passed
		if (_delta < _rate) return;

		// update timer
		_gameTime = Std.int(_time);
		PV._systemTime = _time - _systemTime;

		// update loop
		if (_delta > _skip) _delta = _skip;
		while (_delta >= _rate)
		{
			PV.elapsed = _rate * PV.rate * 0.001;

			// update timer
			_updateTime = _time;
			_delta -= _rate;
			_prev = _time;

			// update loop
			if (!paused) update();

			// update console
			if (PV.consoleEnabled()) PV.console.update();

			// update input
			Input.update();

			// update timer
			_time = Lib.getTimer();
			PV._updateTime = _time - _updateTime;
		}

		// update timer
		_renderTime = _time;

		// render loop
		if (!paused) render();

		// update timer
		_time = _systemTime = Lib.getTimer();
		PV._renderTime = _time - _renderTime;
		PV._gameTime =  _time - _gameTime;
	}

	/** @private Switch scenes if they've changed. */
	private inline function checkScene()
	{
		if (_scene != null && !_scenes.isEmpty() && _scenes.first() != _scene)
		{
			_scene.end();
			_scene.updateLists();
			if (_scene.autoClear && _scene.hasTween) _scene.clearTweens();
			if (contains(_scene.sprite)) removeChild(_scene.sprite);

			_scene = _scenes.first();

			addChild(_scene.sprite);
			PV.camera = _scene.camera;
			_scene.updateLists();
			_scene.begin();
			_scene.updateLists();
		}
	}

	/**
	 * Push a scene onto the stack. It will not become active until the next update.
	 * @param value  The scene to push
	 */
	public function pushScene(value:Scene):Void
	{
		_scenes.push(value);
	}

	/**
	 * Pop a scene from the stack. The current scene will remain active until the next update.
	 */
	public function popScene():Scene
	{
		return _scenes.pop();
	}

	/**
	 * The currently active Scene object. When you set this, the Scene is flagged
	 * to switch, but won't actually do so until the end of the current frame.
	 */
	public var scene(get, set):Scene;
	private inline function get_scene():Scene { return _scene; }
	private function set_scene(value:Scene):Scene
	{
		if (_scene == value) return value;
		if (_scenes.length > 0)
		{
			_scenes.pop();
		}
		_scenes.push(value);
		return _scene;
	}

	// Scene information.
	private var _scene:Scene = new Scene();
	private var _scenes:List<Scene> = new List<Scene>();

	// Timing information.
	private var _delta:Float;
	private var _time:Float;
	private var _last:Float;
	private var _timer:Timer;
	private var	_rate:Float;
	private var	_skip:Float;
	private var _prev:Float;

	// Debug timing information.
	private var _updateTime:Float;
	private var _renderTime:Float;
	private var _gameTime:Float;
	private var _systemTime:Float;

	// FrameRate tracking.
	private var _frameLast:Float;
	private var _frameListSum:Int;
	private var _frameList:Array<Int>;
}
