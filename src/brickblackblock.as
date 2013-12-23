package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="brickblackblock.swf", symbol = "brickblackblock")]
    public dynamic class brickblackblock extends flash.display.MovieClip
    {
        public function brickblackblock()
        {
            super();
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
