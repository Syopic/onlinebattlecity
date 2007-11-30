import ua.com.syo.battlecity.screens.stage.TankI;
import ua.com.syo.battlecity.screens.stage.CurrentStageData;
import ua.com.syo.battlecity.data.GlobalStorage;
import ua.com.syo.battlecity.controller.GameController;
import ua.com.syo.battlecity.view.UIManager;
import ua.com.syo.battlecity.sound.AllSounds;

/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 15 ��� 2007
 */
class ua.com.syo.battlecity.screens.stage.Enemy extends MovieClip implements TankI {
	private var currentTank : MovieClip;
	private var portal : MovieClip;
	private var dx : Number;
	private var dy : Number;
	private var direction : Number = 1;
	private var direction_array : Array = new Array("up", "down", "left", "right");
	private var keyStack_array : Array = new Array();
	private var delay : Number = 0;
	private var shootDelay : Number = random(50);
	private var blinkingDelay : Number = 10;
	private var isBonus : Boolean = false;
	private var isMove : Boolean = false;
	private var startX : Number;
	private var isPortalView : Boolean = true;
	private var type : Number;
	private var isMoveFor4 : Boolean = true;
	private var leftShootFor4 : Number = 3;
	private var tankSpeed_array : Array = new Array(1, 2, 1, 1);
	private var bombSpeed_array : Array = new Array(2, 2, 3, 2);
	private var bonusColors_array : Array = new Array(0x8C0074, 0xD82800, 0xFCFCFC);
	private var bigTankColors1_1_array : Array = new Array(0x005000, 0x009038, 0xB0FCCC);
	private var bigTankColors1_2_array : Array = new Array(0x005000, 0x009038, 0xB0FCCC);

	private var bigTankColors2_1_array : Array = new Array(0x887000, 0xFC9838, 0xFCE4A0);
	private var bigTankColors2_2_array : Array = new Array(0x887000, 0xFC9838, 0xFCE4A0);

	private var bigTankColors3_1_array : Array = new Array(0x887000, 0xFC9838, 0xFCE4A0);
	private var bigTankColors3_2_array : Array = new Array(0x005000, 0x009038, 0xB0FCCC);

	private var bigTankColors4_1_array : Array = new Array(0x183C5C, 0xBCBCBC, 0xFCFCFC);
	private var bigTankColors4_2_array : Array = new Array(0x183C5C, 0xBCBCBC, 0xFCFCFC);

	
	public static function create(clip : MovieClip,name : String,depth : Number,initObject : Object) : Enemy {
		registerClass("__Packages.ua.com.syo.battlecity.screens.stage.Enemy", Enemy);
		var instance : MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.stage.Enemy", name, depth, initObject);
		var classInstance : Enemy = Enemy(instance);
		classInstance.buildInstance();
		return classInstance;
	}

	public function buildInstance() : Void {
	}

	public function init(startX : Number, type : Number) : Void {
		this.startX = startX;
		
		
		this.type = type;
		
		if (this.type > 4) {
			this.type -= 4;
			this.isBonus = true;
		}
		
		var tx : Number = Math.round(this.startX / 8);
		
		CurrentStageData.fillTankMap(tx, 0, this);
		
		this.putOnStartPosition();
	}

	public function putOnStartPosition() : Void {
		this.showPortal();
	}

	private function showPortal() : Void {
		this.portal = this.attachMovie("portalTank", "portal", this.getNextHighestDepth(), {_x:this.startX, _y:0});
		this.portal["scope"] = this;
		this.portal.gotoAndPlay(1);
	}

	public function onPortalHide() : Void {
		this.showEnemy();
		this.portal.removeMovieClip();
		this.isPortalView = false;
	}

	private function showEnemy() : Void {
		this.currentTank = this.attachMovie("enemy" + this.type, "enemy", this.getNextHighestDepth());
		this.currentTank._x = this.startX;
		this.currentTank._y = 0;
		
		this.arrangeTank();
		
		this.isMove = true;
	}

	private function arrangeTank() : Void {
		this.currentTank.gotoAndStop(this.direction_array[this.direction - 1]);
		//
		if (this.direction == 1 || this.direction == 2) {
			this.currentTank._x = Math.round(this.currentTank._x / 8) * 8;
		} 
		else {
			this.currentTank._y = Math.round(this.currentTank._y / 8) * 8;
		}
	}

	/*
	 * one step
	 * isStopped - flag for clock bonus
	 */
	public function move(isStopped : Boolean) : Void {
		if (this.isMove) {
			if (!isStopped) {
				this.delay--;
			}
			if (this.delay < 0) {
				this.changeDirection();
			} 
			else {	
				this.isMoveFor4 = !this.isMoveFor4;
				if (this.isMoveFor4 || this.type != 4) {
					var tx : Number;
					var ty : Number;
					
					var old_tx : Number = Math.round(this.currentTank._x / 8);
					var old_ty : Number = Math.round(this.currentTank._y / 8);
		
					
					CurrentStageData.clearTankMap(old_tx, old_ty);
					var newx : Number;
					var newy : Number;
					
					if (!isStopped) {
						newx = this.currentTank._x + this.dx * this.tankSpeed_array[this.type - 1];
						newy = this.currentTank._y + this.dy * this.tankSpeed_array[this.type - 1];
					}
					else {
						newx = this.currentTank._x;
						newy = this.currentTank._y;
					}
					
					if (this.direction == 1 || this.direction == 3) {
						tx = Math.floor(newx / 8);
						ty = Math.floor(newy / 8);
					} 
					else {
						tx = Math.ceil(newx / 8);
						ty = Math.ceil(newy / 8);
					}
					
					if (CurrentStageData.checkBarrierForTank(tx, ty)) {
						this.currentTank._x = newx;
						this.currentTank._y = newy;
						
						tx = Math.round(newx / 8);
						ty = Math.round(newy / 8);
						
						CurrentStageData.fillTankMap(tx, ty, this);
					}
					else {
						//					this.changeDirection();
						if (!isStopped) {
							this.delay -= 4;
						}
						CurrentStageData.fillTankMap(old_tx, old_ty, this);
					}
					if (!isStopped) {
						var f : Number = this.currentTank._currentframe / 2;
						if (f - Math.round(f) == 0) {
							this.currentTank.prevFrame();
						}
						else {
							this.currentTank.nextFrame();
						}
					}
						
					this.blink();
				}
			}
			if (!isStopped) {
				this.shootDelay--;
				if (this.shootDelay < 0) {
					GameController.getInstance().putEnemyBomb(this.currentTank._x, this.currentTank._y, this.direction, this.bombSpeed_array[this.type - 1]);
					this.shootDelay = random(GlobalStorage.enemyShootDelay) + GlobalStorage.enemyShootDelay;
				}
			}
		}
	}

	/*
	 * change direction
	 */
	private function changeDirection() : Void {
		//		old direction
		var r : Number = this.direction;
	
		var r2 : Number = random(15);
		if (r2 < 5 && this.currentTank._y < 200) {
			r = this.direction = 2;
		}
		else
		if (r2 < 8 || this.currentTank._y > 180) {
			
			if (this.currentTank._x > 104) {
				r = 3;
			}
			else {
				r = 4;
			}
		}
		else {
			r = random(4) + 1;
		}
		
		
		if (r == 1) {
			//up
			this.dx = 0;
			this.dy = -1;
			this.direction = 1;
		}
		else
		if (r == 2) {
			//down
			this.dx = 0;
			this.dy = 1;
			this.direction = 2;
		}
		else
		if (r == 3) {
			//left
			this.dx = -1;
			this.dy = 0;
			this.direction = 3;
		}
		else
		if (r == 4) {
			//right
			this.dx = 1;
			this.dy = 0;
			this.direction = 4;
		}					
		
		this.delay = random(GlobalStorage.enemychangeDirectionDelay) + 10;
		this.arrangeTank();
	}

	private function blink() : Void {
		var colorArray1 : Array = new Array();
		var colorArray2 : Array = new Array();
		
		if (this.type == 4) {
			if (this.leftShootFor4 == 3) {
				
				if (this.isBonus) {
					colorArray1 = this.bonusColors_array;
					colorArray2 = this.bigTankColors4_2_array;
				}
				else {
					colorArray1 = this.bigTankColors1_1_array; 
					colorArray2 = this.bigTankColors1_2_array;
				}
			}
			else
			if (this.leftShootFor4 == 2) {
				colorArray1 = this.bigTankColors2_1_array; 
				colorArray2 = this.bigTankColors2_2_array;
			}
			else
			if (this.leftShootFor4 == 1) {
				colorArray1 = this.bigTankColors3_1_array; 
				colorArray2 = this.bigTankColors3_2_array;
			}
			else
			if (this.leftShootFor4 == 0) {
				colorArray1 = this.bigTankColors4_1_array; 
				colorArray2 = this.bigTankColors4_2_array;
			}
		}
		else {
			if (this.isBonus) {
				colorArray1 = this.bonusColors_array;
				colorArray2 = this.bigTankColors4_2_array;
			}
			else {
				colorArray1 = this.bigTankColors4_1_array; 
				colorArray2 = this.bigTankColors4_2_array;
			}
		}
		if (this.type == 4 || this.isBonus) {
			this.blinkingDelay--;
			
			var c1 : Color = new Color(this.currentTank["black_mc"]);
			var c2 : Color = new Color(this.currentTank["silver_mc"]);
			var c3 : Color = new Color(this.currentTank["white_mc"]);
			
			if (this.blinkingDelay < 0) {
				c1.setRGB(colorArray1[0]);
				c2.setRGB(colorArray1[1]);
				c3.setRGB(colorArray1[2]);
			}
			else {
				c1.setRGB(colorArray2[0]);
				c2.setRGB(colorArray2[1]);
				c3.setRGB(colorArray2[2]);
			}
			if (this.blinkingDelay < -5) {
				this.blinkingDelay = 10;
			}
		}
	}

	public function getType() : String {
		return "enemy";
	}

	public function getModel() : Number {
		return this.type;
	}

	public function changeRankFor4() : Void {
		this.leftShootFor4--;
		if (this.leftShootFor4 == 2 && this.isBonus) {
			UIManager.getInstance().getStageInstance().putBonus();
		}
	}

	public function getRankFor4() : Number {
		return this.leftShootFor4;
	}

	
	public function destroy(isGrenade : Boolean) : Void {
		this.isMove = false;
		
		var tx : Number = Math.round(this.currentTank._x / 8);
		var ty : Number = Math.round(this.currentTank._y / 8);
			
		CurrentStageData.clearTankMap(tx, ty);
		
		UIManager.getInstance().getStageInstance().showBlast(this.currentTank._x, this.currentTank._y, "bigExplosive");
		
		if (!isGrenade) {
			AllSounds.getInstance().playKill();
			UIManager.getInstance().getStageInstance().showScore(this.currentTank._x, this.currentTank._y, 100 * this.type);
			GlobalStorage.addScore(100 * this.type);
		
		
			if (this.isBonus && this.type != 4) {
				UIManager.getInstance().getStageInstance().putBonus();
			}
		}
		
		
		this.removeMovieClip();
	}

	public function getStatus() : String {
		if (this.isPortalView) {
			return "portal";
		}
		else {
			return "tank";
		}
	}
}