import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class EnemyHealthbar extends Entity {
  var spritemap:Spritemap;
  var follow:Enemy;

  public function new(follow:Enemy) {
    super();

    spritemap = new Spritemap("gfx/healthbar.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("4", [0]); //prob makes no sense to anyone.
    spritemap.add("3", [1]);
    spritemap.add("2", [2]);
    spritemap.add("1", [3]);
    spritemap.add("0", [4]);
    spritemap.play("4");

    this.graphic = spritemap;

    this.follow = follow;

    this.x = follow.x;
    this.y = follow.y;
  }

  public override function update() {
    var which:Int = Math.floor((follow.health() * 4) / follow.maxHealth());
    if (which < 0) which = 0;

    spritemap.play('$which');

    this.x = follow.x;
    this.y = follow.y - 10;
  }

  public function destroy() {
    HXP.scene.remove(this);
    this.graphic = null;
  }
}
