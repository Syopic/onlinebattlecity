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
class ua.com.syo.battlecity.screens.stage.Tank extends MovieClip implements TankI {
	private var currentTank : MovieClip;
	private var currentTankType : Number;
	private var armor : MovieClip;
	private var portal : MovieClip;
	private var olddx : Number;
	private var olddy : Number;
	private var dx : Number;
	private var dy : Number;
	private var direction : Number = 1;
	private var direction_array : Array = new Array("up", "down", "left", "right");
	private var keyStack_array : Array;
	private var tankType_array : Array = new Array("tank0", "tank1", "tank2", "tank3");
	private var iceDelay : Number;
	private var armorDelay : Number;
	private var bombSpeed_array : Array = new Array(2, 3, 3, 3);
	private var bombLimit_array : Array = new Array(1, 1, 2, 2);
	private var ferumErase_array : Array = new Array(false, false, false, true);
	private var isMove : Boolean = false;
	private var isPortalView : Boolean = true;
	private var isArmor : Boolean = true;
	private var isDestroy : Boolean = false;

	public static function create(clip : MovieClip, name : String, depth : Number, initObject : Object) : Tank {
		registerClass("__Packages.ua.com.syo.battlecity.screens.stage.Tank", Tank);
		var instance : MovieClip = clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.stage.Tank", name, depth, initObject);
		var classInstance : Tank = Tank(instance);
		classInstance.buildInstance();
		return classInstance;
	}

	public function buildInstance() : Void {
	}

	public function init(tankType : Number) : Void {
		this.keyStack_array = new Array();
		this.isMove = false;
		this.isPortalView = true;
		this.iceDelay = 0;
		this.direction = 1;
		
		if (!tankType) {
			this.currentTankType = 0;
		}
		else {
			this.currentTankType = tankType;
		}
		var tx : Number = Math.round(64 / 8);
		var ty : Number = Math.round(192 / 8);
		CurrentStageData.fillTankMap(tx, ty, this);

		this.putOnStartPosition();
	}

	public function putOnStartPosition() : Void {
		this.showPortal();
	}

	private function showPortal() : Void {
		this.portal = this.attachMovie("portalTank", "portal", this.getNextHighestDepth(), {_x:64, _y:192});
		this.portal["scope"] = this;
		this.portal.gotoAndPlay(1);
	}

	public function onPortalHide() : Void {
		this.showTank();
		this.isPortalView = false;
		this.portal.removeMovieClip();
	}

	private function showTank() : Void {
		this.currentTank = this.attachMovie(this.tankType_array[this.currentTankType], "tank", 1);
		this.armor = this.currentTank.attachMovie("armor", "armor", this.currentTank.getNextHighestDepth());

		this.isArmor = true;
		this.armorDelay = Math.round(GlobalStorage.armorDelay / 5);

		this.currentTank._x = 64;
		this.currentTank._y = 192;

		this.enableControl();
		this.arrangeTank();

		this.isMove = true;
		this.switchSound(false);
	}

	public function enableControl() : Void {
		Key.addListener(this);
		this.isMove = true;
	}

	public function disableControl() : Void {
		this.keyStack_array = new Array();
		Key.removeListener(this);
		this.isMove = false;
	}

	public function onKeyDown() : Void {
		//trace("X: "+this.currentTank._x);
		if (!CurrentStageData.isPause) {
			if (Key.getCode() == 32) {
				if (CurrentStageData.currentPlayerBombNum < this.bombLimit_array[this.currentTankType]) {
					//shoot
					AllSounds.getInstance().playShoot();
					GameController.getInstance().putPlayerBomb(this.currentTank._x, this.currentTank._y, this.direction, this.bombSpeed_array[this.currentTankType], this.ferumErase_array[this.currentTankType]);
					CurrentStageData.currentPlayerBombNum++;
				}
			} 
			else {
				if (this.keyStack_array.length == 0) {
					this.switchSound(true);
				}
				if (Key.getCode() == 38) {
					//up
					this.dx = 0;
					this.dy = -1;
					this.direction = 1;
					if (this.keyStack_array[0] != this.direction) {
						this.keyStack_array.unshift(this.direction);
					}

					this.arrangeTank();
				}
				if (Key.getCode() == 40) {
					//down
					this.dx = 0;
					this.dy = 1;
					this.direction = 2;
					if (this.keyStack_array[0] != this.direction) {
						this.keyStack_array.unshift(this.direction);
					}

					this.arrangeTank();
				}
				if (Key.getCode() == 37) {
					//left
					this.dx = -1;
					this.dy = 0;
					this.direction = 3;
					if (this.keyStack_array[0] != this.direction) {
						this.keyStack_array.unshift(this.direction);
					}

					this.arrangeTank();
				}
				if (Key.getCode() == 39) {
					//right
					this.dx = 1;
					this.dy = 0;
					this.direction = 4;
					if (this.keyStack_array[0] != this.direction) {
						this.keyStack_array.unshift(this.direction);
					}

					this.arrangeTank();
				}
			}
		}
	}

	public function onKeyUp() : Void {
		if (!CurrentStageData.isPause) {
			if (Key.getCode() == 38) {
				//up
				this.shiftArray(1);
			}
			if (Key.getCode() == 40) {
				//down
				this.shiftArray(2);
			}
			if (Key.getCode() == 37) {
				//left
				this.shiftArray(3);
			}
			if (Key.getCode() == 39) {
				//right
				this.shiftArray(4);
			}

			switch (this.keyStack_array[0]) {
				case 1 :
					//up
					this.dx = 0;
					this.dy = -1;
					this.direction = 1;
					break;
				case 2 :
					//down
					this.dx = 0;
					this.dy = 1;
					this.direction = 2;
					break;
				case 3 :
					//left
					this.dx = -1;
					this.dy = 0;
					this.direction = 3;
					break;
				case 4 :
					//right
					this.dx = 1;
					this.dy = 0;
					this.direction = 4;
					break;
			}

			this.arrangeTank();
		}
	}

	private function shiftArray(direction : Number) : Void {
		//		trace(this.keyStack_array);
		if (this.keyStack_array[1] == 0 || this.keyStack_array[0] == direction) {
			this.direction = direction;
		}
		for (var i : Number = 0;i < 4; i++) {
			if (keyStack_array[i] == direction) {
				keyStack_array.splice(i, 1);
			}
		}
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
		
		if (this.keyStack_array.length == 0) {
			this.switchSound(false);
			this.olddx = this.dx;
			this.olddy = this.dy;
			this.dx = 0;
			this.dy = 0;
		}
	}

	public function move(isStopped : Boolean) : Void {
		
		var tx : Number;
		var ty : Number;

		var old_tx : Number;
		var old_ty : Number;
		
		var newx : Number;
		var newy : Number;
		
		if (this.isMove) {
			if (this.dx || this.dy) {
				old_tx = Math.round(this.currentTank._x / 8);
				old_ty = Math.round(this.currentTank._y / 8);

				CurrentStageData.clearTankMap(old_tx, old_ty);

				newx = this.currentTank._x + this.dx;
				newy = this.currentTank._y + this.dy;
				
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

					CurrentStageData.fillTankMap(Math.round(newx / 8), Math.round(newy / 8), this);
				}
				else {
					iceDelay = 0;
					CurrentStageData.fillTankMap(old_tx, old_ty, this);
				}
				
				if (CurrentStageData.checkIce(tx, ty)) {
					iceDelay = GlobalStorage.slidingDelay;
				}
				var f : Number = this.currentTank._currentframe / 2;
				if (f - Math.round(f) == 0) {
					this.currentTank.prevFrame();
				}
				else {
					this.currentTank.nextFrame();
				}
			}
			else if (iceDelay > 0) {
				iceDelay--;
				
				old_tx = Math.round(this.currentTank._x / 8);
				old_ty = Math.round(this.currentTank._y / 8);

				CurrentStageData.clearTankMap(old_tx, old_ty);

				newx = this.currentTank._x + this.olddx;
				newy = this.currentTank._y + this.olddy;
				
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

					CurrentStageData.fillTankMap(Math.round(newx / 8), Math.round(newy / 8), this);
				}
				else {
					CurrentStageData.fillTankMap(old_tx, old_ty, this);
				}
				
				if (iceDelay > 11) {
					if (!CurrentStageData.checkIce(tx, ty)) {
						iceDelay = 8;
					}
				}
			}
			//			
			if (Math.round(this.armorDelay) == 0 && this.isArmor) {
				this.isArmor = false;
				this.armor._visible = false;
				trace("CLEAR ARMOR: " + this.armorDelay);
			}
			else {
				this.armorDelay--;
			}
			tx = Math.round(this.currentTank._x / 8);
			ty = Math.round(this.currentTank._y / 8);
			if (CurrentStageData.checkBonusCollision(tx, ty)) {
				UIManager.getInstance().getStageInstance().onCheckBonus();
			}
		}
		else {
			AllSounds.getInstance().stopMove();
		}
		if (isStopped) {}
	}

	public function setOnPause() : Void {
		this.dx = 0;
		this.dy = 0;
		this.keyStack_array = new Array();
	}

	public function getType() : String {
		return "player";
	}

	public function getStatus() : String {
		if (this.isPortalView) {
			return "portal";
		}
		else if (this.isArmor) {
			return "armor";
		}
		else {
			return "tank";
		}
	}

	public function upRank() : Void {
		if (this.currentTankType < 3) {
			this.currentTankType++;
			var old_x : Number = this.currentTank._x;
			var old_y : Number = this.currentTank._y;

			this.currentTank.removeMovieClip();

			this.currentTank = this.attachMovie(this.tankType_array[this.currentTankType], "tank", 1);
			this.armor = this.currentTank.attachMovie("armor", "armor", this.currentTank.getNextHighestDepth());
			this.armor._visible = this.isArmor;
			
			this.currentTank._x = old_x;
			this.currentTank._y = old_y;

			GlobalStorage.currentTankType = this.currentTankType;

			this.arrangeTank();
		}
	}

	public function setArmor() : Void {
		this.armor._visible = true;
		this.isArmor = true;
		this.armorDelay = GlobalStorage.armorDelay;
//		trace("ARMOR init: "+this.armorDelay);
	}

	public function destroy(isGrenade : Boolean) : Void {
		AllSounds.getInstance().stopAllSounds();

		AllSounds.getInstance().playBuh();
		this.isMove = false;
		this.disableControl();

		var tx : Number = Math.round(this.currentTank._x / 8);
		var ty : Number = Math.round(this.currentTank._y / 8);

		CurrentStageData.clearTankMap(tx, ty);

		UIManager.getInstance().getStageInstance().showBlast(this.currentTank._x, this.currentTank._y, "bigExplosive");
//		UIManager.getInstance().getStageInstance().showTank();
		this.currentTank.removeMovieClip();
		if (isGrenade) {}
	}

	private function switchSound(isSoundMove : Boolean) : Void {
		isSoundMove = !isSoundMove;
		AllSounds.getInstance().stopMove();
		AllSounds.getInstance().stopEngine();
		if (!isSoundMove) {
			AllSounds.getInstance().playMove(10000);
		} 
		else {
			AllSounds.getInstance().playEngine(10000);
		}
	}
}