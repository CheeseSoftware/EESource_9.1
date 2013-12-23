package ui2 
{
    import flash.display.*;
    import flash.geom.*;
    
    [Embed(source="ui2youbtn.swf", symbol = "ui2.ui2youbtn")]
    public class ui2youbtn extends flash.display.MovieClip
    {
        public function ui2youbtn(arg1:flash.display.BitmapData)
        {
            this.bmd = new flash.display.BitmapData(16, 16, true, 0);
            super();
            this.smileybmd = arg1;
            var loc1:*=new flash.display.Bitmap(this.bmd);
            addChild(loc1);
            loc1.x = 6;
            loc1.y = 10;
            this.setSelectedSmiley(0);
            return;
        }

        public function setSelectedSmiley(arg1:int):void
        {
            this.bmd.copyPixels(this.smileybmd, new flash.geom.Rectangle(arg1 * 16, 5, 16, 16 + 5), new flash.geom.Point(0, 0));
            return;
        }

        private var bmd:flash.display.BitmapData;

        private var smileybmd:flash.display.BitmapData;
    }
}
