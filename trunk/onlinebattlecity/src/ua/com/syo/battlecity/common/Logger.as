/**
 * @author Krivosheya Sergey
 * www: http://syo.com.ua
 * email: syopic@gmail.com
 * 2006
 */
 
 /**
  * Logger class.
  * All methods statically.
  *  
  */
class ua.com.syo.battlecity.common.Logger {
	
	// Log levels
	public static var LEVEL_DEBUG:Number = 0;
    public static var LEVEL_INFO:Number = 1;
    public static var LEVEL_WARN:Number = 2;
    public static var LEVEL_ERROR:Number = 3;
    
    // Current log level 
    public static var LOG_LEVEL:Number = LEVEL_DEBUG;
    
	private static var isTrace:Boolean=true;
	
	private static function output(level:String, message:String): Void {
		if (isTrace) {
			trace(level+" :  "+message);
		}			
	}
	
	public static function DEBUG(message:String): Void {
		if (LOG_LEVEL <= LEVEL_DEBUG){
            output("DEBUG" , message);
        }
	}
	
	public static function INFO(message:String): Void {
		if (LOG_LEVEL <= LEVEL_INFO){
            output("INFO" , message);
        }		
	}
	
	public static function WARN(message:String): Void {
		if (LOG_LEVEL <= LEVEL_WARN){
            output("WARN" , message);
        }				
	}
	
	public static function ERROR(message:String): Void {
		if (LOG_LEVEL <= LEVEL_ERROR){
            output("ERROR" , message);
        }				
	}
	
}