package sample.ui.components
{
    import flash.display.*;

    public class Component extends Sprite
    {
        protected var _width:Number = 0;
        protected var _height:Number = 0;
        protected var _minWidth:Number = 0;
        protected var _minHeight:Number = 0;

        public function Component()
        {
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            if (this._width != param1)
            {
                this._width = param1;
                this.redraw();
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            if (this._height != param1)
            {
                this._height = param1;
                this.redraw();
            }
            return;
        }// end function

        public function get rwidth() : Number
        {
            return Math.max(this._width, this._minWidth);
        }// end function

        public function get rheight() : Number
        {
            return Math.max(this._height, this._minHeight);
        }// end function

        public function set minWidth(param1:Number) : void
        {
            if (this._minWidth != param1)
            {
                this._minWidth = param1;
                this.redraw();
            }
            return;
        }// end function

        public function set minHeight(param1:Number) : void
        {
            if (this._minHeight != param1)
            {
                this._minHeight = param1;
                this.redraw();
            }
            return;
        }// end function

        protected function redraw() : void
        {
            return;
        }// end function

    }
}
