import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

// This name is just to troll people, really.

class UpgradeBoxBox extends Entity {
  public static var IMPOSSIBLE:Int = 0;
  public static var BUYABLE:Int = 1;
  public static var BOUGHT:Int = 2;

  public var spritemap:Spritemap;
  public var cost:Int = 0;

  public function new(status:Int, cost:Int) {
    super();

    spritemap = new Spritemap("gfx/upgrade-boxes.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("impossible", [IMPOSSIBLE]);
    spritemap.add("buyable", [BUYABLE]);
    spritemap.add("bought", [BOUGHT]);

    setStatus(status);

    this.graphic = spritemap;

    this.cost = cost;

    this.setHitbox(20, 25);
  }

  public function setStatus(status:Int) {
    if (status == IMPOSSIBLE) {
      spritemap.play("impossible");
    } else if (status == BUYABLE) {
      spritemap.play("buyable");
    } else if (status == BOUGHT) {
      spritemap.play("bought");
    }
  }

  public override function update() {

    if (Input.mouseReleased) {
      HXP.log(spritemap.currentAnim);
      if (this.collidePoint(this.x, this.y, Input.mouseX, Input.mouseY)) {
        if (spritemap.currentAnim == "impossible") {
          HXP.log("You can't do that bro.");
        } else if (spritemap.currentAnim == "bought") {
          HXP.log("You already did that bro.");
        } else if (spritemap.currentAnim == "buyable") {
          HXP.log("You can totally do that, bro");
        } else {
          HXP.log("WAT (see UpgradeBoxBox)");
        }
      }
    }
  }
}
