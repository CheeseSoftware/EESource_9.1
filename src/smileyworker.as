package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="smileyworker.swf", symbol = "smileyworker")]
    public dynamic class smileyworker extends flash.display.MovieClip
    {
        public function smileyworker()
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
