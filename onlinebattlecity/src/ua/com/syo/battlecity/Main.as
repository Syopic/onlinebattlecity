/**
 * @author Krivosheya Sergey
 * www: http://syo.com.ua
 * email: syopic@gmail.com
 * 2006
 */
import ua.com.syo.battlecity.screens.Preloader;
import ua.com.syo.battlecity.view.UIManager;
import ua.com.syo.battlecity.controller.Controller;
import ua.com.syo.battlecity.model.Model;
import ua.com.syo.battlecity.data.GlobalStorage;
import ua.com.syo.battlecity.sound.AllSounds;
/**
 * Main class
 */
class ua.com.syo.battlecity.Main 
{
	private static var preloader: Preloader;
	
	//	Entry point
	public static function main(): Void 
	{
		Stage.showMenu = false;
		preloader = Preloader.create(_root, "preloader", _root.getNextHighestDepth());
		preloader.init();
		preloader._xscale=200;
		preloader._yscale=200;
		
		_root.onEnterFrame = function(): Void
		{
			Main.preloader.update(_root.getBytesLoaded(), _root.getBytesTotal());
			if (_root.getBytesLoaded() == _root.getBytesTotal())
			{
				delete _root.onEnterFrame;
				Main.initApp();
			}
		};
        
		//      get FlashVars
		GlobalStorage.initFlashVars();
		
	}
	
	public static function initApp(): Void 
	{
		var d: Date = new Date();
		// Remove preloader
		Main.preloader.remove();
		//		
		UIManager.create(_root, "uiManager", _root.getNextHighestDepth());
		
		Controller.getInstance();
		Model.getInstance();
        
		UIManager.getInstance().init();
		
		UIManager.getInstance()._xscale=200;
		UIManager.getInstance()._yscale=200;
		
		Model.getInstance().init();
		Controller.getInstance().init();
        
		Controller.getInstance().run();
        
		AllSounds.create(_root, "allSounds", _root.getNextHighestDepth());
		AllSounds.getInstance().init();
//	    AllSounds.getInstance().mute();
	}
}