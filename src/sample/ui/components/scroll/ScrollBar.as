package sample.ui.components.scroll
{
    import flash.events.*;
    import sample.ui.components.*;

    public class ScrollBar extends Component
    {
        private var decArrow:ScrollButton;
        private var incArrow:ScrollButton;
        private var scrollbg:Box;
        private var tracker:ScrollTracker;
        private var _scrollSize:Number = 1000;
        private var _scrollViewable:Number = 200;
        private var _scrollValue:Number = 0;
        private var scrollListener:Function;
        private var _mouseY:Number;
        private var _mouseX:Number;
        private var pixelSize:int = 10;

        public function ScrollBar(param1:Boolean = false)
        {
            var horizontal:* = param1;
            this.decArrow = new ScrollButton(1, this.pixelSize, this.decScroll);
            this.incArrow = new ScrollButton(3, this.pixelSize, this.incScroll);
            this.scrollbg = new Box().fill(0, 1, 3);
            this.tracker = new ScrollTracker();
            this.scrollbg.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                if (scrollbg.mouseY > tracker.y)
                {
                    incScrollJump();
                }
                else
                {
                    decScrollJump();
                }
                return;
            }// end function
            );
            this.tracker.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                var handleMove:Function;
                var e:* = event;
                handleMove = function (event:Event) : void
                {
                    changeByPx(tracker.mouseY - _mouseY);
                    if (tracker.upState.parent)
                    {
                        tracker.removeEventListener(Event.ENTER_FRAME, handleMove);
                    }
                    return;
                }// end function
                ;
                _mouseY = tracker.mouseY;
                tracker.addEventListener(Event.ENTER_FRAME, handleMove);
                tracker.addEventListener(MouseEvent.MOUSE_UP, function (event:MouseEvent) : void
                {
                    tracker.removeEventListener(Event.ENTER_FRAME, handleMove);
                    tracker.removeEventListener(MouseEvent.MOUSE_UP, arguments.callee);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            addChild(this.scrollbg);
            addChild(this.tracker);
            addChild(this.decArrow);
            addChild(this.incArrow);
            this.tracker.width = this.pixelSize;
            this.tracker.x = 0;
            this.redraw();
            return;
        }// end function

        public function changeByPx(param1:Number) : void
        {
            this.scrollValue = this.scrollValue + this._scrollSize / this.innerSize * param1;
            return;
        }// end function

        public function decScroll() : void
        {
            this.scrollValue = this._scrollValue - 15;
            return;
        }// end function

        public function incScroll() : void
        {
            this.scrollValue = this._scrollValue + 15;
            return;
        }// end function

        public function decScrollJump() : void
        {
            this.scrollValue = this._scrollValue - this._scrollViewable;
            return;
        }// end function

        public function incScrollJump() : void
        {
            this.scrollValue = this._scrollValue + this._scrollViewable;
            return;
        }// end function

        public function set scrollSize(param1:Number) : void
        {
            this._scrollSize = param1;
            this._scrollValue = Math.max(Math.min(this._scrollValue, this._scrollSize - this._scrollViewable), 0);
            return;
        }// end function

        public function set scrollViewable(param1:Number) : void
        {
            this._scrollViewable = param1;
            this._scrollValue = Math.max(Math.min(this._scrollValue, this._scrollSize - this._scrollViewable), 0);
            return;
        }// end function

        public function set scrollValue(param1:Number) : void
        {
            if (param1 != this._scrollValue)
            {
                this._scrollValue = Math.max(Math.min(param1, this._scrollSize - this._scrollViewable), 0);
                if (this.scrollListener != null)
                {
                    this.scrollListener(this._scrollValue);
                }
                this.redraw();
            }
            return;
        }// end function

        public function get scrollValue() : Number
        {
            return this._scrollValue;
        }// end function

        public function scroll(param1:Function) : void
        {
            this.scrollListener = param1;
            return;
        }// end function

        private function get innerSize() : Number
        {
            return _height - this.pixelSize * 2;
        }// end function

        override public function get width() : Number
        {
            return _width;
        }// end function

        override public function get height() : Number
        {
            return _height;
        }// end function

        override protected function redraw() : void
        {
            this.tracker.height = Math.max(this.innerSize * this._scrollViewable / this._scrollSize, 10);
            this.tracker.y = (this.pixelSize + 1) + this._scrollValue / (this._scrollSize - this._scrollViewable) * (this.innerSize - this.tracker.height - 1);
            this.scrollbg.width = this.pixelSize;
            this.scrollbg.height = _height;
            this.incArrow.y = _height - this.pixelSize;
            return;
        }// end function

    }
}
