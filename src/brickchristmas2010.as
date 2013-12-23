package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="brickchristmas2010.swf", symbol = "brickchristmas2010")]
    public dynamic class brickchristmas2010 extends flash.display.MovieClip
    {
        public function brickchristmas2010()
        {
            super();
            addFrameScript(0, this.frame1);
            return;
        }

        internal function frame1():*
        {
            return;
        }

        public var usegems:flash.display.SimpleButton;

        public var progressbar:flash.display.MovieClip;

        public var useenergy:flash.display.SimpleButton;

        public var buttontext:flash.text.TextField;

        public var gembuttontext:flash.text.TextField;

        public var progressbartext:flash.text.TextField;
    }
}
