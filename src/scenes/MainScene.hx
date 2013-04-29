package scenes;

import com.haxepunk.Scene;
import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.Entity;
import com.haxepunk.utils.*;
import com.haxepunk.Sfx;

class MainScene extends Scene {
  public var map:GameMap;

  //public var mapEntity:TmxEntity;
  public var player:Player;
  public var minimap:Minimap;
  public var hud:HUD;

  public var paused:Bool = false;

  public var pauser:Entity;

  public var sfx:Sfx;

  public function new() {
    super();
  }

  public override function begin() {
    sfx = new Sfx("sfx/ld26.mp3");
    sfx.loop();
    if (!Constants.DEBUG) {
      map = new GameMap(2, 0);
    } else {
      map = new GameMap(2, 0);
    }
    HXP.scene.add(map);

    player = new Player();
    add(player);

    hud = new HUD(player);
    add(hud);

    minimap = new Minimap(150, 150);

    add(minimap);

    add(new UpgradeBox(player));
    add(new DialogBox(["You come to!", "You have no idea how you got here, but you're seized with the desire to minimalize the number of enemies in the world.", "But you are such a minimalistic person, you don't even own a gun...", "So your desire may have to wait.", "*Arrow keys* to move and *X* to jump."]));
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