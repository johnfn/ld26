import com.haxepunk.Engine;
import com.haxepunk.HXP;
import scenes.*;

class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		HXP.scene = new MainScene();
	}

	public static function main() {
    new Main();
  }

}