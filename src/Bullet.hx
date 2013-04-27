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

  public function new(spawner:Entity, dirX:Int, dirY:Int) {
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
  }

  function genericCollide(e:Entity) {
    if (e.type == "walls") {
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
    this.moveBy(this.dirX, this.dirY, "walls");
  }
}