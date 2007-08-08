import ua.com.syo.battlecity.components.Sprite;
import ua.com.syo.battlecity.screens.stage.TankI;
import ua.com.syo.battlecity.screens.stage.Bomb;
import ua.com.syo.battlecity.view.UIManager;
import ua.com.syo.battlecity.screens.stage.Enemy;
import ua.com.syo.battlecity.screens.stage.Bonus;
import ua.com.syo.battlecity.sound.AllSounds;
import ua.com.syo.battlecity.data.GlobalStorage;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 8 ��� 2007
 */
class ua.com.syo.battlecity.screens.stage.CurrentStageData 
{
	public static var stageMap_array: Array = new Array();
	public static var spriteNamesMap_array: Array = new Array();
	public static var allTanks_array: Array = new Array();
	public static var playerBombs_array: Array = new Array();
	public static var enemyBombs_array: Array = new Array();
	public static var enemysOrder_array: Array = new Array();
	public static var currentPlayerBombNum: Number = 0;
	public static var currentEnemy: Number = 0;
	public static var enemyOnStage: Number = 0;
	public static var enemyKill_array: Array;
	public static var enemyKillNum: Number;
	public static var eagleInstance: MovieClip;
	public static var isPause: Boolean = false;
	public static var bonus: Bonus;
	
	public static function init(): Void
	{
		var i: Number;
		//		
		//		inicialize array of stage
		stageMap_array = new Array(26);
		for (i = 0;i < 26; i++) 		
		{
			stageMap_array[i] = new Array(26);
		}
		
		spriteNamesMap_array = new Array(26);
		for (i = 0;i < 26; i++) 		
		{
			spriteNamesMap_array[i] = new Array(26);
		}
		
		allTanks_array = new Array(26);
		for (i = 0;i < 26; i++) 		
		{
			allTanks_array[i] = new Array(26);
		}
		
		playerBombs_array = new Array(26);
		for (i = 0;i < 26; i++) 		
		{
			playerBombs_array[i] = new Array(26);
		}
		
		enemyBombs_array = new Array(26);
		for (i = 0;i < 26; i++) 		
		{
			enemyBombs_array[i] = new Array(26);
		}
		
		enemysOrder_array = new Array();
		enemyKill_array = new Array(0, 0, 0, 0);
		
		currentPlayerBombNum = 0;
		currentEnemy = 0;
		enemyOnStage = 0;
		enemyKillNum = 0;
		
		isPause = false;
	}
	
	public static function fillMap(xml: XML): Void
	{
		var i: Number;
		var s: String;
		//		
		//		<stage enemys="11111111111111111111">
		//		<r>__________________________</r>
		//		<r>__________________________</r>
		//		<r>__________________________</r>
		//		<r>________bb__bb____________</r>
		//		<r>________bbffbb____________</r>
		//		<r>__________ff______________</r>
		//		<r>bbb___bbbbbbbbbbbbbbb_____</r>
		//		<r>______ii__bb______________</r>
		//		<r>_____ii___bb___________bbb</r>
		//		<r>_______________________bbb</r>
		//		<r>_______________________bbb</r>
		//		<r>_______________________bbb</r>
		//		<r>_______________________bbb</r>
		//		<r>_______________________bbb</r>
		//		<r>__________________________</r>
		//		<r>__________________________</r>
		//		<r>__________________________</r>
		//		<r>__________________________</r>
		//		<r>__________________________</r>
		//		<r>___bb_______bb____________</r>
		//		<r>___bb_______bb____________</r>
		//		<r>__________________________</r>
		//		<r>__________________________</r>
		//		<r>__________________________</r>
		//		<r>__________________________</r>
		//		<r>__________________________</r>
		//		</stage>
		init();
		var shortPath: XML = xml.childNodes[0];
			
		for (var j: Number = 0;j < 26; j++) 		
		{
			s = new String(XMLNode(shortPath.childNodes[j]).childNodes.toString());
			for (i = 0;i < 26; i++) 			
			{
				Array(stageMap_array[i])[j] = s.charAt(i);
				Array(allTanks_array[i])[j] = null;
				Array(enemyBombs_array[i])[j] = null;
			}
		}
		Array(stageMap_array[12])[24] = "o";
		Array(stageMap_array[12])[25] = "o";
		Array(stageMap_array[13])[24] = "o";
		Array(stageMap_array[13])[25] = "o";
		
		Array(stageMap_array[11])[25] = "b";
		Array(stageMap_array[11])[24] = "b";
		Array(stageMap_array[11])[23] = "b";
		Array(stageMap_array[12])[23] = "b";
		Array(stageMap_array[13])[23] = "b";
		Array(stageMap_array[14])[23] = "b";
		Array(stageMap_array[14])[24] = "b";
		Array(stageMap_array[14])[25] = "b";
		
		Array(stageMap_array[0])[0] = "_";
		Array(stageMap_array[0])[1] = "_";
		Array(stageMap_array[1])[0] = "_";
		Array(stageMap_array[1])[1] = "_";
		
		Array(stageMap_array[12])[0] = "_";
		Array(stageMap_array[12])[1] = "_";
		Array(stageMap_array[13])[0] = "_";
		Array(stageMap_array[13])[1] = "_";
		
		Array(stageMap_array[24])[0] = "_";
		Array(stageMap_array[24])[1] = "_";
		Array(stageMap_array[25])[0] = "_";
		Array(stageMap_array[25])[1] = "_";
		
		Array(stageMap_array[8])[24] = "_";
		Array(stageMap_array[8])[25] = "_";
		Array(stageMap_array[9])[24] = "_";
		Array(stageMap_array[9])[25] = "_";
		
		
		s = new String(shortPath.attributes["enemys"]);
		for (i = 0;i < s.length; i++) 		
		{
			enemysOrder_array[i] = s.charAt(i);
		}
		
		GlobalStorage.currentStageId = new String(shortPath.attributes["id"]);
	}
	
	public static function setSprite(x: Number, y: Number, type: String): Void
	{
		Array(stageMap_array[x])[y] = type;
	}
	
	public static function getSprite(x: Number, y: Number): String
	{
		return Array(stageMap_array[x])[y];
	}
	
	public static function setSpriteInstance(x: Number, y: Number, sprite: Sprite): Void
	{
		Array(spriteNamesMap_array[x])[y] = sprite;
	}
	
	public static function getSpriteInstance(x: Number, y: Number): Sprite
	{
		return Array(spriteNamesMap_array[x])[y];
	}
	
	public static function checkBarrierForTank(x: Number, y: Number): Boolean
	{
		var isBarrier1: Boolean = false;
		var isBarrier2: Boolean = false;
		var isBarrier3: Boolean = false;
		var isBarrier4: Boolean = false;
		
		var isBarrier5: Boolean = false;
		var isBarrier6: Boolean = false;
		var isBarrier7: Boolean = false;
		var isBarrier8: Boolean = false;
		
		var noBarriersType_array: Array = new Array("_", "g", "i");
		
		for (var i: Number = 0;i < noBarriersType_array.length; i++)
		{
			if (getSprite(x, y) == noBarriersType_array[i])
			{
				isBarrier1 = true;
			}
			
			if (getSprite(x + 1, y) == noBarriersType_array[i])
			{
				isBarrier2 = true;
			}
			
			if (getSprite(x, y + 1) == noBarriersType_array[i])
			{
				isBarrier3 = true;
			}
			
			if (getSprite(x + 1, y + 1) == noBarriersType_array[i])
			{
				isBarrier4 = true;
			}
		}
		
		if (getTankMapState(x, y))
		{
			isBarrier5 = true;
		}
		
		if (getTankMapState(x + 1, y))
		{
			isBarrier6 = true;
		}
		
		if (getTankMapState(x, y + 1))
		{
			isBarrier7 = true;
		}
		
		if (getTankMapState(x + 1, y + 1))
		{
			isBarrier8 = true;
		}
		
		return isBarrier1 && isBarrier2 && isBarrier3 && isBarrier4 && isBarrier5 && isBarrier6 && isBarrier7 && isBarrier8;
	}
	
	public static function checkIce(x: Number, y: Number): Boolean
	{
		var isBarrier1: Boolean = false;
		var isBarrier2: Boolean = false;
		var isBarrier3: Boolean = false;
		var isBarrier4: Boolean = false;
		
		var noBarriersType_array: Array = new Array("i");
		
		for (var i: Number = 0;i < noBarriersType_array.length; i++)
		{
			if (getSprite(x, y) == noBarriersType_array[i])
			{
				isBarrier1 = true;
			}
			
			if (getSprite(x + 1, y) == noBarriersType_array[i])
			{
				isBarrier2 = true;
			}
			
			if (getSprite(x, y + 1) == noBarriersType_array[i])
			{
				isBarrier3 = true;
			}
			
			if (getSprite(x + 1, y + 1) == noBarriersType_array[i])
			{
				isBarrier4 = true;
			}
		}
		
		return isBarrier1 && isBarrier2 && isBarrier3 && isBarrier4;
	}
	
	public static function checkBarrierForBomb(x: Number, y: Number, direction: Number): Boolean
	{
		var isBarrier1: Boolean = false;
		var isBarrier2: Boolean = false;
		
		var noBarriersType_array: Array = new Array("_", "g", "i", "w");
		
		for (var i: Number = 0;i < noBarriersType_array.length; i++)
		{
			if (getSprite(x, y) == noBarriersType_array[i])
			{
				isBarrier1 = true;
			} 
			
			var tx: Number;
			var ty: Number;
			
			switch (direction) 			
			{
				case 1 :
					//up
					tx = x + 1;
					ty = y;
					break;
				case 2 :
					//down
					tx = x + 1;
					ty = y;
					break;
				case 3 :
					//left
					tx=x;
				ty=y+1;
				break;
			case 4 :
				//right
				tx=x;
				ty=y+1;
				break;
			}
			if (getSprite(tx,ty) == noBarriersType_array[i]) {
				isBarrier2 = true;
			}
		}
		
		return isBarrier1&&isBarrier2;
	}	
	
	public static function eraseBrick(x:Number, y:Number, direction:Number, isEraseFerum:Boolean, isPlayerBomb:Boolean): Void
	{
		var sprite:Sprite;
		var isDestroy:Boolean;
//		
		
		var isPlaySound:Boolean=false;
		
		
		if (getSprite(x, y)=="b")
		{
			sprite=getSpriteInstance(x, y);
			isDestroy=sprite.nextErase(direction);
			if (isPlayerBomb)
			{
				AllSounds.getInstance().playeraseBrick();
				isPlaySound=true;
			}
			if (isDestroy || isEraseFerum)
			{
				setSprite(x, y, "_");
				sprite.destroy();
			}
		}
		else
		if (getSprite(x, y)=="f" && isEraseFerum)
		{	
			if (isPlayerBomb)
			{
				AllSounds.getInstance().playeraseBrick();
				isPlaySound=true;
			}
			sprite=getSpriteInstance(x, y);
			setSprite(x, y, "_");
			sprite.destroy();
		}
		else
		if (getSprite(x, y)=="o")
		{	
			eagleInstance.gotoAndStop(2);
			UIManager.getInstance().getStageInstance().showBlast(96, 192, "bigExplosive");
			UIManager.getInstance().getStageInstance().onStaffDestroy();
			Array(stageMap_array[12])[24]="w";
			Array(stageMap_array[12])[25]="w";
			Array(stageMap_array[13])[24]="w";
			Array(stageMap_array[13])[25]="w";
			
		}
		else
		{
		if (getSprite(x, y)==undefined || getSprite(x, y)=="f")
			if (isPlayerBomb)
			{
				AllSounds.getInstance().playBlock();
				isPlaySound=true;
			}
		}
		
		var tx:Number;
		var ty:Number;
		
		switch (direction) {
		case 1 :
			//up
			tx=x+1;
			ty=y;
			break;
		case 2 :
			//down
			tx=x+1;
			ty=y;
			break;
		case 3 :
			//left
			tx=x;
			ty=y+1;
			break;
		case 4 :
			//right
			tx=x;
			ty=y+1;
			break;
		}
		
		if (getSprite(tx, ty)=="b")
		{
			if (isPlayerBomb && !isPlaySound)
			{
				AllSounds.getInstance().playeraseBrick();
			}
			sprite=getSpriteInstance(tx, ty);
			isDestroy=sprite.nextErase(direction);
			if (isDestroy || isEraseFerum)
			{
				setSprite(tx, ty, "_");
				sprite.destroy();
			}
		}
		
		if (getSprite(tx, ty)=="f" && isEraseFerum)
		{
			if (isPlayerBomb && !isPlaySound)
			{
				AllSounds.getInstance().playeraseBrick();
			}
			sprite=getSpriteInstance(tx, ty);
			setSprite(tx, ty, "_");
			sprite.destroy();
		}
		
		if (getSprite(tx, ty)=="o")
		{	
			eagleInstance.gotoAndStop(2);
			UIManager.getInstance().getStageInstance().showBlast(96, 192, "bigExplosive");
			UIManager.getInstance().getStageInstance().onStaffDestroy();
			Array(stageMap_array[12])[24]="w";
			Array(stageMap_array[12])[25]="w";
			Array(stageMap_array[13])[24]="w";
			Array(stageMap_array[13])[25]="w";
			
		}
		else
		if (getSprite(tx, ty)==undefined || getSprite(tx, ty)=="f")
		{
			if (isPlayerBomb && !isPlaySound)
			{
				AllSounds.getInstance().playBlock();
			}
		}
		
	} 
	
	public static function checkEnemyForBomb(x:Number, y:Number, direction:Number): Boolean
	{
		var isBarrier1:Boolean=false;
		var isBarrier2:Boolean=false;
		
		var is4shoot:Boolean=false;
		var isKill:Boolean=false;
		
		var enemy:MovieClip=getTankFromMap(x, y);
		
		if (enemy == null || TankI(enemy).getType()=="player" || TankI(enemy).getStatus() == "portal")
		{
			isBarrier1 = true;
		} 
		else
		{
			if (Enemy(enemy).getModel()==4)
			{
				is4shoot=true;
				Enemy(enemy).changeRankFor4();
				if (Enemy(enemy).getRankFor4()<0)
				{
					isKill=true;
					destroyEnemy(enemy);
				}
				else
				{
					AllSounds.getInstance().playBlock();
				}
			}
			else
			{
				CurrentStageData.enemyOnStage--;
				enemyKill_array[Enemy(enemy).getModel()-1]++;
				enemyKillNum++;
				isKill=true;
				TankI(enemy).destroy();
				
				if (enemyKillNum==getEnemyNum())
				{
					UIManager.getInstance().getStageInstance().onAllEnemyKilled();
				}
			}
			
		}
		
		var tx:Number;
		var ty:Number;
		
		switch (direction) {
		case 1 :
			//up
			tx=x+1;
			ty=y;
			break;
		case 2 :
			//down
			tx=x+1;
			ty=y;
			break;
		case 3 :
			//left
			tx=x;
			ty=y+1;
			break;
		case 4 :
			//right
			tx=x;
			ty=y+1;
			break;
		}
		
		var enemy2:MovieClip=getTankFromMap(tx, ty);
		
		if (enemy2== null || TankI(enemy2).getType()=="player" || TankI(enemy2).getStatus() == "portal") {
			isBarrier2 = true;
		}
		else
		{
			if (!isKill)
			{
				if (Enemy(enemy2).getModel()==4)
				{
					if (is4shoot && enemy==enemy2)
					{}
					else
					{
						Enemy(enemy2).changeRankFor4();
						if (Enemy(enemy2).getRankFor4()<0)
						{
							destroyEnemy(enemy2);
						}
						else
						{
							AllSounds.getInstance().playBlock();
						}
					}
				}
				else
				{
					CurrentStageData.enemyOnStage--;
					enemyKill_array[Enemy(enemy2).getModel()-1]++;
					enemyKillNum++;
					TankI(enemy2).destroy();
					
					if (enemyKillNum==getEnemyNum())
					{
						UIManager.getInstance().getStageInstance().onAllEnemyKilled();
					}
				}
			}
		}
		
		return isBarrier1&&isBarrier2;
	}
	

	public static function destroyEnemy(enemy:MovieClip, isGrenade:Boolean):Void
	{
		CurrentStageData.enemyOnStage--;
		
		if (!isGrenade)
		{
			enemyKill_array[Enemy(enemy).getModel()-1]++;
		}
		enemyKillNum++;
		Enemy(enemy).destroy(isGrenade);
		
		if (enemyKillNum==getEnemyNum())
		{
			UIManager.getInstance().getStageInstance().onAllEnemyKilled();
		}
			
	}
	
	public static function checkPlayerForBomb(x:Number, y:Number, direction:Number, instance:Bomb): Boolean
	{
		var isBarrier1:Boolean=false;
		var isBarrier2:Boolean=false;
		
		if (TankI(getTankFromMap(x, y)).getType()=="player" && TankI(getTankFromMap(x, y)).getStatus()=="tank")
		{
			TankI(getTankFromMap(x, y)).destroy();
			UIManager.getInstance().getStageInstance().onTankDestroy();
		} 
		else if (TankI(getTankFromMap(x, y)).getStatus()=="armor")
		{
			instance.destroy();
		}
		else
		{
			isBarrier1 = true;
		}
		
		var tx:Number;
		var ty:Number;
		
		switch (direction) {
		case 1 :
			//up
			tx=x+1;
			ty=y;
			break;
		case 2 :
			//down
			tx=x+1;
			ty=y;
			break;
		case 3 :
			//left
			tx=x;
			ty=y+1;
			break;
		case 4 :
			//right
			tx=x;
			ty=y+1;
			break;
		}
		if (TankI(getTankFromMap(tx, ty)).getType()=="player" && TankI(getTankFromMap(tx, ty)).getStatus()=="tank") 
		{
			TankI(getTankFromMap(tx,ty)).destroy();
			UIManager.getInstance().getStageInstance().onTankDestroy();
		}
		else if (TankI(getTankFromMap(tx, ty)).getStatus()=="armor")
		{
			instance.destroy();
		}
		else
		{
			isBarrier2 = true;
		}
		
		return isBarrier1&&isBarrier2;
	}
	
	public static function checkBombColision(bombInstance:Bomb):Void
	{
		var tx:Number = Math.round(bombInstance.x/8);
		var ty:Number = Math.round(bombInstance.y/8);
		
		if (Array(enemyBombs_array[tx])[ty]!=null)
		{
//			trace("bomb: "+bombInstance+"__"+ty+"  "+Array(enemyBombs_array[tx])[ty]);
			bombInstance.destroy(true);
			Bomb(Array(enemyBombs_array[tx])[ty]).destroy(true);
		}
		else
		{
			var direction:Number=bombInstance.direction;
			switch (direction) {
			case 1 :
				//up
				ty--;
				break;
			case 2 :
				//down
				ty++;
				break;
			case 3 :
				//left
				tx--;
				break;
			case 4 :
				//right
				tx++;
				break;
			}
			
			if (Array(enemyBombs_array[tx])[ty]!=null)
			{
				bombInstance.destroy(true);
				Bomb(Array(enemyBombs_array[tx])[ty]).destroy(true);
			}
		}		
		
		
	}
	
	public static function fillTankMap(x:Number, y:Number, instance:TankI): Void
	{
		Array(allTanks_array[x])[y] = instance;
		Array(allTanks_array[x+1])[y] = instance;
		Array(allTanks_array[x])[y+1] = instance;
		Array(allTanks_array[x+1])[y+1] = instance;
	} 
	
	public static function clearTankMap(x:Number, y:Number): Void
	{
		Array(allTanks_array[x])[y] = null;
		Array(allTanks_array[x+1])[y] = null;
		Array(allTanks_array[x])[y+1] = null;
		Array(allTanks_array[x+1])[y+1] = null;
	} 
	
	public static function fillBombMap(x:Number, y:Number, instance:Bomb):Void
	{
		Array(enemyBombs_array[x])[y] = instance;
	}
	
	public static function clearBombMap(x:Number, y:Number):Void
	{
		Array(enemyBombs_array[x])[y] = null;
	}
	
	public static function getTankFromMap(x:Number, y:Number): MovieClip
	{
		return Array(allTanks_array[x])[y];
	} 	
	
	public static function getTankMapState(x:Number, y:Number): Boolean
	{
//		trace("MAP: "+Array(allTanks_array[x])[y]);
		if (Array(allTanks_array[x])[y]==null)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	public static function getNextEnemy(pos:Number): Number
	{
		if (pos==undefined)
		{
			pos=currentEnemy;
			
		}
		currentEnemy++;
		return Number(enemysOrder_array[pos]);
	}
	
	public static function getEnemyNum(): Number
	{
		return enemysOrder_array.length;
	}	
	
	public static function getEnemyLeft(): Number
	{
		return getEnemyNum()-currentEnemy;
	}	

	public static function setBonusInstance(b:Bonus): Void 
	{
		bonus=b;
	} 
	
	public static function getBonusInstance(): Bonus
	{
		return bonus;
	} 
	
	/*
	 * check collision bonus and player tank
	 */
	public static function checkBonusCollision(x:Number, y:Number): Boolean
	{
		var dx:Number= bonus.getX()-x;
		var dy:Number= bonus.getY()-y;
		
		
		if (Math.abs(dx)<2 && Math.abs(dy)<2)
		{
			return true;
		}
		else
		{
			return false;
		}
	} 
}