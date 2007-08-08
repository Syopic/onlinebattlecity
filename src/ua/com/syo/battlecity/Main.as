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
class ua.com.syo.battlecity.Main {
	
	private static var preloader:Preloader;
	
	// Entry point
	public static function main(): Void {
		Stage.showMenu = false;
		
		preloader=Preloader.create(_root, "preloader", _root.getNextHighestDepth());
		preloader.init();
		
		_root.onEnterFrame = function(): Void{
            Main.preloader.update(_root.getBytesLoaded(), _root.getBytesTotal());
            if (_root.getBytesLoaded() == _root.getBytesTotal())
            {
                delete _root.onEnterFrame;
                Main.initApp();
			}
        };
        
//      get FlashVars
		if (_root["isRandomStages"])
		{
			GlobalStorage.isRandomStages=true;
		}
		
		if (_root["stagesPath"])
		{
			GlobalStorage.pathToStages=_root["stagesPath"];
		}
		else
		{
			GlobalStorage.pathToStages="";
		}
		
		if (_root["currentStage"])
		{
			GlobalStorage.currentStage=_root["currentStage"];
		}
		else if (!_root["stageId"])
		{
			if (GlobalStorage.isRandomStages)
			{
				GlobalStorage.currentStage=GlobalStorage.getRandomStage();
			}
			else
			{
				GlobalStorage.currentStage=1;
			}
		}
		
		if (_root["stagesNum"])
		{
			GlobalStorage.stagesNum=_root["stagesNum"];
		}
		
		if (_root["stageId"])
		{
			GlobalStorage.currentStageId=_root["stageId"];
//			trace("ID: "+GlobalStorage.currentStageId);
		}
		
        
	}
	
	public static function initApp(): Void {
		var d:Date=new Date();
		if (d.getFullYear()<2008)
		{
			// Remove preloader
			Main.preloader.remove();
	//		
			UIManager.create(_root, "uiManager", _root.getNextHighestDepth());
			
			Controller.getInstance();
	        Model.getInstance();
	        
	        UIManager.getInstance().init();
	        Model.getInstance().init();
	        Controller.getInstance().init();
	        
	        Controller.getInstance().run();
	        
	        AllSounds.create(_root, "allSounds", _root.getNextHighestDepth());
	        AllSounds.getInstance().init();
//	        AllSounds.getInstance().mute();
		}
    }
	
}