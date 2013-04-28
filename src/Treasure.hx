import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;

class Treasure extends Entity {
  private var spritemap:Spritemap;
  private static var statuses:Map<String, Bool>;
  private var key:String;

  public function new() {
    var ms:scenes.MainScene = cast(HXP.scene, scenes.MainScene);
    var m:GameMap = ms.map;
    var mx:Int = m.mapX;
    var my:Int = m.mapY;

    key = '$mx $my';
    if (statuses == null) {
      statuses = new Map();
    }

    super();

    spritemap = new Spritemap("gfx/treasure.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("normal", [0]); //note - not specifying a framerate currently
    spritemap.add("open", [1]); //note - not specifying a framerate currently
    spritemap.play("normal");

    this.graphic = spritemap;
    this.type = "Treasure";
    this.setHitbox(Constants.SIZE, Constants.SIZE);


    if (!statuses.exists(key)) {
      statuses.set(key, false);
    }

    if (statuses.get(key)) {
      open();
    }
  }

  public function open() {
    statuses.set(key, true);
    spritemap.play("open");
  }
}
