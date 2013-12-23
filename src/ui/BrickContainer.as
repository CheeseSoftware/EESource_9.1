package ui
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.ui.*;
    import ui2.*;

    public class BrickContainer extends ui2levelbrickscontainer
    {
        private var images:Array;
        private var sprites:Array;
        private var defaults:Array = null;
        private var bmd:BitmapData;
        private var selected:int = 0;
        private var selectedIndex:int = 0;
        private var uix:UI2;
        private var dragmc:Sprite;
        private var dragbm:Bitmap;
        private var indrag:Boolean = false;
        private var dragtype:int = 0;
        private var dragbmd:BitmapData;
        private var oldvar:int = 0;

        public function BrickContainer(param1:BitmapData, param2:Array, param3:UI2)
        {
            var _loc_5:BitmapData = null;
            var _loc_6:Bitmap = null;
            var _loc_7:Sprite = null;
            this.images = [];
            this.sprites = [];
            this.dragmc = new Sprite();
            this.dragbm = new Bitmap(new BitmapData(16, 16, false, 0));
            this.uix = param3;
            this.defaults = param2.concat();
            this.bmd = param1;
            this.dragmc.addChild(this.dragbm);
            this.dragmc.mouseChildren = false;
            this.dragmc.mouseEnabled = false;
            this.dragmc.filters = [new DropShadowFilter(0, 45, 0, 1, 4, 4, 1, 3)];
            var _loc_8:Boolean = false;
            numbers.mouseEnabled = false;
            selector.mouseEnabled = _loc_8;
            var _loc_4:int = 0;
            while (_loc_4 < 11)
            {
                
                _loc_5 = new BitmapData(16, 16, false, 0);
                _loc_6 = new Bitmap(_loc_5);
                _loc_7 = new Sprite();
                this.attachClickHandler(_loc_7, _loc_4);
                _loc_7.useHandCursor = true;
                _loc_7.buttonMode = true;
                _loc_7.addChild(_loc_6);
                _loc_7.x = _loc_4 * 16;
                brickcontainer.addChild(_loc_7);
                this.images.push(_loc_5);
                this.sprites.push(_loc_7);
                _loc_4 = _loc_4 + 1;
            }
            _loc_4 = 0;
            while (_loc_4 < 11)
            {
                
                this.setDefault(_loc_4, param2[_loc_4][1], param2[_loc_4][0]);
                _loc_4 = _loc_4 + 1;
            }
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            addEventListener(Event.REMOVED_FROM_STAGE, this.handleDetatch);
            return;
        }// end function

        public function get value() : int
        {
            return this.selected;
        }// end function

        public function setDefault(param1:int, param2:int, param3:BitmapData) : void
        {
            this.defaults[param1] = [param3, param2];
            this.drawDefault(param1, param2, param3);
            this.setSelected(param2, param3);
            return;
        }// end function

        public function select(param1:int, param2:Boolean = false) : void
        {
            this.selectedIndex = param1;
            this.selected = this.defaults[param1][1];
            selector.x = 3 + param1 * 16;
            selector.y = 10;
            selector.visible = true;
            if (!param2)
            {
                this.uix.setSelected(this.selected, this.defaults[param1][0]);
            }
            return;
        }// end function

        public function setSelected(param1:int, param2:BitmapData) : void
        {
            var _loc_3:int = 0;
            while (_loc_3 < this.defaults.length)
            {
                
                if (this.defaults[_loc_3][0] == param2)
                {
                }
                if (this.defaults[_loc_3][1] == param1)
                {
                    this.select(_loc_3, true);
                    return;
                }
                _loc_3 = _loc_3 + 1;
            }
            selector.visible = false;
            return;
        }// end function

        public function dragIt(param1:int, param2:BitmapData) : void
        {
            this.dragtype = param1;
            this.indrag = true;
            this.dragbmd = param2;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.handleMouseUp);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
            this.dragbm.bitmapData.fillRect(this.dragbm.bitmapData.rect, 0);
            this.dragbm.bitmapData.copyPixels(param2, new Rectangle(param1 * 16, 0, 16, 16), new Point(0, 0));
            this.dragmc.x = -1000;
            this.dragmc.y = -1000;
            return;
        }// end function

        private function handleMouseMove(event:MouseEvent = null) : void
        {
            stage.addChild(this.dragmc);
            this.dragmc.x = stage.mouseX - 8;
            this.dragmc.y = stage.mouseY - 8;
            if (event)
            {
                event.updateAfterEvent();
            }
            Mouse.hide();
            return;
        }// end function

        private function handleMouseUp(event:MouseEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:Sprite = null;
            Mouse.show();
            if (this.indrag)
            {
                if (this.dragmc.parent)
                {
                    stage.removeChild(this.dragmc);
                }
                this.indrag = false;
                stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleMouseUp);
                stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
                _loc_2 = 0;
                while (_loc_2 < this.sprites.length)
                {
                    
                    _loc_3 = this.sprites[_loc_2] as Sprite;
                    if (_loc_3.hitTestPoint(this.dragmc.x + 8, this.dragmc.y + 8))
                    {
                        this.uix.setDefault(_loc_2, this.dragtype, this.dragbmd);
                        this.setSelected(this.dragtype, this.dragbmd);
                        return;
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
            return;
        }// end function

        private function handleDetatch(event:Event) : void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
            return;
        }// end function

        private function handleKeyDown(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case 16:
                case 17:
                {
                    if (this.selectedIndex != 0)
                    {
                        var _loc_2:* = this.selectedIndex;
                        this.oldvar = this.selectedIndex;
                    }
                    this.select(0);
                    break;
                }
                case 49:
                {
                    break;
                }
                case 50:
                {
                    break;
                }
                case 51:
                {
                    break;
                }
                case 52:
                {
                    break;
                }
                case 53:
                {
                    break;
                }
                case 54:
                {
                    break;
                }
                case 55:
                {
                    break;
                }
                case 56:
                {
                    break;
                }
                case 57:
                {
                    break;
                }
                case 48:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function handleKeyUp(event:KeyboardEvent) : void
        {
            if (this.oldvar != 0)
            {
                if (event.keyCode != 16)
                {
                }
            }
            if (event.keyCode == 17)
            {
                this.select(this.oldvar);
            }
            return;
        }// end function

        private function attachClickHandler(param1:Sprite, param2:int) : void
        {
            var o:* = param1;
            var offset:* = param2;
            o.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                select(offset);
                return;
            }// end function
            );
            return;
        }// end function

        private function drawDefault(param1:int, param2:int, param3:BitmapData) : void
        {
            BitmapData(this.images[param1]).fillRect(new Rectangle(0, 0, 16, 16), 4278190080);
            BitmapData(this.images[param1]).copyPixels(param3, new Rectangle(16 * param2, 0, 16, 16), new Point(0, 0));
            return;
        }// end function

    }
}
