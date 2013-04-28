import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

class Jumper extends Enemy {
  var spritemap:Spritemap;
  var typicalY:Int;

  var waitLength:Int = 0;
  var destX:Int;
  var startX:Int;
  var jumping:Bool = false;
  var jumpDuration:Int = 300;
  var airTime:Int = 0;
  var mainscene:scenes.MainScene;

  public function new() {
    super();

    mainscene = cast(HXP.scene, scenes.MainScene);

    spritemap = new Spritemap("gfx/jumper.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("normal", [0]);
    spritemap.add("jumping", [1]);
    spritemap.play("normal");

    this.graphic = spritemap;
    this.wantsToShoot = false;
    this.type = "Jumper";
  }

  public override function added() {
    this.typicalY = Std.int(this.y);
  }

  public override function update() {
    super.update();

    if (jumping) {
      ++airTime;
      x = startX + (destX - startX) * (airTime / jumpDuration);
      if (airTime < jumpDuration / 2) {
        y -= 1;
      } else {
        y += 1;
      }
    }

    if (airTime >= jumpDuration) {
      HXP.log("stop jumping");
      jumping = false;
      waitLength = 200;
      airTime = 0;
    }

    if (--waitLength <= 0 && jumping == false) {
      // choose target to jump to.
      destX = Std.random(mainscene.map.mapWidth);
      startX = Std.int(this.x);
      jumping = true;
      jumpDuration = 300;
      airTime = 0;
    }
  }
}