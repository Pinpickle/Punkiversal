import com.punkiversal.Engine;
import com.punkiversal.PV;

class Main extends Engine
{

	override public function init()
	{
#if debug
	#if flash
		if (flash.system.Capabilities.isDebugger)
	#end
		{
			PV.console.enable();
		}
#end
		PV.scene = new effects.GameScene();
	}

	public static function main() { new Main(); }

}