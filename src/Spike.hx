import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

class Spike extends Enemy {
  private var spritemap:Spritemap;
  private var mainscene:scenes.MainScene;
  private var player:Player;
  private var bulletSpeed:Int = 4;

  public function new() {
    super();

    mainscene = cast(HXP.scene, scenes.MainScene);

    spritemap = new Spritemap("gfx/spike.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("left", [0]);
    spritemap.play("left");

    this.graphic = spritemap;
    this.type = "Spike";
    this.facing = 1;
    this.wantsToShoot = false;
    this._health = 50000000;
    this._maxHealth = 50000000; // good luck!
    this.healthbar.visible = false;
  }

  public override function touchDamage() {
    return 198;
  }

  public override function update() {
    super.update();
  }
}