package sample.ui.components
{
    import flash.display.*;

    public class Rows extends Component
    {
        private var _spacing:Number = 10;

        public function Rows(... args)
        {
            args = null;
            for each (args in args)
            {
                
                this.addChild(args);
            }
            return;
        }// end function

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            var _loc_2:* = super.addChild(param1);
            this.redraw();
            return _loc_2;
        }// end function

        override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            var _loc_3:* = super.addChildAt(param1, param2);
            this.redraw();
            return _loc_3;
        }// end function

        override public function removeChild(param1:DisplayObject) : DisplayObject
        {
            var _loc_2:* = super.removeChild(param1);
            this.redraw();
            return _loc_2;
        }// end function

        public function removeChildren() : void
        {
            while (numChildren)
            {
                
                super.removeChild(getChildAt(0));
            }
            this.redraw();
            return;
        }// end function

        public function spacing(param1:Number)
        {
            this._spacing = param1;
            this.redraw();
            return this;
        }// end function

        override protected function redraw() : void
        {
            var _loc_3:DisplayObject = null;
            var _loc_1:Number = 0;
            var _loc_2:int = 0;
            while (_loc_2 < numChildren)
            {
                
                _loc_3 = getChildAt(_loc_2);
                _loc_3.y = _loc_1;
                _loc_3.width = _width;
                _loc_1 = _loc_1 + (_loc_3.height + this._spacing);
                _loc_2 = _loc_2 + 1;
            }
            super.redraw();
            _height = _loc_1;
            return;
        }// end function

    }
}
