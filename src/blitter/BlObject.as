﻿package blitter
{
    import flash.display.*;

    public class BlObject extends Object
    {
        protected var _x:Number = 0;
        protected var _y:Number = 0;
        public var width:int = 1;
        public var height:int = 1;
        public var moving:Boolean = false;
        public var hitmap:BlTilemap;

        public function BlObject()
        {
            return;
        }// end function

        public function update() : void
        {
            return;
        }// end function

        public function draw(param1:BitmapData, param2:Number, param3:Number) : void
        {
            param1.setPixel(Math.round(this._x + param2), Math.round(this._y + param3), 16777215);
            return;
        }// end function

        public function enterFrame() : void
        {
            return;
        }// end function

        public function tick() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < Bl.elapsed)
            {
                
                this.update();
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function exitFrame() : void
        {
            return;
        }// end function

        public function set x(param1:Number) : void
        {
            this._x = param1;
            return;
        }// end function

        public function get x() : Number
        {
            return this._x;
        }// end function

        public function set y(param1:Number) : void
        {
            this._y = param1;
            return;
        }// end function

        public function get y() : Number
        {
            return this._y;
        }// end function

    }
}
