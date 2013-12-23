package ui
{
    import blitter.*;
    import flash.events.*;
    import flash.text.*;
    import ui2.*;

    public class CoinProperties extends ui2properties
    {

        public function CoinProperties()
        {
            var tf:TextField;
            var inptf:TextField;
            tf = new TextField();
            tf.embedFonts = true;
            tf.selectable = false;
            tf.sharpness = 100;
            tf.multiline = false;
            tf.wordWrap = false;
            var tff:* = new TextFormat("system", 12, 16777215);
            tf.defaultTextFormat = tff;
            tf.width = 324;
            tf.x = -150;
            tf.y = -38;
            tf.text = "Coins to collect to open door:";
            tf.height = tf.textHeight;
            addChild(tf);
            inptf = new TextField();
            inptf.selectable = false;
            inptf.sharpness = 100;
            inptf.multiline = false;
            inptf.borderColor = 16777215;
            inptf.backgroundColor = 11184810;
            inptf.background = true;
            inptf.border = true;
            var inptff:* = new TextFormat("Arial", 12, 0, null, null, null, null, null, TextFormatAlign.CENTER);
            inptf.defaultTextFormat = inptff;
            inptf.text = Bl.data.coincount;
            inptf.height = tf.height + 3;
            inptf.width = 25;
            inptf.y = -38;
            inptf.x = 130 - 30;
            var add:* = new ui2plusbtn();
            add.y = -29;
            add.x = 130 + 10;
            addChild(add);
            add.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                if (Bl.data.coincount < 99)
                {
                    var _loc_1:* = Bl.data;
                    var _loc_2:* = Bl.data.coincount + 1;
                    _loc_1.coincount = _loc_2;
                }
                inptf.text = Bl.data.coincount;
                return;
            }// end function
            );
            var sub:* = new ui2minusbtn();
            sub.y = -29;
            sub.x = 130 - 29 - 16;
            addChild(sub);
            sub.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                if (Bl.data.coincount > 1)
                {
                    var _loc_1:* = Bl.data;
                    var _loc_2:* = Bl.data.coincount - 1;
                    _loc_1.coincount = _loc_2;
                }
                inptf.text = Bl.data.coincount;
                return;
            }// end function
            );
            addChild(inptf);
            this.bg.height = 50;
            return;
        }// end function

    }
}
