/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 28 ��� 2007
 */
class ua.com.syo.battlecity.components.Sprite extends MovieClip 
{
	private var type:String;
	private var sprite_mc:MovieClip;
	 
	public static function create(clip:MovieClip,name:String,depth:Number,initObject:Object):Sprite
	{
		registerClass("__Packages.ua.com.syo.battlecity.components.Sprite",Sprite);
		var instance:MovieClip=clip.attachMovie("__Packages.ua.com.syo.battlecity.components.Sprite",name,depth,initObject);
		var classInstance:Sprite=Sprite(instance);
		classInstance.buildInstance();
		return classInstance;
	}
	public function buildInstance():Void
	{
	}
	
	public function init(x:Number, y:Number, type:String):Void
	{
		this.type=type;
		this.sprite_mc=this.attachMovie(type, type, 1);
		this._x=x;
		this._y=y;
	}
	
	public function destroy(): Void
	{
		removeMovieClip(this);
	}
	
	public function nextErase(direction:Number): Boolean
	{
		var isDestroy:Boolean=false;
		var toFrame:Number=1;
		
		if (this.type=="brick")
		{
		}
		
		if (this.type=="brick")
		{
			var currentFrame:Number=this.sprite_mc._currentframe;
			
			if (currentFrame>5)
			{
				isDestroy= true;
				break;
			}
			else
			{
				switch (direction) {
				case 1 :
					//up
					if (currentFrame==2 || currentFrame==3)
					{
						isDestroy=true;
						break;
					}
					else if (currentFrame==1)
					{
						sprite_mc.gotoAndStop(2);
						break;
					}
					else if (currentFrame==4)
					{
						sprite_mc.gotoAndStop(7);
						break;
					}
					else if (currentFrame==5)
					{
						sprite_mc.gotoAndStop(6);
						break;
					}
					
					break;
				case 2 :
					//down
					if (currentFrame==2 || currentFrame==3)
					{
						isDestroy=true;
						break;
					}
					else if (currentFrame==1)
					{
						sprite_mc.gotoAndStop(3);
						break;
					}
					else if (currentFrame==4)
					{
						sprite_mc.gotoAndStop(9);
						break;
					}
					else if (currentFrame==5)
					{
						sprite_mc.gotoAndStop(8);
						break;
					}
					break;
				case 3 :
					//left
					if (currentFrame==4 || currentFrame==5)
					{
						isDestroy=true;
						break;
					}
					else if (currentFrame==1)
					{
						sprite_mc.gotoAndStop(4);
						break;
					}
					else if (currentFrame==2)
					{
						sprite_mc.gotoAndStop(7);
						break;
					}
					else if (currentFrame==3)
					{
						sprite_mc.gotoAndStop(9);
						break;
					}
					break;
				case 4 :
					//right
					if (currentFrame==4 || currentFrame==5)
					{
						isDestroy=true;
						break;
					}
					else if (currentFrame==1)
					{
						sprite_mc.gotoAndStop(5);
						break;
					}
					else if (currentFrame==2)
					{
						sprite_mc.gotoAndStop(6);
						break;
					}
					else if (currentFrame==3)
					{
						sprite_mc.gotoAndStop(8);
						break;
					}
					break;
				}
			}
		}
		return isDestroy;
	}
		
}