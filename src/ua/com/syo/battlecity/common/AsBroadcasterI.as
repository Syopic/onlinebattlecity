/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 7 ��� 2007
 */
interface ua.com.syo.battlecity.common.AsBroadcasterI 
{
	function addListener(listenerObj:Object):Boolean;
	function broadcastMessage(eventName:String):Void;
	function removeListener(listenerObj:Object):Boolean;
}