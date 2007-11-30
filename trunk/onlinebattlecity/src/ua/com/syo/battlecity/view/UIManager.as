/**
 * @author Krivosheya Sergey
 * www: http://syo.com.ua
 * email: syopic@gmail.com
 * 2006
 */
import ua.com.syo.battlecity.screens.SplashMenu;
import ua.com.syo.battlecity.screens.SelectStage;
import ua.com.syo.battlecity.screens.stage.Stage;
import ua.com.syo.battlecity.common.AsBroadcasterI;
import ua.com.syo.battlecity.screens.TotalScreen;
import ua.com.syo.battlecity.screens.stage.CurrentStageData;
import ua.com.syo.battlecity.screens.GameOverScreen;
import ua.com.syo.battlecity.sound.AllSounds;
/**
 * UI Manager/ This is the top movieClip attached on _root
 */
class ua.com.syo.battlecity.view.UIManager extends MovieClip implements AsBroadcasterI
{
	public static var className: String = "__Prototype.ua.com.syo.battlecity.view.UIManager";
	public var classFunction: Function = ua.com.syo.battlecity.view.UIManager;
	private static var instance: UIManager;
	private var splashMenu: SplashMenu;
	private var selectStage: SelectStage;
	private var stage: Stage;
	private var total: TotalScreen;
	private var goScreen: GameOverScreen;
	private var isGameOver: Boolean;
	
	public static function create(clip: MovieClip,name: String,depth: Number,initObject: Object): UIManager
	{
		if(UIManager.instance == undefined)
		{
			registerClass("__Packages.ua.com.syo.battlecity.view.UIManager", UIManager);
			var mc: MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecity.view.UIManager", name, depth, initObject);
			UIManager.instance = UIManager(mc);
			UIManager.instance.buildInstance();
			return UIManager.instance;
		}
		else
		{
			return UIManager.instance;
		}			
	}
	
	/**
	 * returns the singleton;
	 */
	public static function getInstance(): UIManager
	{
		if (instance == null)
		{
			instance = new UIManager();
		}
		return instance;
	}
	
	public function buildInstance(): Void
	{
	}
	
	public function init(): Void
	{
		AsBroadcaster.initialize(this);
	}
	
	public function showSplashMenu(): Void
	{
		//		showGameOverScreen();
		this.splashMenu = SplashMenu.create(this, "splashMenu", this.getNextHighestDepth());
		this.splashMenu.init();
		this.splashMenu.addListener(this);
	}
	
	public function showSelectStage(stage: Number): Void
	{
		this.splashMenu.destroy();
		this.selectStage = SelectStage.create(this, "selectStage", this.getNextHighestDepth());
		this.selectStage.init(stage);
		this.selectStage.addListener(this);
	}
	
	public function showStage(): Void
	{
		this.selectStage.destroy();
		this.stage = Stage.create(this, "stage", this.getNextHighestDepth());
		this.stage.init();
		this.stage.addListener(this);
	}
	
	public function showGameOverScreen(): Void
	{
		
		this.goScreen = GameOverScreen.create(this, "goScreen", this.getNextHighestDepth());
		this.goScreen.init();
		this.goScreen.addListener(this);
	}
	
	public function getStageInstance(): Stage
	{
		return this.stage;
	}
	
	/* ################# EVENTS #####################*/
	/*
	 * event from splashMenu
	 */
	private function onClose(): Void
	{
		this.broadcastMessage("onCloseSplashMenu");
		this.splashMenu.removeListener(this);
	}	
	
	/*
	 * event from selectStage
	 */
	private function onSelectStage(stage: Number): Void
	{
		this.broadcastMessage("onSelectStage", stage);
		this.selectStage.showLoader();
	}	
	
	/*
	 * Stage Complete
	 */
	public function onStageComplete(isSkip: Boolean): Void
	{
		AllSounds.getInstance().stopAllSounds();
		this.isGameOver = false;
		
		this.stage.destroy();
		if (!isSkip)
		{
			this.total = TotalScreen.create(this, "total", this.getNextHighestDepth());
			this.total.init(CurrentStageData.enemyKill_array, false);
			this.total.addListener(this);
		}
		else
		{
			this.broadcastMessage("onCloseTotalScreen", false);
		}
	}
	
	/*
	 * game over
	 */
	public function onGameOver(): Void
	{
		this.isGameOver = true;
		this.total = TotalScreen.create(this, "total", this.getNextHighestDepth());
		this.stage.destroy();
		this.total.init(CurrentStageData.enemyKill_array, true);
		this.total.addListener(this);
	}
	
	/*
	 * on close total screen
	 */
	public function onCloseTotalScreen(): Void
	{
		this.total.destroy();
		this.broadcastMessage("onCloseTotalScreen", this.isGameOver);
	}
	
	public function onCloseGameOverScreen(): Void
	{
		this.goScreen.destroy();
		this.broadcastMessage("onTheEnd");
	}
	
	function addListener(): Boolean 
	{
		return null;
	}
	
	function broadcastMessage(eventName: String): Void 
	{
	}
	
	function removeListener(): Boolean 
	{
		return null;
	}
}