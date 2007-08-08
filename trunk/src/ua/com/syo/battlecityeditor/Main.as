import ua.com.syo.battlecityeditor.screens.Preloader;
import ua.com.syo.battlecityeditor.view.UIManager;
import ua.com.syo.battlecityeditor.controller.Controller;
import ua.com.syo.battlecityeditor.model.Model;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 28 ��� 2007
 */
class ua.com.syo.battlecityeditor.Main 
{
	private static var preloader: Preloader;
	
	// Entry point
	public static function main(): Void 
	{
		Stage.showMenu = false;
		
		preloader = Preloader.create(_root, "preloader", _root.getNextHighestDepth());
		preloader.init();
		
		_root.onEnterFrame = function():Void
		{
			Main.preloader.update(_root.getBytesLoaded(), _root.getBytesTotal());
			if (_root.getBytesLoaded() == _root.getBytesTotal())
			{
				delete _root.onEnterFrame;
				Main.initApp();
			}
		};
	}	
	
	public static function initApp(): Void 
	{
		Main.preloader.remove();
		
		UIManager.create(_root, "uiManager", _root.getNextHighestDepth());
			
		Controller.getInstance();
		Model.getInstance();
       
        
		UIManager.getInstance().init();
		Model.getInstance().init();
		Controller.getInstance().init();
        
		Controller.getInstance().run();
	}
}