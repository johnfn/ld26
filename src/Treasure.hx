import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;

class Treasure extends Entity {
  private var spritemap:Spritemap;

  public function new() {
    super();

    spritemap = new Spritemap("gfx/treasure.png", Constants.SIZE, Constants.SIZE);
    spritemap.add("normal", [0]); //note - not specifying a framerate currently
    spritemap.add("open", [1]); //note - not specifying a framerate currently
    spritemap.play("normal");

    this.graphic = spritemap;
    this.type = "Treasure";
    this.setHitbox(Constants.SIZE, Constants.SIZE);
  }

  public function open() {
    spritemap.play("open");
  }
}
