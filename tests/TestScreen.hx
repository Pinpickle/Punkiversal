import com.punkiversal.Engine;
import com.punkiversal.PV;
import com.punkiversal.Scene;

class TestScreen extends haxe.unit.TestCase
{

	public override function setup()
	{
		PV.windowWidth = 320;
		PV.windowHeight = 480;
		var engine = new Engine(PV.windowWidth, PV.windowHeight);
	}

	public function testDefaultSize()
	{
		assertEquals(320, PV.width);
		assertEquals(480, PV.height);
		assertEquals(1.0, PV.screen.scale);
	}

	public function testScale()
	{
		PV.screen.scale = 2;
		PV.resize(PV.windowWidth, PV.windowHeight);
		assertEquals(160, PV.width);
		assertEquals(240, PV.height);
		assertEquals(320, PV.windowWidth);
		assertEquals(480, PV.windowHeight);
	}

	public function testScaleXY()
	{
		PV.screen.scaleX = 2;
		PV.screen.scaleY = 3;
		PV.resize(PV.windowWidth, PV.windowHeight);
		assertEquals(160, PV.width);
		assertEquals(160, PV.height);
	}
}