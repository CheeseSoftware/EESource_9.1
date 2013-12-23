package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="brickfactorypack.swf", symbol = "brickfactorypack")]
    public dynamic class brickfactorypack extends flash.display.MovieClip
    {
        public function brickfactorypack()
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
