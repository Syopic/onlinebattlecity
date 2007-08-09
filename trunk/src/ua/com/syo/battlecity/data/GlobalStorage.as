import ua.com.syo.battlecity.view.UIManager;
import ua.com.syo.battlecity.sound.AllSounds;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 8 ��� 2007
 */
class ua.com.syo.battlecity.data.GlobalStorage 
{
	public static var isLocal: Boolean = false;
	public static var isRandomStages: Boolean = false;
	public static var stagesNum: Number = 35;
	public static var pathToStages: String = "stages/";
	public static var pathToServer: String = "http://www.battlecity.com.ua/srv.php";
	public static var pathToLink: String = "http://battlecity.com.ua/suggest?id=";
	public static var currentStageId: String;
	public static var hiScore: Number = 2000;
	public static var plOneHiScore: Number = 0;
	public static var isLifeAdded: Boolean = false;
	public static var tanksMoveInterval: Number = 15;
	public static var bombsMoveInterval: Number = 5;
	public static var slidingDelay: Number = 40;
	public static var armorDelay: Number = 1000;
	public static var totalShowDelay: Number = 150;
	public static var enemyStoppedDelay: Number = 500;
	public static var blockStuffDelay: Number = 700;
	public static var delayAfterStage: Number = 100;
	public static var bonusViewDelay: Number = 600;
	//	Enemy delays
	public static var showEnemyInterval: Number = 2000;
	public static var enemyShootDelay: Number = 20;
	public static var maxEnemyOnStage: Number = 4;
	public static var enemychangeDirectionDelay: Number = 80;
	//	dynamic global vars
	public static var currentStage: Number;
	public static var lifesNum: Number;
	public static var score: Number;
	public static var currentTankType: Number;
	
	public static function initDynamicVars(): Void
	{
		lifesNum = 3;
		score = 0;
		currentTankType = 0;
	}
	
	public static function addScore(scoreNum: Number): Void
	{
		score += scoreNum;
		if (GlobalStorage.hiScore < GlobalStorage.score && !isLifeAdded)
		{
			AllSounds.getInstance().playGetLife();
			lifesNum++;
			UIManager.getInstance().getStageInstance().infoPanelUpdate();
			isLifeAdded = true;
		}
	}
	
	public static function getRandomStage(): Number
	{
		return (random(1000) + 1);
	}
}