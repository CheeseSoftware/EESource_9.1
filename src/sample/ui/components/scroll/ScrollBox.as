package sample.ui.components.scroll
{
    import flash.*;
    import flash.display.*;
    import flash.geom.*;
    
    import sample.ui.components.*;

    public class ScrollBox extends Box
    {
        private var _container:Sprite;
        private var _mask:Sprite;
        private var _scrollX:Number = 0;
        private var _scrollY:Number = 0;
        private var hscroll:ScrollBar;

        public function ScrollBox()
        {
            this._container = new Sprite();
            this._mask = new Sprite();
            this.hscroll = new ScrollBar();
            super.addChild(this._container);
            super.addChild(this._mask);
            super.addChild(this.hscroll);
            this._mask.graphics.beginFill(0, 1);
            this._mask.graphics.drawRect(0, 0, 100, 100);
            this._mask.graphics.endFill();
            this.hscroll.scroll(function (param1:Number) : void
            {
                scrollY = param1;
                return;
            }// end function
            );
            this._container.mask = this._mask;
            return;
        }// end function

        override public function add(... args) : Box
        {
            args = null;
            for each (args in args)
            {
                
                this._container.addChild(args);
            }
            this.redraw();
            return this;
        }// end function

        public function set scrollX(param1:Number) : void
        {
            this._scrollX = param1;
            this.redraw();
            return;
        }// end function

        public function set scrollY(param1:Number) : void
        {
            this.hscroll.scrollValue = param1;
            this._scrollY = param1;
            this.redraw();
            return;
        }// end function

        public function get scrollWidth() : Number
        {
            return this._container.width - this._mask.width;
        }// end function

        public function get scrollHeight() : Number
        {
            return this._container.height - this._mask.height;
        }// end function

        public function get scrollX() : Number
        {
            return this._scrollX;
        }// end function

        public function get scrollY() : Number
        {
            return this._scrollY;
        }// end function

        override public function get width() : Number
        {
            return _width;
        }// end function

        override public function get height() : Number
        {
            return _height;
        }// end function

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            return this._container.addChild(param1);
        }// end function

        override public function removeChild(param1:DisplayObject) : DisplayObject
        {
            return this._container.removeChild(param1);
        }// end function

        public function refresh() : void
        {
            this.redraw();
            return;
        }// end function

        override protected function redraw() : void
        {
			if(this._container == null)
			{
				this._container = new Sprite();
				this._mask = new Sprite();
				this.hscroll = new ScrollBar();
				super.addChild(this._container);
				super.addChild(this._mask);
				super.addChild(this.hscroll);
				this._mask.graphics.beginFill(0, 1);
				this._mask.graphics.drawRect(0, 0, 100, 100);
				this._mask.graphics.endFill();
				this.hscroll.scroll(function (param1:Number) : void
				{
					scrollY = param1;
					return;
				}// end function
				);
				this._container.mask = this._mask;
			}
            var _loc_1:* = _width;
            if (this._container.height > _height)
            {
                _width = _width - 10;
                this.hscroll.visible = true;
                this.hscroll.scrollViewable = _height;
                if (!_top)
                {
                }
                if (!_bottom)
                {
                }
                this.hscroll.scrollSize = this._container.height + 0 + 0;
            }
            else
            {
                this.hscroll.visible = false;
                this.hscroll.scrollValue = 0;
            }
            super.redraw();
            this._scrollX = Math.max(Math.min(this._scrollX, this.scrollWidth), 0);
            this._scrollY = Math.max(Math.min(this._scrollY, this.scrollHeight), 0);
            this._container.x = this._container.x - (this._scrollX + 1);
            this._container.y = this._container.y - (this._scrollY + 1);
            this.hscroll.x = _width;
            this.hscroll.y = 0;
            this.hscroll.height = Math.ceil(_height);
            _width = _loc_1;
            this.scrollRect = new Rectangle(0, 0, (_width + 1), (_height + 1));
            return;
        }// end function

    }
}
