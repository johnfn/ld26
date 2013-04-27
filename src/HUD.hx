import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class HUD extends Entity {
  private var healthbar:Healthbar;
  private var gunText:FancyText;
  private var textHolder:Entity;
  private var gunIcon:Entity;
  private var gunSize:Int = 25;

  public function new() {
    super();

    healthbar = new Healthbar(50, 50);
    gunText = new FancyText("Gun: {255,0,0} *DerpGun*", 50, 85);
    textHolder = new Entity();
    textHolder.graphic = gunText;
    HXP.scene.add(textHolder);

    var spritemap = new Spritemap("gfx/guns.png", gunSize, gunSize);
    spritemap.add("1", [0]);
    spritemap.add("2", [1]);
    spritemap.add("3", [2]);

    gunIcon = new Entity();
    gunIcon.graphic = spritemap;
    gunIcon.x = 25;
    gunIcon.y = 80;

    HXP.scene.add(gunIcon);
  }

  public override function update() {

    super.update();
  }
}
