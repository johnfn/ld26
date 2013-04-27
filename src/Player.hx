import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;

class Player extends Entity {
  private var spritemap:Spritemap;
  private var playerWidth:Int = 25;
  private var playerHeight:Int = 25;

  public function new() {
    super();

    spritemap = new Spritemap("gfx/player.png", playerWidth, playerHeight);
    spritemap.add("normal", [0]); //note - not specifying a framerate currently
    spritemap.play("normal");

    this.graphic = spritemap;
    this.setHitbox(playerWidth, playerHeight);

    this.x = 50;
    this.y = 50;
  }

  public override function update() {
    var vx:Int = 0;
    var vy:Int = 0;

    if (Input.check(Key.D)) {
      vx += 3;
    }

    if (Input.check(Key.A)) {
      vx -= 3;
    }
  }
}