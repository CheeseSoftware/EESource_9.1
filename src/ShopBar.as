package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="ShopBar.swf", symbol = "ShopBar")]
    public dynamic class ShopBar extends flash.display.MovieClip
    {
        public function ShopBar()
        {
            super();
            return;
        }

        public var gems:flash.text.TextField;

        public var shopbtn:flash.display.SimpleButton;

        public var energy:flash.text.TextField;

        public var shop:flash.display.MovieClip;

        public var gemsbtn:flash.display.SimpleButton;

        public var timetonext:flash.text.TextField;
    }
}
