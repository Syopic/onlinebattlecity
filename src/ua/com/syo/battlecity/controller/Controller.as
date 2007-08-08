import ua.com.syo.battlecity.view.UIManager;
import ua.com.syo.battlecity.model.Model;
import ua.com.syo.battlecity.data.GlobalStorage;
import ua.com.syo.battlecity.controller.GameController;
import ua.com.syo.battlecity.sound.AllSounds;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 8 ��� 2007
 */
class ua.com.syo.battlecity.controller.Controller 
{
	private static var instance: Controller;
	private var so: SharedObject;
	
	/**
	 * @return singleton instance of Controller
	 */
	public static function getInstance(): Controller 
	{
		if (instance == null)
		{
			instance = new Controller();
		}
		return instance;
	}
	
	public function init(): Void
	{
		UIManager.getInstance().addListener(this);
		Model.getInstance().addListener(this);
	}
	
	public function run(): Void
	{
		if (this.getStoreHiScore() > GlobalStorage.hiScore)
		{
			GlobalStorage.hiScore = this.getStoreHiScore();
		}
		
		GlobalStorage.initDynamicVars();
		if (_root["currentStage"])
		{
			this.onSelectStage(GlobalStorage.currentStage);
		}
		else
		if (_root["stageId"])
		{
			GlobalStorage.currentStage = 0;
			this.onIdStage(GlobalStorage.currentStageId);
		}
		else
		{
			UIManager.getInstance().showSplashMenu();
		}
	}
	
	public function onCloseSplashMenu(): Void
	{
		UIManager.getInstance().showSelectStage(GlobalStorage.currentStage);
	}	
	
	public function onSelectStage(stage: Number): Void
	{
		Model.getInstance().getMapByStageNum(stage);
		GlobalStorage.currentStage = stage;
	}	
	
	public function onIdStage(id: String): Void
	{
		Model.getInstance().getMapById(id);
	}	
	
	private function onStageLoad(): Void
	{
		GameController.getInstance().init();
		AllSounds.getInstance().playIntro();
	}
	
	public function onCloseTotalScreen(isGO: Boolean): Void
	{
		_root["stageId"] = undefined;
		if (isGO)
		{
			UIManager.getInstance().showGameOverScreen();
			_root["currentStage"] = undefined;
			if (GlobalStorage.isRandomStages)
			{
				GlobalStorage.currentStage = GlobalStorage.getRandomStage();
			}
			else
			{
				GlobalStorage.currentStage = 1;
			}
		}
		else
		{
			if (GlobalStorage.isRandomStages)
			{
				GlobalStorage.currentStage = GlobalStorage.getRandomStage();
			}
			else
			{
				GlobalStorage.currentStage++;
				if (GlobalStorage.currentStage > GlobalStorage.stagesNum)
				{
					GlobalStorage.currentStage = 1;
				}
			}
			UIManager.getInstance().showSelectStage(GlobalStorage.currentStage);
		}
	}
	
	public function onTheEnd(): Void
	{
		if (GlobalStorage.hiScore < GlobalStorage.score)
		{
			this.setSharedObject(GlobalStorage.score);
			GlobalStorage.plOneHiScore = GlobalStorage.score;
		}
		this.run();
	}
	
	private function getSharedObject(): SharedObject 
	{
		so = SharedObject.getLocal("battlecity", "/");
		return so;
	}
	
	private function setSharedObject(hiscore: Number): Void
	{
		this.getSharedObject();
		this.so.data["hiscore"] = hiscore;
		so.flush(1000);
	}
	
	private function getStoreHiScore(): Number 
	{
		var so: SharedObject = getSharedObject();
		return Number(so.data["hiscore"]);
	}
}