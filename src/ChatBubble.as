package 
{
    import blitter.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;

    public class ChatBubble extends BlSprite
    {
        public var time:Date;

        public function ChatBubble(param1:String, param2:String)
        {
            var _loc_3:TextField = null;
            this.time = new Date();
            _loc_3 = new TextField();
            _loc_3.x = 2;
            _loc_3.y = 2;
            _loc_3.multiline = true;
            _loc_3.selectable = false;
            _loc_3.wordWrap = true;
            _loc_3.width = 110;
            _loc_3.height = 500;
            _loc_3.antiAliasType = AntiAliasType.ADVANCED;
            _loc_3.gridFitType = GridFitType.SUBPIXEL;
            _loc_3.condenseWhite = true;
            var _loc_4:* = new TextFormat("Tahoma", 11, 0, false, false, false);
            _loc_4.align = TextFormatAlign.CENTER;
            _loc_3.defaultTextFormat = _loc_4;
            _loc_3.text = param2;
            if (_loc_3.numLines == 1)
            {
                _loc_3.width = _loc_3.textWidth + 5;
            }
            _loc_3.height = _loc_3.textHeight + 5;
            var _loc_5:* = _loc_3.textHeight;
            if (_loc_3.numLines != 1)
            {
                while (_loc_5 == _loc_3.textHeight)
                {
                    
                    var _loc_164:* = _loc_3;
                    var _loc_174:* = _loc_3.width - 1;
                    _loc_164.width = _loc_174;
                }
                var _loc_16:* = _loc_3;
                var _loc_17:* = _loc_3.width + 1;
                _loc_16.width = _loc_17;
            }
            var _loc_6:* = new Sprite();
            _loc_6.addChild(_loc_3);
            var _loc_7:* = GradientType.LINEAR;
            var _loc_8:Array = [13816530, 16777215];
            var _loc_9:Array = [0.9, 0.9];
            var _loc_10:Array = [0, 255];
            var _loc_11:* = new Matrix();
            _loc_11.createGradientBox(20, _loc_3.height + 3, Math.PI / 2, 0, 0);
            var _loc_12:* = SpreadMethod.PAD;
            _loc_6.graphics.beginGradientFill(_loc_7, _loc_8, _loc_9, _loc_10, _loc_11, _loc_12);
            _loc_6.graphics.drawRoundRect(0, 0, _loc_3.width + 4, _loc_3.height + 3, 4, 4);
            _loc_6.graphics.moveTo(_loc_3.width / 2, _loc_3.height + 3);
            _loc_6.graphics.lineTo(_loc_3.width / 2, _loc_3.height + 10);
            _loc_6.graphics.lineTo(_loc_3.width / 2 + 7, _loc_3.height + 3);
            var _loc_13:* = new GlowFilter(0, 1, 2, 2, 2, 3, false);
            _loc_6.filters = [_loc_13];
            var _loc_14:* = new BitmapData(_loc_6.width + 4, _loc_6.height + 4, true, 0);
            var _loc_15:* = new Matrix();
            _loc_15.translate(2, 2);
            _loc_14.draw(_loc_6, _loc_15);
            super(_loc_14);
            rect = _loc_14.rect;
            size = _loc_14.height;
            frames = 1;
            width = rect.width;
            height = rect.height;
            _x = -(width / 2 >> 0) + 19;
            _y = -height + 7;
            return;
        }// end function

        public function age(param1:Number) : void
        {
            if (param1 > 14000)
            {
                bmd.applyFilter(bmd, bmd.rect, new Point(0, 0), new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.9, 0]));
            }
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:Number, param3:Number) : void
        {
            param1.copyPixels(bmd, rect, new Point(param2 + _x, param3 + _y));
            return;
        }// end function

    }
}
