import com.punkiversal.Engine;
import com.punkiversal.Entity;
import com.punkiversal.Graphic;
import com.punkiversal.PV;
import com.punkiversal.Mask;
import com.punkiversal.RenderMode;
import com.punkiversal.Scene;
import com.punkiversal.Screen;
import com.punkiversal.Sfx;
import com.punkiversal.Tweener;
import com.punkiversal.Tween;
import com.punkiversal.World;
import com.punkiversal.debug.Console;
import com.punkiversal.debug.LayerList;
import com.punkiversal.graphics.Animation;
import com.punkiversal.graphics.Backdrop;
import com.punkiversal.graphics.BitmapText;
import com.punkiversal.graphics.Canvas;
import com.punkiversal.graphics.Emitter;
import com.punkiversal.graphics.Graphiclist;
import com.punkiversal.graphics.Image;
import com.punkiversal.graphics.Particle;
import com.punkiversal.graphics.ParticleType;
import com.punkiversal.graphics.PreRotation;
import com.punkiversal.graphics.Spritemap;
import com.punkiversal.graphics.Stamp;
import com.punkiversal.graphics.Text;
import com.punkiversal.graphics.TiledImage;
import com.punkiversal.graphics.TiledSpritemap;
import com.punkiversal.graphics.Tilemap;
import com.punkiversal.graphics.atlas.AtlasData;
import com.punkiversal.graphics.atlas.Atlas;
import com.punkiversal.graphics.atlas.AtlasRegion;
import com.punkiversal.graphics.atlas.BitmapFontAtlas;
import com.punkiversal.graphics.atlas.TextureAtlas;
import com.punkiversal.graphics.atlas.TileAtlas;
import com.punkiversal.masks.Circle;
import com.punkiversal.masks.Grid;
import com.punkiversal.masks.Hitbox;
import com.punkiversal.masks.Imagemask;
import com.punkiversal.masks.Masklist;
import com.punkiversal.masks.Pixelmask;
import com.punkiversal.masks.Polygon;
import com.punkiversal.masks.SlopedGrid;
import com.punkiversal.math.Projection;
import com.punkiversal.math.Vector;
import com.punkiversal.tweens.TweenEvent;
import com.punkiversal.tweens.misc.Alarm;
import com.punkiversal.tweens.misc.AngleTween;
import com.punkiversal.tweens.misc.ColorTween;
import com.punkiversal.tweens.misc.MultiVarTween;
import com.punkiversal.tweens.misc.NumTween;
import com.punkiversal.tweens.misc.VarTween;
import com.punkiversal.tweens.motion.CircularMotion;
import com.punkiversal.tweens.motion.CubicMotion;
import com.punkiversal.tweens.motion.LinearMotion;
import com.punkiversal.tweens.motion.LinearPath;
import com.punkiversal.tweens.motion.Motion;
import com.punkiversal.tweens.motion.QuadMotion;
import com.punkiversal.tweens.motion.QuadPath;
import com.punkiversal.tweens.sound.Fader;
import com.punkiversal.tweens.sound.SfxFader;
import com.punkiversal.utils.Data;
import com.punkiversal.utils.Draw;
import com.punkiversal.utils.Ease;
import com.punkiversal.utils.Input;
import com.punkiversal.utils.Joystick;
import com.punkiversal.utils.Key;
import com.punkiversal.utils.Touch;

/**
 * Empty test.
 * Import all of Punkiversal classes to make sure everything compile,
 * and that all used openfl functionalities exists.
 */
class TestImport extends haxe.unit.TestCase
{
	public override function setup()
	{
	}

	public override function tearDown()
	{
	}
}
