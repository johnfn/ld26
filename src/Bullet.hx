import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class Bullet extends Entity {
  private var bulletWidth:Int = 25;
  private var bulletHeight:Int = 25;

  private var dirX:Int = 0;
  private var dirY:Int = 0;

  private var sourceType:String = "";
  private var damage:Int;

  public function new(spawner:Entity, damage:Int, dirX:Int, dirY:Int) {
    super();

    this.x = spawner.x;
    this.y = spawner.y;

    this.dirX = dirX;
    this.dirY = dirY;

    var spritemap = new Spritemap("gfx/bullet.png", bulletWidth, bulletHeight);
    spritemap.add("normal", [0]); //note - not specifying a framerate currently
    spritemap.play("normal");

    this.graphic = spritemap;

    this.setHitbox(bulletWidth, bulletHeight); // prob unfair
    this.sourceType = spawner.type;

    this.damage = damage;
  }

  function genericCollide(e:Entity) {
    if (e.type == "wall") {
      destroy();
    }

    // we guaranteed that bullets wont be blocked by their source shooter
    // down below so these checks are fine.

    if (e.type == "enemy") {
      var en:Enemy = cast(e, Enemy);
      en.damage(this.damage);
      HXP.scene.add(new FloatingText('-$damage', Std.int(en.x), Std.int(en.y)));

      destroy();
    }

    if (e.type == "player") {
      var p:Player = cast(e, Player);
      p.damage(this.damage);

      HXP.scene.add(new FloatingText('-$damage', Std.int(p.x), Std.int(p.y)));

      destroy();
    }
  }

  public function destroy() {
    HXP.scene.remove(this);
    this.graphic = null;
  }

  public override function moveCollideX(e:Entity):Bool {
    genericCollide(e);

    return true;
  }

  public override function moveCollideY(e:Entity):Bool {
    genericCollide(e);

    return true;
  }

  public override function update() {
    var blockers:Array<String> = ["wall"];

    if (this.sourceType == "enemy") {
      blockers.push("player");
    } else {
      blockers.push("enemy");
    }

    this.moveBy(this.dirX, this.dirY, blockers);

    var scene:scenes.MainScene = cast(HXP.scene, scenes.MainScene);

    if (!scene.map.contains(this)) {
      destroy();
    }
  }
}