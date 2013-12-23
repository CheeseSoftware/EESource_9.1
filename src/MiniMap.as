package 
{
    import MiniMap.*;
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;
    import playerio.*;

    public class MiniMap extends BlObject
    {
        private var bmd:BitmapData;
        private var playermap:BitmapData;
        private var colors:Array;

        public function MiniMap(param1:Array, param2:Connection, param3:int, param4:int)
        {
            var row:Array;
            var b:int;
            var level:* = param1;
            var connection:* = param2;
            var width:* = param3;
            var height:* = param4;
            this.colors = [4278190080, 4278190080, 4278190080, 4278190080, 4278190080, 4282595615, 4281080346, 4279905306, 4279900716, 4285427310, 4281684648, 4288099751, 4289213780, 4287866933, 4282558518, 4281704102, 4287315465, 4280577869, 4283311215, 4282614544, 4285473833, 4285488420, 4287191826, 4288425286, 4281834544, 4281156764, 4288425286, 4281834544, 4281156764, 4288783269, 4292835905, 4293962023, 4291792930, 4278190080, 4282737427, 4282737427, 4282737427, 4291715791, 4283091074, 4283270342, 4291782224, 4291995973, 4288321167, 4290285077, 0, 4285686091, 4285426528, 4287525711, 4286533419, 4285887861];
            this.bmd = new BitmapData(width, height, true, 4278190080);
            this.playermap = new BitmapData(width, height, true, 0);
            this.x = 640 - width - 2;
            this.y = 470 - height - 2;
            var cols:* = level;
            var a:int;
            while (a < cols.length)
            {
                
                row = cols[a];
                b;
                while (b < row.length)
                {
                    
                    this.bmd.setPixel32(b, a, this.getColor(parseInt(row[b])));
                    b = (b + 1);
                }
                a = (a + 1);
            }
            if (connection != null)
            {
                connection.addMessageHandler("b", function (param1:Message, param2:int, param3:int, param4:int) : void
            {
                bmd.setPixel32(param2, param3, getColor(param4));
                return;
            }// end function
            );
                connection.addMessageHandler("bc", function (param1:Message, param2:int, param3:int, param4:int) : void
            {
                bmd.setPixel32(param2, param3, getColor(param4));
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function showPlayer(param1:Player, param2:Number) : void
        {
            this.playermap.setPixel32(param1.x >> 4, param1.y >> 4, param2);
            return;
        }// end function

        public function clear() : void
        {
            this.playermap.colorTransform(this.playermap.rect, new ColorTransform(1, 1, 1, 1 - 1 / 64));
            return;
        }// end function

        public function reset(param1:Array) : void
        {
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_2:* = param1;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    this.bmd.setPixel32(_loc_5, _loc_3, this.getColor(parseInt(_loc_4[_loc_5])));
                    _loc_5 = _loc_5 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:Number, param3:Number) : void
        {
            param1.copyPixels(this.bmd, this.bmd.rect, new Point(x, y));
            param1.copyPixels(this.playermap, this.playermap.rect, new Point(x, y));
            this.clear();
            return;
        }// end function

        public function getColor(param1:int) : uint
        {
            if (param1 < this.colors.length)
            {
                return this.colors[param1];
            }
            return 4278190080;
        }// end function

    }
}
