/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 15 ��� 2007
 */
interface ua.com.syo.battlecity.screens.stage.TankI 
{
	public function move(isStopped:Boolean):Void;
	
	public function destroy(isGrenade:Boolean):Void;
	
	public function getType():String;
	
	public function getStatus():String;
}