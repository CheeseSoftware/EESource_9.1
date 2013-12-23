package blitter
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;

    public class BlText extends BlObject
    {
        private var systemFont:Class;
        private var visitorFont:Class;
        protected var _text:String = "";
        protected var bmd:BitmapData;
        protected var tf:TextField;
        protected var tff:TextFormat;

        public function BlText(param1:int, param2:Number, param3:Number = 16777215, param4:String = "left", param5:String = "system")
        {
            this.systemFont = BlText_systemFont;
            this.visitorFont = BlText_visitorFont;
            this.tf = new TextField();
            this.tf.embedFonts = true;
            this.tf.selectable = false;
            this.tf.sharpness = 100;
            this.tf.multiline = true;
            this.tf.wordWrap = true;
            this.tf.width = param2;
            this.tff = new TextFormat(param5, param1, param3, null, null, null, null, null, param4);
            this.tf.defaultTextFormat = this.tff;
            this.tf.text = "qi´";
            this.bmd = new BitmapData(param2, this.tf.textHeight + 5, true, 0);
            this.tf.text = "";
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this.tf.text = param1;
            Bl.stage.quality = StageQuality.LOW;
            this._text = param1;
            this.bmd.fillRect(this.bmd.rect, 0);
            this.bmd.draw(this.tf);
            Bl.stage.quality = StageQuality.BEST;
            return;
        }// end function

        public function set filters(param1:Array) : void
        {
            this.tf.filters = param1;
            this.text = this._text;
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

        override public function draw(param1:BitmapData, param2:Number, param3:Number) : void
        {
            param1.copyPixels(this.bmd, this.bmd.rect, new Point(param2 + x, param3 + y));
            return;
        }// end function

        public function clone() : BitmapData
        {
            return this.bmd.clone();
        }// end function

    }
}
