package effects;

import com.punkiversal.Entity;
import com.punkiversal.PV;
import com.punkiversal.graphics.Backdrop;
import com.punkiversal.graphics.Emitter;
import com.punkiversal.graphics.atlas.TextureAtlas;
import com.punkiversal.utils.Input;

class GameScene extends DemoScene
{

	public function new()
	{
		super();

#if !flash
		atlas = TextureAtlas.loadTexturePacker("atlas/assets.xml");
#end

		backdrop = new Backdrop(#if flash "gfx/tile.png" #else atlas.getRegion("tile.png") #end, true, true);
		backdrop.color = 0x555555;
		addGraphic(backdrop);
	}

	public override function begin()
	{
		smoke = new Emitter(#if flash "gfx/smoke.png" #else atlas.getRegion("smoke.png") #end, 16, 16);
		smoke.newType("exhaust", [0]);
		smoke.setMotion("exhaust", 90, 30, 0.5, 360, 10, 0.5);
		smoke.setAlpha("exhaust");

		smokeEntity = addGraphic(smoke);
	}

	public override function end()
	{
#if !flash
		atlas.destroy();
#end
	}

	private function onTouch(touch:com.punkiversal.utils.Touch)
	{
		smoke.emit("exhaust", touch.sceneX, touch.sceneY);
	}

	public override function update()
	{
		if (Input.multiTouchSupported)
		{
			Input.touchPoints(onTouch);
		}
		else
		{
			for (i in 0...10)
			{
				smoke.emit("exhaust", mouseX, mouseY);
			}

			if (Input.mousePressed)
			{
				smoke.setColor("exhaust", PV.rand(16777215), PV.rand(16777215));
			}
		}
		super.update();
	}

	private var atlas:TextureAtlas;
	private var backdrop:Backdrop;
	private var smokeEntity:Entity;
	private var smoke:Emitter;

}