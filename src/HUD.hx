import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;

class HUD extends Entity {
  private var player:Player;

  // healthbar
  public var healthbar:Healthbar;

  // gun text & shadow
  private var gunText:FancyText;
  private var textHolder:Entity;
  private var gunTextShadow:FancyText;
  private var textShadowHolder:Entity;

  // gun icon
  private var gunIcon:Entity;
  private var gunSize:Int = 25;

  // coin text & shadow
  private var coinText:FancyText;
  private var coinTextHolder:Entity;
  private var coinTextShadow:FancyText;
  private var coinTextShadowHolder:Entity;

  public function new(p:Player) {
    super();

    player = p;

    healthbar = new Healthbar(0, 0, p);
    HXP.scene.add(healthbar);

    gunText = new FancyText("Gun:{255,195,195} *Unarmed!*", 30, 35);
    textHolder = new Entity();
    textHolder.graphic = gunText;

    gunTextShadow = new FancyText("{0,0,0}*Gun: Unarmed!*", gunText.x + 2, gunText.y + 2);
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
    gunIcon.x = 0;
    gunIcon.y = 30;

    HXP.scene.add(gunIcon);

    coinText = new FancyText("Coins: 0", HXP.width - 100, 0, 100, 50, {align: nme.text.TextFormatAlign.RIGHT, color: 0xffffff});
    coinTextHolder = new Entity();
    coinTextHolder.graphic = coinText;

    coinTextShadow = new FancyText("Coins: 0", HXP.width - 100 + 2, 0 + 2, 100, 50, {align: nme.text.TextFormatAlign.RIGHT, color: 0});
    coinTextShadowHolder = new Entity();
    coinTextShadowHolder.graphic = coinTextShadow;

    HXP.scene.add(coinTextShadowHolder);
    HXP.scene.add(coinTextHolder);
  }

  public function setGunType(s:String) {
    gunText.text = 'Gun: $s';
    gunTextShadow.text = '{0,0,0}*Gun: $s*';

    cast(gunIcon.graphic, Spritemap).play("2"); //quite a bit of a hack!
  }

  public override function update() {
    coinText.text = 'Coins: ${player.coins}';
    coinTextShadow.text = 'Coins: ${player.coins}';
    super.update();
  }
}
