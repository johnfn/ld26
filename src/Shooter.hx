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

  public override function update() {
    super.update();
  }
}