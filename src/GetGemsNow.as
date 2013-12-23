package 
{
    import flash.display.*;
    
    [Embed(source="GetGemsNow.swf", symbol = "GetGemsNow")]
    public dynamic class GetGemsNow extends flash.display.MovieClip
    {
        public function GetGemsNow()
        {
            super();
            addFrameScript(0, this.frame1);
            return;
        }

        internal function frame1():*
        {
            stop();
            return;
        }

        public var kreds2:flash.display.SimpleButton;

        public var buybtn4:flash.display.SimpleButton;

        public var kreds3:flash.display.SimpleButton;

        public var buybtn5:flash.display.SimpleButton;

        public var kreds4:flash.display.SimpleButton;

        public var buybtn6:flash.display.SimpleButton;

        public var kreds5:flash.display.SimpleButton;

        public var kreds6:flash.display.SimpleButton;

        public var srbtn:flash.display.SimpleButton;

        public var closebtn:flash.display.SimpleButton;

        public var ggbtn:flash.display.SimpleButton;

        public var buybtn1:flash.display.SimpleButton;

        public var buybtn2:flash.display.SimpleButton;

        public var kreds1:flash.display.SimpleButton;

        public var buybtn3:flash.display.SimpleButton;
    }
}
