package sample.ui.components
{
    import flash.display.*;

    public class Box extends Component
    {
        protected var _top:Number = NaN;
        protected var _bottom:Number = NaN;
        protected var _left:Number = NaN;
        protected var _right:Number = NaN;
        protected var _color:int;
        protected var _corner:Number = 0;
        protected var _alpha:Number;
        protected var _strokeWidth:Number;
        protected var _strokeColor:Number;
        protected var _strokeAlpha:Number;
        protected var useFill:Boolean = false;

        public function Box()
        {
            this.redraw();
            return;
        }// end function

        public function margin(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN, param4:Number = NaN)
        {
            this._top = param1;
            this._right = param2;
            this._bottom = param3;
            this._left = param4;
            this.redraw();
            return this;
        }// end function

        public function fill(param1:int = 0, param2:Number = 1, param3:Number = 0)
        {
            _width = width;
            _height = height;
            this._color = param1;
            this._corner = param3;
            this._alpha = param2;
            this.useFill = true;
            this.redraw();
            return this;
        }// end function

        public function border(param1:Number = 0, param2:Number = 0, param3:Number = 1)
        {
            this._strokeWidth = param1;
            this._strokeColor = param2;
            this._strokeAlpha = param3;
            this.redraw();
            return this;
        }// end function

        public function minSize(param1:Number, param2:Number) : Box
        {
            this.minWidth = param1;
            this.minHeight = param2;
            this.redraw();
            return this;
        }// end function

        public function add(... args) : Box
        {
            args = null;
            for each (args in args)
            {
                
                addChild(args);
            }
            this.redraw();
            return this;
        }// end function

        protected function get borderHeight() : Number
        {
            return (this._top ? (this._top) : (0)) + (this._bottom ? (this._bottom) : (0));
        }// end function

        protected function get borderWidth() : Number
        {
            return (this._left ? (this._left) : (0)) + (this._right ? (this._right) : (0));
        }// end function

        public function reset(param1:Boolean = true, param2:Array = null) : void
        {
            var _loc_4:DisplayObject = null;
            var _loc_5:Function = null;
            if (param1)
            {
                param2 = [];
            }
            var _loc_3:int = 0;
            while (_loc_3 < numChildren)
            {
                
                _loc_4 = getChildAt(_loc_3);
                if (_loc_4 is Box)
                {
                    (_loc_4 as Box).reset(false, param2);
                }
                _loc_3 = _loc_3 + 1;
            }
            param2.push(this.redraw);
            if (param1)
            {
                for each (_loc_5 in param2)
                {
                    
                    this._loc_5();
                    this._loc_5();
                }
            }
            return;
        }// end function

        override protected function redraw() : void
        {
            var _loc_4:DisplayObject = null;
            var _loc_1:* = _width;
            var _loc_2:* = _height;
            var _loc_3:int = 0;
            while (_loc_3 < numChildren)
            {
                
                _loc_4 = getChildAt(_loc_3);
                _loc_1 = Math.max(_loc_1, _loc_4.width + this.borderWidth);
                _loc_2 = Math.max(_loc_2, _loc_4.height + this.borderHeight);
                if (!isNaN(this._left))
                {
                    _loc_4.x = this._left;
                    if (!isNaN(this._right))
                    {
                        _loc_4.width = rwidth - this.borderWidth;
                    }
                }
                else if (!isNaN(this._right))
                {
                    _loc_4.x = _loc_1 - _loc_4.width - this._right;
                }
                else
                {
                    _loc_4.x = (Math.max(rwidth, _loc_1) - _loc_4.width) / 2;
                }
                if (!isNaN(this._top))
                {
                    _loc_4.y = this._top;
                    if (!isNaN(this._bottom))
                    {
                        _loc_4.height = rheight - this.borderHeight;
                    }
                }
                else if (!isNaN(this._bottom))
                {
                    _loc_4.y = _loc_2 - _loc_4.height - this._bottom;
                }
                else
                {
                    _loc_4.y = (Math.max(rheight, _loc_2) - _loc_4.height) / 2;
                }
                _loc_3 = _loc_3 + 1;
            }
            graphics.clear();
            if (this._strokeWidth)
            {
                graphics.lineStyle(this._strokeWidth, this._strokeColor, this._strokeAlpha, true);
                if (!_minWidth)
                {
                }
                if (_minHeight)
                {
                    graphics.drawRoundRect(0, 0, Math.max(rwidth, _loc_1), Math.max(rheight, _loc_2), this._corner);
                }
                else
                {
                    graphics.drawRoundRect(0, 0, Math.max(rwidth, _width), Math.max(rheight, _height), this._corner);
                }
            }
            if (this.useFill)
            {
                graphics.beginFill(this._color, this._alpha);
                if (!_minWidth)
                {
                }
                if (_minHeight)
                {
                    graphics.drawRoundRect(0, 0, Math.max(rwidth, _loc_1), Math.max(rheight, _loc_2), this._corner);
                }
                else
                {
                    graphics.drawRoundRect(0, 0, Math.max(rwidth, _width), Math.max(rheight, _height), this._corner);
                }
                graphics.endFill();
            }
            return;
        }// end function

    }
}
