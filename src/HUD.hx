import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class HUD extends Entity {
  // healthbar
  private var healthbar:Healthbar;

  // gun text & shadow
  private var gunText:FancyText;
  private var textHolder:Entity;
  private var gunTextShadow:FancyText;
  private var textShadowHolder:Entity;

  // gun icon
  private var gunIcon:Entity;
  private var gunSize:Int = 25;

  public function new(p:Player) {
    super();

    healthbar = new Healthbar(50, 50, p);
    HXP.scene.add(healthbar);

    gunText = new FancyText("Gun:{255,0,0} *DerpGun*", 50, 85);
    textHolder = new Entity();
    textHolder.graphic = gunText;

    gunTextShadow = new FancyText("{0,0,0}*Gun: DerpGun*", gunText.x + 3, gunText.y + 3);
    textShadowHolder = new Entity();
    textShadowHolder.graphic = gunTextShadow;
    HXP.scene.add(textShadowHolder);
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
