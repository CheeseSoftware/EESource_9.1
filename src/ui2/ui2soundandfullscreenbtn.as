package ui2 
{
    import flash.display.*;
    
    [Embed(source="ui2soundandfullscreenbtn.swf", symbol = "ui2.ui2soundandfullscreenbtn")]
    public dynamic class ui2soundandfullscreenbtn extends flash.display.MovieClip
    {
        public function ui2soundandfullscreenbtn()
        {
            super();
            addFrameScript(0, this.frame1);
            return;
        }

        function frame1():*
        {
            stop();
            return;
        }

        public var sound:flash.display.SimpleButton;

        public var fullscreen:flash.display.SimpleButton;
    }
}
