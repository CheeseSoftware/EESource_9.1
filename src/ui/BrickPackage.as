package ui
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import ui2.*;

    public class BrickPackage extends ui2brickpackage
    {
        private var sp:Sprite;
        private var content:Array;
        private var uix:UI2;
        private var highlight:Bitmap;
        private var bmd:BitmapData;
        private var val:int = 0;

        public function BrickPackage(param1:String, param2:BitmapData, param3:Array, param4:UI2)
        {
            this.sp = new Sprite();
            this.highlight = new Bitmap(new ui2selector());
            this.bmd = param2;
            this.content = param3;
            this.uix = param4;
            var _loc_5:* = new TextField();
            _loc_5.embedFonts = true;
            _loc_5.selectable = false;
            _loc_5.antiAliasType = AntiAliasType.ADVANCED;
            _loc_5.mouseEnabled = false;
            _loc_5.defaultTextFormat = new TextFormat(new visitor().fontName, 13, 16777215);
            _loc_5.text = param1;
            _loc_5.width = _loc_5.textWidth + 5;
            _loc_5.height = _loc_5.textHeight + 5;
            addChild(_loc_5);
            var _loc_6:* = new BitmapData(param3.length * 16, 16, false, 0);
            var _loc_7:* = new Bitmap(_loc_6);
            this.sp.addChild(_loc_7);
            this.sp.y = 12;
            this.sp.x = 2;
            addChild(this.sp);
            var _loc_8:int = 0;
            while (_loc_8 < param3.length)
            {
                
                _loc_6.copyPixels(param2, new Rectangle(param3[_loc_8] * 16, 0, 16, 16), new Point(_loc_8 * 16, 0));
                _loc_8 = _loc_8 + 1;
            }
            this.sp.useHandCursor = true;
            this.sp.buttonMode = true;
            this.sp.addEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseDown);
            addChild(this.highlight);
            this.highlight.x = 2;
            this.highlight.y = 12;
            return;
        }// end function

        private function handleMouseDown(event:MouseEvent) : void
        {
            var _loc_2:* = this.sp.mouseX / 16 >> 0;
            this.select(_loc_2);
            this.uix.dragIt(this.val, this.bmd);
            return;
        }// end function

        private function select(param1:int) : void
        {
            this.uix.setSelected(this.content[param1], this.bmd);
            this.setSelected(this.content[param1], this.bmd);
            return;
        }// end function

        public function getPosition(param1:int) : Point
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.content.length)
            {
                
                if (this.content[_loc_2] == param1)
                {
                    return new Point(_loc_2 * 16 + 2 + x + 8, y + 8);
                }
                _loc_2 = _loc_2 + 1;
            }
            return null;
        }// end function

        public function setSelected(param1:int, param2:BitmapData) : void
        {
            var _loc_3:int = 0;
            if (param2 == this.bmd)
            {
                this.val = param1;
                _loc_3 = 0;
                while (_loc_3 < this.content.length)
                {
                    
                    if (this.content[_loc_3] == param1)
                    {
                        this.highlight.x = _loc_3 * 16 + 2;
                        this.highlight.visible = true;
                        return;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            this.highlight.visible = false;
            return;
        }// end function

    }
}
