import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

class Shooter extends Enemy {
  private var spritemap:Spritemap;
  private var mainscene:scenes.MainScene;
  private var player:Player;
  private var bulletSpeed:Int = 4;

  public function new() {
    super();

    mainscene = cast(HXP.scene, scenes.MainScene);

    spritemap = new Spritemap("gfx/shooter.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("left", [0, 1], true);
    spritemap.play("left", true);

    this.graphic = spritemap;
    this.type = "Shooter";
    this.facing = 1;
  }

  public override function shoot() {
    player = mainscene.player;

    var dx:Float = player.x - this.x;
    var dy:Float = player.y - this.y;
    var norm:Float = Math.sqrt(dx * dx + dy * dy);
    dx /= norm;
    dy /= norm;

    dx *= bulletSpeed;
    dy *= bulletSpeed;

    HXP.log('$dx $dy');

    HXP.scene.add(new Bullet(this, 1, Std.int(dx), Std.int(dy)));
  }

  public override function update() {
    super.update();
  }
}