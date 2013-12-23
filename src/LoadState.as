package 
{
    import LoadState.*;
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.net.*;

    public class LoadState extends BlState
    {
        protected var loading:Class;
        protected var image:BitmapData;
        protected var color:Number = 0;
        protected var modifier:Number = 0.05;
        protected var callback:Function;
        protected var flakes:Array;

        public function LoadState()
        {
            this.loading = LoadState_loading;
            this.image = new this.loading();
            this.flakes = [];
            return;
        }// end function

        override public function enterFrame() : void
        {
            if (Bl.isMouseJustPressed)
            {
                if (!Bl.data.isbeta)
                {
                    navigateToURL(new URLRequest("http://everybodyedits.com"), "_blank");
                }
            }
            super.enterFrame();
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:Number, param3:Number) : void
        {
            this.color = this.color + this.modifier;
            if (this.color > 1)
            {
                this.color = 1;
            }
            param1.copyPixels(this.image, this.image.rect, new Point(0, 0));
            param1.colorTransform(param1.rect, new ColorTransform(1, 1, 1, this.color));
            if (this.color < 0)
            {
            }
            if (this.callback != null)
            {
                this.callback();
                this.callback = null;
            }
            super.draw(param1, param2, param3);
            return;
        }// end function

        public function fadeOut(param1:Function) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.flakes.length)
            {
                
                this.flakes[_loc_2].fade();
                _loc_2 = _loc_2 + 1;
            }
            this.color = 1;
            this.modifier = -0.05;
            this.callback = param1;
            return;
        }// end function

    }
}
