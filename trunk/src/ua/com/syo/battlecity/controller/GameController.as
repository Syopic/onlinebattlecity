import ua.com.syo.battlecity.view.UIManager;
import ua.com.syo.battlecity.screens.stage.Stage;
import ua.com.syo.battlecity.data.GlobalStorage;
import ua.com.syo.battlecity.screens.stage.CurrentStageData;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 12 ��� 2007
 */
class ua.com.syo.battlecity.controller.GameController 
{
	private static var instance : GameController;
	private var tanksMoveIntervalId : Number;
	private var bombsMoveIntervalId : Number;
	private var showEnemyIntervalId : Number;

	/**
	 * @return singleton instance of GameController
	 */
	public static function getInstance() : GameController 
	{
		if (instance == null)
		{
			instance = new GameController();
		}
		return instance;
	}
	
	public function init():Void
	{
		UIManager.getInstance().addListener(this);
		this.showStage();
		this.showTank();
	}	
	
	public function showStage():Void
	{
		UIManager.getInstance().showStage();
	}
	
	public function showTank():Void
	{
		UIManager.getInstance().getStageInstance().showTank();
		this.tanksMoveEnable();
		this.bombsMoveEnable();
		this.showEnemyEnable();
	}
	
	public function tanksMoveEnable(): Void
	{
		if(this.tanksMoveIntervalId != null) 
		{
			clearInterval(this.tanksMoveIntervalId);
 		}
		this.tanksMoveIntervalId = setInterval(this, "moveAllTanks", GlobalStorage.tanksMoveInterval);
	}
	
	public function bombsMoveEnable(): Void
	{
		if(this.bombsMoveIntervalId != null) 
		{
			clearInterval(this.bombsMoveIntervalId);
 		}
		this.bombsMoveIntervalId = setInterval(this, "moveAllBombs", GlobalStorage.bombsMoveInterval);
	}
	
	public function showEnemyEnable(): Void
	{
		if(this.showEnemyIntervalId != null) 
		{
			clearInterval(this.showEnemyIntervalId);
 		}
		this.showEnemyIntervalId = setInterval(this, "showNextEnemy", GlobalStorage.showEnemyInterval);
	}
	
	public function moveAllTanks(): Void
	{
		UIManager.getInstance().getStageInstance().moveAllTanks();
	}
	
	public function moveAllBombs(): Void
	{
		UIManager.getInstance().getStageInstance().moveAllBombs();
	}
	
	public function showNextEnemy(): Void
	{	
		if (!CurrentStageData.isPause)
		{
			if (CurrentStageData.getEnemyLeft()>0 && CurrentStageData.enemyOnStage<GlobalStorage.maxEnemyOnStage)
			{
				UIManager.getInstance().getStageInstance().showNextEnemy();
				UIManager.getInstance().getStageInstance().infoPanelUpdate();
				
				//trace("ON STAGE: "+CurrentStageData.enemyOnStage);
			}
		}
	}
	
	public function putPlayerBomb(x:Number, y:Number, direction:Number, speed:Number, isFerumErase:Boolean): Void
	{
		UIManager.getInstance().getStageInstance().putPlayerBomb(x, y, direction, speed, isFerumErase);
	}
	
	public function putEnemyBomb(x:Number, y:Number, direction:Number, speed:Number): Void
	{
		UIManager.getInstance().getStageInstance().putEnemyBomb(x, y, direction, speed);
	}
	
	public function putBonus(): Void
	{
		
	}
}