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
  public var upgrade:UpgradeBox;
  public var upgradeType:Int;

  public function new(status:Int, cost:Int, upgrade:UpgradeBox, upType:Int) {
    super();

    spritemap = new Spritemap("gfx/upgrade-boxes.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("impossible", [IMPOSSIBLE]);
    spritemap.add("buyable", [BUYABLE]);
    spritemap.add("bought", [BOUGHT]);

    setStatus(status);

    this.graphic = spritemap;

    this.cost = cost;

    this.setHitbox(20, 25);

    this.upgrade = upgrade;

    this.upgradeType = upType;
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
    if (this.collidePoint(this.x, this.y, Input.mouseX, Input.mouseY)) {
      if (Input.mouseReleased) {
        if (spritemap.currentAnim == "impossible") {
          upgrade.notify("You can't do that bro.");
        } else if (spritemap.currentAnim == "bought") {
          upgrade.notify("You already did that, bro.");
        } else if (spritemap.currentAnim == "buyable") {
          if (upgrade.buy(this.upgradeType)) {
            upgrade.notify("Upgrade bought!");
          } else {
            upgrade.notify("Too expensive. :(");
          }
        } else {
          HXP.log("WAT (see UpgradeBoxBox)");
        }
      } else if (spritemap.currentAnim != "bought") {
        upgrade.notify('Costs $cost gold.');
      }
    }
  }
}
