package ui
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import ui2.*;

    public class BrickSelector extends ui2brickselector
    {
        private var packages:Array;
        private var basiswidth:int = 450;
        private var masker:Sprite;
        private var bg:Sprite;

        public function BrickSelector()
        {
            this.packages = [];
            this.masker = new Sprite();
            this.bg = new Sprite();
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            addChild(this.bg);
            addChild(this.masker);
            this.mask = this.masker;
            this.bg.filters = [new DropShadowFilter(0, 45, 0, 1, 4, 4, 1, 3)];
            return;
        }// end function

        public function addPackage(param1:BrickPackage) : void
        {
            this.packages.push(param1);
            addChild(param1);
            return;
        }// end function

        public function getPosition(param1:int) : Point
        {
            var _loc_2:Point = null;
            var _loc_3:int = 0;
            while (_loc_3 < this.packages.length)
            {
                
                if (!this.packages[_loc_3].getPosition(param1))
                {
                    this.packages[_loc_3].getPosition(param1);
                }
                _loc_2 = _loc_2;
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function setSelected(param1:int, param2:BitmapData) : void
        {
            var _loc_3:int = 0;
            while (_loc_3 < this.packages.length)
            {
                
                this.packages[_loc_3].setSelected(param1, param2);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        override public function get width() : Number
        {
            return this.basiswidth;
        }// end function

        private function redraw() : void
        {
            var _loc_1:int = 5;
            var _loc_2:int = 5;
            var _loc_3:int = 0;
            while (_loc_3 < this.packages.length)
            {
                
                if (_loc_1 + this.packages[_loc_3].width + 5 >= this.basiswidth)
                {
                    _loc_1 = 5;
                    _loc_2 = _loc_2 + 30;
                }
                this.packages[_loc_3].x = _loc_1;
                this.packages[_loc_3].y = _loc_2;
                _loc_1 = _loc_1 + (this.packages[_loc_3].width + 5);
                _loc_3 = _loc_3 + 1;
            }
            _loc_2 = _loc_2 + 30;
            var _loc_4:* = this.bg.graphics;
            _loc_4.clear();
            _loc_4.lineStyle(1, 8092539, 1);
            _loc_4.beginFill(3289649, 0.85);
            _loc_4.drawRect(0, 0, this.basiswidth, _loc_2 + 5);
            this.y = -_loc_2 - 35;
            var _loc_5:* = this.masker.graphics;
            _loc_5.clear();
            _loc_5.beginFill(16777215, 1);
            _loc_5.drawRect(-5, -5, (this.basiswidth + 1) + 10, _loc_2 + 10);
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            this.redraw();
            return;
        }// end function

    }
}
