import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class Healthbar extends Entity {
  var boxes:Array<Entity>;
  private var healthSize:Int = 25;
  private var follow:Player;
  private var numBoxes:Int = 0;
  var boxY:Int = 0;
  var boxX:Int = 0;

  public function new(x:Int, y:Int, follow:Player) {
    super();

    boxes = [];

    this.follow = follow;
    this.boxY = y;
    this.boxX = x;
  }

  public function addBox() {
    var box = new Entity();
    var spritemap = new Spritemap("gfx/health.png", healthSize, healthSize);
    spritemap.add("normal", [0]);
    spritemap.add("half", [1]);
    spritemap.add("gone", [2]);

    box.graphic = spritemap;

    spritemap.play("normal");

    boxes.push(box);

    box.x = this.boxX + numBoxes * 30;
    box.y = this.boxY;

    HXP.scene.add(box);

    ++numBoxes;
  }

  public function setHealth(amt:Int, total:Int) {
    for (box in boxes) {
      var sm = cast(box.graphic, Spritemap);
      if (amt >= 2) {
        sm.play("normal");
      } else if (amt == 1) {
        sm.play("half");
      } else {
        sm.play("gone");
      }

      amt -= 2;
    }
  }

  public override function update() {
    while (follow.totalHealth > numBoxes * 2) {
      addBox();
    }

    setHealth(follow.health, follow.totalHealth);

    super.update();
  }
}
