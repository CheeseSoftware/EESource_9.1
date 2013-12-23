package chat
{
    import blitter.*;
    import flash.display.*;
    import sample.ui.components.*;

    public class UserlistItem extends Box
    {
        public var username:String;
        public var time:Number;
        private var _count:int = 0;
        public var canchat:Boolean = false;
        private var bm:Bitmap;

        public function UserlistItem(param1:String, param2:Boolean)
        {
            this.time = new Date().getTime();
            this.canchat = param2;
            this.username = param1;
            this.setText(param1, 0);
            minSize(200, 10);
            return;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            this.setText(this.username, this._count);
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        override public function set width(param1:Number) : void
        {
            return;
        }// end function

        override public function get width() : Number
        {
            return 100;
        }// end function

        private function setText(param1:String, param2:int) : void
        {
            var _loc_6:BlText = null;
            var _loc_7:BitmapData = null;
            if (this.bm)
            {
                removeChild(this.bm);
                this.bm.bitmapData.dispose();
                this.bm = null;
            }
            var _loc_3:* = Player.isAdmin(param1) ? (16757760) : (13421772);
            var _loc_4:* = new BlText(14, 195, this.canchat ? (_loc_3) : (6710886), "left", "visitor");
            _loc_4.text = param1;
            var _loc_5:* = _loc_4.clone();
            if (param2 > 1)
            {
                _loc_6 = new BlText(14, 195, 8947848, "right", "visitor");
                _loc_6.text = param2.toString();
                _loc_7 = _loc_6.clone();
                _loc_5.draw(_loc_7);
            }
            this.bm = new Bitmap(_loc_5);
            addChild(this.bm);
            return;
        }// end function

    }
}
