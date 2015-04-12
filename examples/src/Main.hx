import com.punkiversal.Engine;
import com.punkiversal.HXP;

class Main extends Engine
{

	override public function init()
	{
#if debug
	#if flash
		if (flash.system.Capabilities.isDebugger)
	#end
		{
			HXP.console.enable();
		}
#end
		HXP.scene = new effects.GameScene();
	}

	public static function main() { new Main(); }

}