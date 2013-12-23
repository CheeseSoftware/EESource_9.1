package 
{
    import JoinState.*;
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;

    public class JoinState extends BlState
    {
        protected var bg:Class;
        protected var background:BitmapData;

        public function JoinState()
        {
            this.bg = JoinState_bg;
            this.background = new this.bg();
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:Number, param3:Number) : void
        {
            param1.copyPixels(this.background, this.background.rect, new Point(0, 0));
            return;
        }// end function

    }
}
