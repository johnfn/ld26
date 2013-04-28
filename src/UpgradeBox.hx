import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.*;
import com.haxepunk.HXP;
import Std;

class UpgradeBox extends Entity {
  var subentities:Array<Entity>;

  public function new() {
    subentities = [];
    super();

    this.x = 100;
    this.y = 100;

    var bgImg = new Image("gfx/upgradebox.png");
    var container:Entity = new Entity();
    container.addGraphic(bgImg);
    HXP.scene.add(container);

    bgImg.x = this.x;
    bgImg.y = this.y;

    subentities.push(container);

    var d1:TextEntity = new TextEntity("Damage: ", true, this.x + 20, this.y + 20);
    HXP.scene.add(d1);

    subentities.push(d1);
  }
}