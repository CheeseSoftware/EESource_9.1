package chat
{
    import flash.display.*;
    import flash.text.*;

    public class ChatEntry extends Sprite
    {

        public function ChatEntry(param1:String, param2:String, param3:Number)
        {
            var _loc_4:TextField = null;
            _loc_4 = new TextField();
            _loc_4.multiline = true;
            _loc_4.selectable = true;
            _loc_4.wordWrap = true;
            _loc_4.width = 190;
            _loc_4.height = 500;
            _loc_4.antiAliasType = AntiAliasType.ADVANCED;
            _loc_4.gridFitType = GridFitType.SUBPIXEL;
            _loc_4.condenseWhite = true;
            var _loc_5:* = Player.isAdmin(param1);
            if (param3 != 0)
            {
                _loc_4.background = true;
                _loc_4.backgroundColor = param3;
            }
            var _loc_6:* = new TextFormat("Tahoma", 9, _loc_5 ? (8947848) : (8947848), false, false, false);
            _loc_6.indent = -8;
            _loc_6.blockIndent = 8;
            _loc_6.align = TextFormatAlign.LEFT;
            _loc_4.defaultTextFormat = _loc_6;
            var _loc_7:* = _loc_5 ? (16757760) : (15658734);
            _loc_4.text = param1.toUpperCase() + ": " + param2;
            _loc_4.setTextFormat(new TextFormat(null, null, _loc_7), 0, (param1 + ": ").length);
            _loc_4.x = 2;
            _loc_4.y = 1;
            _loc_4.height = _loc_4.textHeight + 5;
            addChild(_loc_4);
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            return;
        }// end function

    }
}
