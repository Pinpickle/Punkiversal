import com.punkiversal.utils.HaxelibInfo;

class Setup
{
	public static function setup()
	{
		installDependencies();
		Sys.command('haxelib run $OPENFL setup');
	}

	public static function update()
	{
		Sys.command("haxelib update Punkiversal");
		installDependencies();
	}

	public static function installDependencies()
	{
		for (field in Reflect.fields(HaxelibInfo.install))
		{
			Sys.command("haxelib install " + field + " " + Reflect.field(HaxelibInfo.install, field));
		}
	}

	private static inline var OPENFL = "lime";
}
