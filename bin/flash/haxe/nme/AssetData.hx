package nme;


import nme.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("gfx/debug/console_debug.png", nme.NME_gfx_debug_console_debug_png);
			type.set ("gfx/debug/console_debug.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/debug/console_logo.png", nme.NME_gfx_debug_console_logo_png);
			type.set ("gfx/debug/console_logo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/debug/console_output.png", nme.NME_gfx_debug_console_output_png);
			type.set ("gfx/debug/console_output.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/debug/console_pause.png", nme.NME_gfx_debug_console_pause_png);
			type.set ("gfx/debug/console_pause.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/debug/console_play.png", nme.NME_gfx_debug_console_play_png);
			type.set ("gfx/debug/console_play.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/debug/console_step.png", nme.NME_gfx_debug_console_step_png);
			type.set ("gfx/debug/console_step.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/preloader/haxepunk.png", nme.NME_gfx_preloader_haxepunk_png);
			type.set ("gfx/preloader/haxepunk.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("font/04B_03__.ttf", nme.NME_font_04b_03___ttf);
			type.set ("font/04B_03__.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("gfx/boom.png", nme.NME_gfx_boom_png);
			type.set ("gfx/boom.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/bullet.png", nme.NME_gfx_bullet_png);
			type.set ("gfx/bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/bullet2.png", nme.NME_gfx_bullet2_png);
			type.set ("gfx/bullet2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/coin.png", nme.NME_gfx_coin_png);
			type.set ("gfx/coin.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/dialogbox.png", nme.NME_gfx_dialogbox_png);
			type.set ("gfx/dialogbox.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/enemy-shooter.png", nme.NME_gfx_enemy_shooter_png);
			type.set ("gfx/enemy-shooter.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/guns.png", nme.NME_gfx_guns_png);
			type.set ("gfx/guns.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/health.png", nme.NME_gfx_health_png);
			type.set ("gfx/health.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/healthbar.png", nme.NME_gfx_healthbar_png);
			type.set ("gfx/healthbar.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/jumper.png", nme.NME_gfx_jumper_png);
			type.set ("gfx/jumper.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/ladder.png", nme.NME_gfx_ladder_png);
			type.set ("gfx/ladder.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/minimap.png", nme.NME_gfx_minimap_png);
			type.set ("gfx/minimap.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/player.png", nme.NME_gfx_player_png);
			type.set ("gfx/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/shooter.png", nme.NME_gfx_shooter_png);
			type.set ("gfx/shooter.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/signpost.png", nme.NME_gfx_signpost_png);
			type.set ("gfx/signpost.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/spike.png", nme.NME_gfx_spike_png);
			type.set ("gfx/spike.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/tilesheet.png", nme.NME_gfx_tilesheet_png);
			type.set ("gfx/tilesheet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/treasure.png", nme.NME_gfx_treasure_png);
			type.set ("gfx/treasure.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/upgrade-boxes.png", nme.NME_gfx_upgrade_boxes_png);
			type.set ("gfx/upgrade-boxes.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/upgradebox.png", nme.NME_gfx_upgradebox_png);
			type.set ("gfx/upgradebox.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("gfx/walker.png", nme.NME_gfx_walker_png);
			type.set ("gfx/walker.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("maps/map.tmx", nme.NME_maps_map_tmx);
			type.set ("maps/map.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			className.set ("sfx/ld26.mp3", nme.NME_sfx_ld26_mp3);
			type.set ("sfx/ld26.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("font/04B_03__.ttf", nme.NME_font_5);
			type.set ("font/04B_03__.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_gfx_debug_console_debug_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_logo_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_output_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_pause_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_play_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_step_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_preloader_haxepunk_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_font_04b_03___ttf extends nme.text.Font { }
class NME_gfx_boom_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_bullet_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_bullet2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_coin_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_dialogbox_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_enemy_shooter_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_guns_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_health_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_healthbar_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_jumper_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_ladder_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_minimap_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_player_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_shooter_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_signpost_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_spike_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_tilesheet_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_treasure_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_upgrade_boxes_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_upgradebox_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_walker_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_maps_map_tmx extends nme.utils.ByteArray { }
class NME_sfx_ld26_mp3 extends nme.media.Sound { }
class NME_font_5 extends nme.text.Font { }
