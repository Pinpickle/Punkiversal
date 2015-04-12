import com.punkiversal.Engine;
import com.punkiversal.PV;

class {{PROJECT_CLASS}} extends Engine
{

	override public function init()
	{
#if debug
		PV.console.enable();
#end
		PV.scene = new MainScene();
	}

	public static function main() { new {{PROJECT_CLASS}}(); }

}