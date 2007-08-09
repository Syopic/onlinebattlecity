import ua.com.syo.battlecity.screens.stage.InfoPanelView;
import ua.com.syo.battlecity.screens.stage.StageMapView;
import ua.com.syo.battlecity.screens.stage.Tank;
import ua.com.syo.battlecity.screens.stage.Bomb;
import ua.com.syo.battlecity.screens.stage.Enemy;
import ua.com.syo.battlecity.screens.stage.CurrentStageData;
import ua.com.syo.battlecity.data.GlobalStorage;
import ua.com.syo.battlecity.components.NESTextField;
import ua.com.syo.battlecity.common.AsBroadcasterI;
import ua.com.syo.battlecity.screens.stage.Bonus;
import ua.com.syo.battlecity.sound.AllSounds;
import ua.com.syo.battlecity.data.DataLabels;
import ua.com.syo.battlecity.model.Model;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 7 ��� 2007
 */
class ua.com.syo.battlecity.screens.stage.Stage extends MovieClip implements AsBroadcasterI
{
	private var closerTop: MovieClip;
	private var closerBottom: MovieClip;
	private var infoPanelView: InfoPanelView;
	private var stageMap: StageMapView;
	private var tank: Tank;
	private var gameOver: MovieClip;
	private var goText1: NESTextField;
	private var goText2: NESTextField;
	private var skipText: NESTextField;
	private var pause_tf: NESTextField;
	private var playerBombArray: Array;
	private var enemyBombArray: Array;
	private var playerBombDepth: Number = 0;
	private var enemyBombDepth: Number = 0;
	private var bonus: Bonus;
	private var currentPortalForShowEnemy: Number = 2;
	private var enemyIncr: Number = 0;
	private var enemyArray: Array;
	private var isGameOver: Boolean = false;
	private var isEnemyStopped: Boolean = false;
	private var enemyStoppedDelay: Number;
	private var blockStuffDelay: Number;
	private var beginLifesNum: Number;
	private var beginScore: Number;
	private var beginCurrentTankType: Number;
	private var isSoundEnable: Boolean = true;
	
	public static function create(clip: MovieClip,name: String,depth: Number,initObject: Object): Stage
	{
		registerClass("__Packages.ua.com.syo.battlecity.screens.stage.Stage", Stage);
		var instance: MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.stage.Stage", name, depth, initObject);
		var classInstance: Stage = Stage(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance(): Void
	{
		this.stageMap = StageMapView.create(this, "stage", this.getNextHighestDepth());
		this.stageMap._x = 16;
		this.stageMap._y = 8;
		
		this.infoPanelView = InfoPanelView.create(this, "nfoPanelView", this.getNextHighestDepth());
		
		this.closerTop = this.attachMovie("closer", "closerTop", this.getNextHighestDepth());
		this.closerBottom = this.attachMovie("closer", "closerBottom", this.getNextHighestDepth());
		this.closerTop._y = 0;
		this.closerBottom._y = 113;
		
		this.gameOver = this.createEmptyMovieClip("gameOver", this.getNextHighestDepth());
		this.goText1 = NESTextField.create(this.gameOver, "goText1", this.gameOver.getNextHighestDepth());
		this.goText2 = NESTextField.create(this.gameOver, "goText2", this.gameOver.getNextHighestDepth());
		
		this.pause_tf = NESTextField.create(this, "pause_tf", this.getNextHighestDepth());
		
		this.skipText = NESTextField.create(this, "skipText", this.getNextHighestDepth());
	}
	
	public function init(): Void
	{
		AsBroadcaster.initialize(this);
		
		this.playerBombArray = new Array();
		this.enemyArray = new Array();
		
		this.infoPanelView.init();
		
		this.stageMap.init();
		this.stageMap.drawStage();
		this.openStage();
		
		this.tank = Tank.create(this.stageMap.getTankContainer(), "tank", this.stageMap.getTankContainer().getNextHighestDepth());
		
		this.goText1.init(105, 98, "game", 0xD82800);
		this.goText2.init(105, 106, "over", 0xD82800);
		
		this.pause_tf.init(101, 113, "pause", 0xD82800);
		this.pause_tf._visible = false;
		
		this.gameOver._visible = false;
		
		this.skipText.init(17, 220, DataLabels.STAGE_SKIP, 0x555555, true);
		
		beginLifesNum = GlobalStorage.lifesNum;
		beginScore = GlobalStorage.score;
		beginCurrentTankType = GlobalStorage.currentTankType;	
		
		Key.addListener(this);
//		
	}
	
	private function openStage(): Void
	{
		var $scope: Stage = this;
		this.onEnterFrame = function():Void 
		{
			if ($scope.closerBottom._y < 233) 
			{ 
				$scope.closerTop._y -= 5;
				$scope.closerBottom._y += 5;
			} else 
			{
				delete $scope.onEnterFrame;
			}
		};
	}
	
	public function showTank(): Void
	{
		this.tank.init(GlobalStorage.currentTankType);
	}
	
	public function showNextEnemy(): Void
	{
		var flag: Boolean = false;
		var x: Number = 0;
		
			
		switch(this.currentPortalForShowEnemy)
		{
			case 1:
				if (CurrentStageData.checkBarrierForTank(0, 0))
				{
					x = 0;
					flag = true;
				}
				
				break;
			case 2:
				if (CurrentStageData.checkBarrierForTank(12, 0))
				{
					x = 96;
					flag = true;
				}
				break;
			case 3:
				if (CurrentStageData.checkBarrierForTank(24, 0))
				{
					x = 192;
					flag = true;
				}
				break;
		}
		
	
		this.currentPortalForShowEnemy++;
		if (this.currentPortalForShowEnemy > 3)
		{
			this.currentPortalForShowEnemy = 1;
		}
		
		if (flag)
		{
			
			if (enemyIncr == CurrentStageData.getEnemyNum())
			{
				enemyIncr = 0;
			}
			
			CurrentStageData.enemyOnStage++;
			
			var enemy: Enemy = Enemy.create(this.stageMap.getEnemyContainer(), "enemy" + enemyIncr, enemyIncr);
			enemyIncr++;
			enemy.init(x, CurrentStageData.getNextEnemy());
		}
	}	
	
	public function moveAllTanks(): Void
	{
		if (!CurrentStageData.isPause)
		{
			this.tank.move();
			for (var i: Number = 0;i < CurrentStageData.getEnemyNum(); i++)
			{
				if (Enemy(this.stageMap.getEnemyContainer()["enemy" + i]).getStatus() == "tank")
				{
					Enemy(this.stageMap.getEnemyContainer()["enemy" + i]).move(this.isEnemyStopped);
				}
			}
			updateAfterEvent();
		}
	}
	
	public function moveAllBombs(): Void
	{
		if (!CurrentStageData.isPause)
		{
			for (var i: Number = 0;i < 3; i++)
			{
				if (Bomb(this.stageMap.getPlayerBombContainer()["bomb" + i]))
				{
					CurrentStageData.checkBombColision(Bomb(this.stageMap.getPlayerBombContainer()["bomb" + i]));
					Bomb(this.stageMap.getPlayerBombContainer()["bomb" + i]).move();
				}
			}
			for (var j: Number = 0;j < 20; j++)
			{
				Bomb(this.stageMap.getEnemyBombContainer()["bomb" + j]).move();
			}
			
			updateAfterEvent();
		}
	}
	
	public function putPlayerBomb(x: Number, y: Number, direction: Number, speed: Number, isFerumErase: Boolean): Void
	{
		if (!this.gameOver._visible)
		{
			this.playerBombDepth++;
			if (this.playerBombDepth == 3)
			{
				this.playerBombDepth = 0;
			}
			var bomb: Bomb = Bomb.create(this.stageMap.getPlayerBombContainer(), "bomb" + this.playerBombDepth, this.playerBombDepth);
			bomb.init(x, y, direction, speed, true, isFerumErase);
		}
	}
	
	public function putEnemyBomb(x: Number, y: Number, direction: Number, speed: Number): Void
	{
		this.enemyBombDepth++;
		if (this.enemyBombDepth == 20)
		{
			this.enemyBombDepth = 0;
		}
		var bomb: Bomb = Bomb.create(this.stageMap.getEnemyBombContainer(), "bomb" + this.enemyBombDepth, this.enemyBombDepth);
		bomb.init(x, y, direction, speed);
	}	
	
	public function showBlast(x: Number, y: Number, type: String): Void
	{
		var path: MovieClip = this.stageMap.getBlastContainer();
		path.attachMovie(type, "e" + path.getNextHighestDepth(), path.getNextHighestDepth(), {_x:x, _y:y});
	}
	
	public function showScore(x: Number, y: Number, value: Number): Void
	{
		var path: MovieClip = this.stageMap.getBlastContainer();
		path.attachMovie("score_" + value, "s" + path.getNextHighestDepth(), path.getNextHighestDepth(), {_x:x, _y:y});
	}
	
	/*
	 * put bonus randomly on stage
	 */
	public function putBonus(): Void
	{
		//		destroy old bonus
		bonus.destroy();
		bonus = Bonus.create(this.stageMap.getBonusContainer(), "bonus", this.stageMap.getBonusContainer().getNextHighestDepth());
		for (var i: Number = 0;i < 10; i++)
		{
			var x: Number = random(20) + 2;
			var y: Number = random(20) + 2;
			if (i == 9 || (!CurrentStageData.checkBonusCollision() && Array(CurrentStageData.stageMap_array[x])[y] != "b" && Array(CurrentStageData.stageMap_array[x + 1])[y + 1] != "b" && Array(CurrentStageData.stageMap_array[x])[y] != "w"))
			{
				
				bonus.init(random(20) + 2, random(20) + 2, random(6));
				break;
			}
		}
		
		//				global bonus instance. instanse every one
		CurrentStageData.setBonusInstance(bonus);
		AllSounds.getInstance().playSetBonus();
	}
	
	public function onCheckBonus(): Void
	{
		var type: Number = bonus.getType();
		this.showScore(bonus.getX() * 8, bonus.getY() * 8, 500);
		GlobalStorage.addScore(500);
		bonus.destroy();
		AllSounds.getInstance().playStar();
		switch (type)
		{
			case 0:
				this.tank.upRank();
				break;
			
			case 1:
				this.bonusDestroyAllEnemy();
				AllSounds.getInstance().playKill();
				break;
			
			case 2:
				this.bonusLifeAdd();
				break;
			
			case 3:
				this.bonusSetArmor();
				break;
			
			case 4:
				this.bonusStopTime();
				break;
			
			case 5:
				this.bonusBlockStuff();
				break;
		}
	}
	
	public function bonusDestroyAllEnemy(): Void
	{
		for (var i: Number = 0;i < CurrentStageData.getEnemyNum(); i++)
		{
			if (Enemy(this.stageMap.getEnemyContainer()["enemy" + i]).getStatus() == "tank")
			{
				CurrentStageData.destroyEnemy(this.stageMap.getEnemyContainer()["enemy" + i], true);
			}
		}
	}
	
	public function bonusLifeAdd(): Void
	{
		AllSounds.getInstance().playGetLife();
		GlobalStorage.lifesNum++;
		this.infoPanelUpdate();
	}
	
	public function bonusSetArmor(): Void
	{
		this.tank.setArmor();
	}
	
	public function bonusStopTime(): Void
	{
		this.isEnemyStopped = true;
		var $scope: Stage = this;
		
		var onEF: MovieClip = this.createEmptyMovieClip("onEF", 10000);
		$scope.enemyStoppedDelay = GlobalStorage.enemyStoppedDelay;
		onEF.onEnterFrame = function(): Void
		{
			$scope.enemyStoppedDelay--;
			if ($scope.enemyStoppedDelay < 0)
			{
				$scope.isEnemyStopped = false;
				delete onEF.onEnterFrame;
			}
		};
	}
	
	public function bonusBlockStuff(): Void
	{
		this.fillStuff("f");
		var $scope: Stage = this;
		
		var onEF: MovieClip = this.createEmptyMovieClip("onEF", 10001);
		this.blockStuffDelay = GlobalStorage.blockStuffDelay;
		onEF.onEnterFrame = function(): Void
		{
			$scope.blockStuffDelay--;
			if ($scope.blockStuffDelay == 120 || $scope.blockStuffDelay == 100 || $scope.blockStuffDelay == 80 || $scope.blockStuffDelay == 60 || $scope.blockStuffDelay == 40 || $scope.blockStuffDelay == 20)
			{
				$scope.fillStuff("b");
			}
			if ($scope.blockStuffDelay == 110 || $scope.blockStuffDelay == 900 || $scope.blockStuffDelay == 70 || $scope.blockStuffDelay == 50 || $scope.blockStuffDelay == 30 || $scope.blockStuffDelay == 10)
			{
				$scope.fillStuff("f");
			}
			if ($scope.blockStuffDelay < 0)
			{
				$scope.fillStuff("b");
				delete onEF.onEnterFrame;
			}
		};
	}
	
	public function fillStuff(type: String): Void
	{
		CurrentStageData.setSprite(11, 25, type);
		this.stageMap.setSpriteOnStage(11, 25, type);
		CurrentStageData.setSprite(11, 24, type);
		this.stageMap.setSpriteOnStage(11, 24, type);
		CurrentStageData.setSprite(11, 23, type);
		this.stageMap.setSpriteOnStage(11, 23, type);
		CurrentStageData.setSprite(12, 23, type);
		this.stageMap.setSpriteOnStage(12, 23, type);
		CurrentStageData.setSprite(13, 23, type);
		this.stageMap.setSpriteOnStage(13, 23, type);
		CurrentStageData.setSprite(14, 23, type);
		this.stageMap.setSpriteOnStage(14, 23, type);
		CurrentStageData.setSprite(14, 24, type);
		this.stageMap.setSpriteOnStage(14, 24, type);
		CurrentStageData.setSprite(14, 25, type);
		this.stageMap.setSpriteOnStage(14, 25, type);
	}
	
	public function infoPanelUpdate(): Void
	{
		var leftFor20: Number = Math.round(20 / CurrentStageData.getEnemyNum() * CurrentStageData.getEnemyLeft());
		this.infoPanelView.setEnemyLeft(leftFor20);
		this.infoPanelView.setLifes(GlobalStorage.lifesNum - 1);
		this.infoPanelView.setStageNum(GlobalStorage.currentStage);
	}
	
	public function onAllEnemyKilled(): Void
	{
		//		this.tank.disableControl();
		if (!GlobalStorage.isClassicGame)
		{
			Model.getInstance().fixPlayedStage(GlobalStorage.currentStageId);
		}
		var delayAfterStage: Number = GlobalStorage.delayAfterStage;
		var $scope: Stage = this;
		this.onEnterFrame = function():Void 
		{
			delayAfterStage--;
			if (delayAfterStage < 0)
			{
				$scope.stageComplete();
				delete $scope.onEnterFrame;
			}
		};
	}
	
	public function stageComplete(): Void
	{
		AllSounds.getInstance().stopAllSounds();
		this.broadcastMessage("onStageComplete");
	}
	
	public function onStaffDestroy(): Void
	{
		if (!this.isGameOver)
		{
			AllSounds.getInstance().playBuh();
			this.isGameOver = true;
			this.showGameOver();
		}
	}
	
	public function onTankDestroy(): Void
	{
		GlobalStorage.lifesNum--;
		if (GlobalStorage.lifesNum == 0)
		{
			if (!this.isGameOver)
			{
				this.isGameOver = true;
				this.showGameOver();
			}
		}
		else
		{
			//			clear bonuses
			this.infoPanelUpdate();
			GlobalStorage.currentTankType = 0;
			this.showTank();
		}
	}
	
	public function showGameOver(): Void
	{
		AllSounds.getInstance().stopEngine();
		AllSounds.getInstance().stopMove();
		this.skipText._visible = false;
		this.gameOver._visible = true;
		this.gameOver._y = 150;
		
		var delayAfterGO: Number = 100;
		
		var $scope: Stage = this;
		this.onEnterFrame = function():Void 
		{
			if ($scope.gameOver._y > 0) 
			{ 
				$scope.gameOver._y -= 1;
			} else 
			{
				$scope.tank.disableControl();
				if (delayAfterGO < 0)
				{
					$scope.doGameOver();
					delete $scope.onEnterFrame;
				}
				else
				{
					delayAfterGO--;
				}
			}
		};
	}
	
	public function doGameOver(): Void
	{
		AllSounds.getInstance().stopAllSounds();
		this.broadcastMessage("onGameOver");
	}
	
	public function destroy(): Void
	{
		this.removeMovieClip();
	}
	
	public function onKeyDown(): Void
	{
		//		pause (p)
		if(Key.getCode() == 80)
		{
			if (!this.isGameOver)
			{
				this.onPause();
			}
		}
		else
//		skip (s)
		if(Key.getCode() == 83)
		{
			if (!this.isGameOver)
			{
				this.skipStage();
			}
		}
		else
//		mute (m)
		if(Key.getCode() == 77)
		{
			this.isSoundEnable = !this.isSoundEnable;
			if (this.isSoundEnable)
			{
				AllSounds.getInstance().setVolume(100);
			}
			else
			{
				AllSounds.getInstance().setVolume(0);
			}
		}
	}	
	
	private function onPause(): Void
	{
		AllSounds.getInstance().playPause();
		CurrentStageData.isPause = !CurrentStageData.isPause;
		if (CurrentStageData.isPause)
		{
			AllSounds.getInstance().stopEngine();
			this.tank.setOnPause();
			this.pause_tf._visible = true;
			
			var delay: Number = 10;
			var $scope: Stage = this;
			this.pause_tf.onEnterFrame = function():Void
			{
				delay--;
				if (delay < 0)
				{
					$scope.pause_tf._visible = !$scope.pause_tf._visible;
					delay = 10;
				}
			};
		}
		else
		{
			AllSounds.getInstance().playEngine();
			delete this.pause_tf.onEnterFrame;
			this.pause_tf._visible = false;
		}
	}
	
	private function skipStage(): Void
	{
		this.tank.disableControl();
		AllSounds.getInstance().stopIntro();
		GlobalStorage.lifesNum = beginLifesNum;
		GlobalStorage.score = beginScore;
		GlobalStorage.currentTankType = beginCurrentTankType;
		
		this.broadcastMessage("onStageComplete", true);
	}
	
	function addListener(listenerObj: Object): Boolean 
	{
		return null;
	}
	
	function broadcastMessage(eventName: String): Void 
	{
	}
	
	function removeListener(listenerObj: Object): Boolean 
	{
		return null;
	}
}