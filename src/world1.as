package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="world1.swf", symbol = "world1")]
    public dynamic class world1 extends flash.display.MovieClip
    {
        public function world1()
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
