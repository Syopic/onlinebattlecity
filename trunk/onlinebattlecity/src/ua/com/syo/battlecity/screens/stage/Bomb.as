import ua.com.syo.battlecity.screens.stage.CurrentStageData;
import ua.com.syo.battlecity.view.UIManager;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 28 ��� 2007
 */
class ua.com.syo.battlecity.screens.stage.Bomb extends MovieClip 
{
	private var bomb:MovieClip;
	public var direction:Number;
	private var direction_array:Array=new Array("up", "down", "left", "right");
	
	private var dx:Number;
	private var dy:Number;
	
	public var x:Number;
	public var y:Number;
	
	private var speed:Number;
	private var isPlayerBomb:Boolean;
	private var isEraseFerum:Boolean;
	
	private var isMove:Boolean=true;
	
	public static function create(clip:MovieClip,name:String,depth:Number,initObject:Object):Bomb
	{
		registerClass("__Packages.ua.com.syo.battlecity.screens.stage.Bomb",Bomb);
		var instance:MovieClip=clip.attachMovie("__Packages.ua.com.syo.battlecity.screens.stage.Bomb",name,depth,initObject);
		var classInstance:Bomb=Bomb(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	
	public function buildInstance():Void
	{
		this.bomb=this.attachMovie("bomb", "bomb", this.getNextHighestDepth());
	}
	
	public function init(x:Number, y:Number, direction:Number, speed:Number, isPlayerBomb:Boolean, isEraseFerum:Boolean): Void
	{
		this.bomb._x=this.x=x;
		this.bomb._y=this.y=y;
		this.direction=direction;
		this.speed=speed;
		this.isPlayerBomb=isPlayerBomb;
		this.isEraseFerum=isEraseFerum;
		
		this.correctBombPosition();
		
		switch (this.direction) 
		{
		case 1 :
			//up
			this.dx = 0;
			this.dy = -1;
			break;
		case 2 :
			//down
			this.dx = 0;
			this.dy = 1;
			break;
		case 3 :
			//left
			this.dx = -1;
			this.dy = 0;
			break;
		case 4 :
			//right
			this.dx = 1;
			this.dy = 0;
			break;
		}
		
		this.bomb.gotoAndStop(this.direction_array[this.direction-1]);
	}
	
	public function move(): Void
	{
		if (this.isMove)
		{
			var tx:Number;
			var ty:Number;
			
			var oldx:Number = this.x;
			var oldy:Number = this.y;
			//
			var tx_o:Number = Math.round(oldx/8);
			var ty_o:Number = Math.round(oldy/8);
			tx = tx_o;
			ty = ty_o;
			
			if (!this.isPlayerBomb)
			{
				CurrentStageData.clearBombMap(tx, ty);
			}
	
			var newx:Number = this.x+dx*this.speed;
			var newy:Number = this.y+dy*this.speed;
			//
			switch (this.direction) {
			case 1 :
				//up
				tx = newx/8;
				ty = Math.round(newy/8);
				break;
			case 2 :
				//down
				tx = newx/8;
				ty = Math.ceil((newy+6)/8);
				break;
			case 3 :
				//left
				tx = Math.round(newx/8);
				ty = newy/8;
				break;
			case 4 :
				//right
				tx = Math.ceil((newx+6)/8);
				ty =newy/8;
				break;
			}
	
			
			if (CurrentStageData.checkBarrierForBomb(tx, ty, this.direction))
			{
				this.bomb._x=this.x = newx;
				this.bomb._y=this.y = newy;
				this.correctBombPosition();
				
				if (!this.isPlayerBomb)
				{
					var rx:Number = Math.round(this.x/8);
					var ry:Number = Math.round(this.y/8);
					CurrentStageData.fillBombMap(rx, ry, this);
				}
				
			}
			else
			{
				CurrentStageData.eraseBrick(tx,ty, this.direction, this.isEraseFerum, isPlayerBomb);
				this.destroy();
			}
			
			if (this.isPlayerBomb)
			{
				if (!CurrentStageData.checkEnemyForBomb(tx, ty, this.direction))
				{
					this.destroy();
				}
			}
			else
			{
				if (!CurrentStageData.checkPlayerForBomb(tx, ty, this.direction, this))
				{
					this.destroy();
				}
			}
		}
	}
	
	public function correctBombPosition(): Void
	{
		switch (this.direction) 
		{
		case 1 :
			//up
			this.bomb._x += 4;
			this.bomb._y -= 1;

			break;
		case 2 :
			//down
			this.bomb._x += 3;
			this.bomb._y += 11;

			break;
		case 3 :
			//left
			this.bomb._x -= 1;
			this.bomb._y += 5;

			break;
		case 4 :
			//right
			this.bomb._x += 10;
			this.bomb._y += 5;

			break;
		}
	}
	
	public function destroy(isAnigilation:Boolean): Void
	{
		this.isMove=false;
		if (this.isPlayerBomb)
		{
			CurrentStageData.currentPlayerBombNum--;
		}
		else
		{
			var tx:Number = Math.round(this.x/8);
			var ty:Number = Math.round(this.y/8);
			
			CurrentStageData.clearBombMap(tx, ty);
				
		}
		if (!isAnigilation)
		{
			UIManager.getInstance().getStageInstance().showBlast(this.bomb._x, this.bomb._y, "explosive");
		}
		this.removeMovieClip();
	}
		
}