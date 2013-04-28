import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

class Walker extends Enemy {
  private var speed:Int = 3;
  private var spritemap:Spritemap;
  private var mainscene:scenes.MainScene;

  public function new() {
    super();

    mainscene = cast(HXP.scene, scenes.MainScene);

    spritemap = new Spritemap("gfx/walker.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("left", [0, 1]);
    spritemap.add("right", [2, 3]);
    spritemap.play("left");

    this.graphic = spritemap;
    this.type = "Walker";
    this.facing = 1;
  }

  private function genericCollision(e:Entity):Bool {
    if (e.type == "wall") {
      facing *= -1;
    }

    return true;
  }

  public override function moveCollideX(e:Entity):Bool {
    return genericCollision(e);
  }

  public override function moveCollideY(e:Entity):Bool {
    return genericCollision(e);
  }

  public override function update() {
    if (health() > 0) {
      this.moveBy(facing * this.speed, 0, ["wall"], true);
    }

    super.update();
  }
}