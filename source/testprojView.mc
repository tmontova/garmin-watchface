using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Gregorian;
using Toybox.Time as Time;

class testprojView extends Ui.WatchFace {

	var isAwake = false;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    function onUpdate(dc) {
        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$ $2$", [clockTime.hour, clockTime.min.format("%02d")]);
	    var mainClockView = View.findDrawableById("TimeLabel");
        mainClockView.setText(timeString);
        
        var currentDate = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var trunc_year = currentDate.year%2000;
        var dateString = Lang.format("$1$ $2$ $3$", [currentDate.day, currentDate.month, trunc_year]);  
        var dateView = View.findDrawableById("DateLabel");
        dateView.setText(dateString);
        
        var height = Sys.getDeviceSettings().screenHeight;
        var width = Sys.getDeviceSettings().screenWidth;
                
        var secondsX = mainClockView.locX + mainClockView.width + 10;
		
		if(isAwake){
			var seconds = Sys.getClockTime().sec.format("%02d");
			var secView = View.findDrawableById("SecondsLabel");
			secView.setLocation(secondsX, mainClockView.locY);
			secView.setText(seconds);
		}
		else{
			var secView = View.findDrawableById("SecondsLabel");
			secView.setText("");
		}
		
		System.println(Sys.getSystemStats().battery);
		
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
		isAwake = true;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	isAwake = false;
    }

}
