package scenes;

import com.haxepunk.Scene;
import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;
import com.haxepunk.utils.*;

class MainScene extends Scene {
  public var map:GameMap;

  //public var mapEntity:TmxEntity;
  public var player:Player;
  public var minimap:Minimap;
  public var hud:HUD;

  public var paused:Bool = false;

  public var pauser:Entity;

  public function new() {
    super();
  }

  public override function begin() {
    map = new GameMap(0, 0);
    HXP.scene.add(map);

    player = new Player();
    add(player);

    hud = new HUD(player);
    add(hud);

    minimap = new Minimap(150, 150);

    add(minimap);

    var e:Enemy = new Enemy();

    e.x = 200;
    e.y = 200;

    add(e);

    //add(new DialogBox(["Yayaya", "You passed the test!", "And by you, I mean me."]));
    add(new UpgradeBox(player));
  }

  public function pause(pauser:Entity) {
    paused = true;
    this.pauser = pauser;
  }

  public function unpause() {
    paused = false;
  }

  public override function update() {
    if (!paused) {
      super.update();

      if (Input.released(Key.M)) {
        minimap.toggle();
      }
    } else {
      pauser.update();
    }
  }
}