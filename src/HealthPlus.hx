import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;

class HealthPlus extends Entity {
  private var spritemap:Spritemap;

  private var hasGotten:Bool = false;
  private static var healths:Map<String, Bool>;
  public static var hasEverGotten:Bool = false;
  private var key:String;

  public function new() {
    var ms:scenes.MainScene = cast(HXP.scene, scenes.MainScene);
    var m:GameMap = ms.map;
    var mx:Int = m.mapX;
    var my:Int = m.mapY;

    key = '$mx $my';
    if (healths == null) {
      healths = new Map();
    }

    super();

    spritemap = new Spritemap("gfx/health.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("normal", [3]); //note - not specifying a framerate currently
    spritemap.play("normal");

    this.graphic = spritemap;
    this.type = "HealthPlus";
    this.setHitbox(Constants.SIZE, Constants.SIZE);

    if (!healths.exists(key)) {
      healths.set(key, false);
    }

    if (healths.get(key)) {
      destroy();
    }
  }

  public function get(p:Player) {
    if (!hasGotten) {
      // lol redundancy here too. this is a gold mine of bad coding practice
      healths.set(key, true);
      hasGotten = true;

      var ms:scenes.MainScene = cast(HXP.scene, scenes.MainScene);

      // YOU SMASH THE WALL OF ABSTRACTION WITH YOUR FACE
      p.totalHealth += 1;
      p.health = p.totalHealth;

      // CRITICAL HIT
      ms.hud.healthbar.update();

      this.destroy();

      if (!hasEverGotten) {
        hasEverGotten = true;
        HXP.scene.add(new DialogBox(["You get a +1 health!", "You feel more resilient, and you regain all your health."]));
      }
    }

    spritemap.play("open");
  }
}
