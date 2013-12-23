package blitter
{
    import flash.display.*;
    import flash.geom.*;

    public class BlTilemap extends BlObject
    {
        protected var rect:Rectangle;
        protected var bmd:BitmapData;
        protected var size:int;
        protected var map:Array;
        protected var hitOffset:int;
        protected var hitEnd:int;

        public function BlTilemap(param1:Bitmap, param2:int = 1, param3:int = 99)
        {
            this.map = [[]];
            this.bmd = param1.bitmapData;
			if(this.bmd)
			{
            	this.rect = new Rectangle(0, 0, this.bmd.height, this.bmd.height);
            	this.size = this.bmd.height;
			}
			else
			{
				this.rect = new Rectangle(0, 0, 16, 16);
				this.size = 16;
			}
            this.hitOffset = param2;
            this.hitEnd = param3;
            return;
        }// end function

        public function setMapArray(param1:Array) : void
        {
            this.map = param1;
            height = param1.length;
            width = param1[0].length;
            return;
        }// end function

        public function setMapString(param1:String) : void
        {
            var _loc_5:Array = null;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_2:* = param1.split("\n");
            var _loc_3:* = new Array();
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = _loc_2[_loc_4].split(",");
                _loc_6 = [];
                _loc_3.push(_loc_6);
                _loc_7 = 0;
                while (_loc_7 < _loc_5.length)
                {
                    
                    _loc_6.push(parseInt(_loc_5[_loc_7]));
                    _loc_7 = _loc_7 + 1;
                }
                _loc_4 = _loc_4 + 1;
            }
            this.setMapArray(_loc_3);
            return;
        }// end function

        public function overlaps(param1:BlObject) : Boolean
        {
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_2:* = param1.x / this.size;
            var _loc_3:* = param1.y / this.size;
            var _loc_4:* = _loc_3 + (param1.width - 1) / this.size;
            var _loc_5:* = _loc_2 + (param1.height - 1) / this.size;
            var _loc_6:* = _loc_3;
            while (_loc_6 < _loc_4)
            {
                
                if (this.map[_loc_6] != null)
                {
                    _loc_7 = _loc_2;
                    while (_loc_7 < _loc_4)
                    {
                        
                        _loc_8 = this.map[_loc_6][_loc_7];
                        if (_loc_8 >= this.hitOffset)
                        {
                        }
                        if (_loc_8 <= this.hitEnd)
                        {
                            return true;
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            return false;
        }// end function

        protected function setTile(param1:int, param2:int, param3:int) : void
        {
            if (this.map[param2] != null)
            {
                if (this.map[param2][param1] != null)
                {
                    this.map[param2][param1] = param3;
                }
            }
            return;
        }// end function

        public function getTile(param1:int, param2:int) : int
        {
            if (this.map[param2] != null)
            {
                if (this.map[param2][param1] != null)
                {
                    return this.map[param2][param1];
                }
            }
            return 0;
        }// end function

        override public function draw(param1:BitmapData, param2:Number, param3:Number) : void
        {
            var _loc_11:Array = null;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_4:* = param2 >> 0;
            var _loc_5:* = param3 >> 0;
            var _loc_6:* = (-param3) / this.size;
            var _loc_7:* = (-param2) / this.size;
            var _loc_8:* = _loc_6 + Bl.height / this.size + 1;
            var _loc_9:* = _loc_7 + Bl.width / this.size + 1;
            if (_loc_6 < 0)
            {
                _loc_6 = 0;
            }
            if (_loc_7 < 0)
            {
                _loc_7 = 0;
            }
            if (_loc_8 > height)
            {
                _loc_8 = height;
            }
            if (_loc_9 > width)
            {
                _loc_9 = width;
            }
            var _loc_10:* = _loc_6;
            while (_loc_10 < _loc_8)
            {
                
                _loc_11 = this.map[_loc_10] as Array;
                _loc_12 = _loc_7;
                while (_loc_12 < _loc_9)
                {
                    
                    _loc_13 = _loc_11[_loc_12];
                    this.rect.x = _loc_13 * this.size;
                    param1.copyPixels(this.bmd, this.rect, new Point(_loc_12 * this.size + _loc_4, _loc_10 * this.size + _loc_5));
                    _loc_12 = _loc_12 + 1;
                }
                _loc_10 = _loc_10 + 1;
            }
            return;
        }// end function

    }
}
