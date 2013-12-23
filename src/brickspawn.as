package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="brickspawn.swf", symbol = "brickspawn")]
    public dynamic class brickspawn extends flash.display.MovieClip
    {
        public function brickspawn()
        {
            super();
            return;
        }

        public var usegems:flash.display.SimpleButton;

        public var count:flash.text.TextField;

        public var progressbar:flash.display.MovieClip;

        public var useenergy:flash.display.SimpleButton;

        public var buttontext:flash.text.TextField;

        public var gembuttontext:flash.text.TextField;

        public var progressbartext:flash.text.TextField;
    }
}
