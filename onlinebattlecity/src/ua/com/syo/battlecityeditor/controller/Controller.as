import ua.com.syo.battlecityeditor.view.UIManager;
/**
 * @author Krivosheya Sergey
 * @link www: http://syo.com.ua
 * email: syopic@gmail.com
 * 29 ��� 2007
 */
class ua.com.syo.battlecityeditor.controller.Controller 
{
	private static var instance :Controller;
	
	/**
	 * returns the singleton;
	 */
	public static function getInstance() : Controller
	{
		if (instance == null)
		{
			instance = new Controller();
		}
		return instance;
	}
	
	public function init(): Void
	{
	}
	
	public function run(): Void
	{
		UIManager.getInstance().showEditPage();
	}
}