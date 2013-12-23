package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="BetaProgram.swf", symbol = "BetaProgram")]
    public dynamic class BetaProgram extends flash.display.MovieClip
    {
        public function BetaProgram()
        {
            super();
            return;
        }

        public var cointext:flash.text.TextField;

        public var buywithcoinsbtn:flash.display.SimpleButton;

        public var buybtn:flash.display.SimpleButton;

        public var earnnowbtn:flash.display.SimpleButton;
    }
}
