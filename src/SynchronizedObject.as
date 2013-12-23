package 
{
    import SynchronizedObject.*;
    import blitter.*;

    public class SynchronizedObject extends BlObject
    {
        protected var _speedX:Number = 0;
        protected var _speedY:Number = 0;
        protected var _modifierX:Number = 0;
        protected var _modifierY:Number = 0;
        protected var _dragX:Number = 0;
        protected var _dragY:Number = 0;
        protected var _sdragX:Number = 0.99;
        protected var _sdragY:Number = 0.99;
        public var mox:Number = 0;
        public var moy:Number = 0;
        public var mx:Number = 0;
        public var my:Number = 0;
        public var last:Number = 0;
        protected var offset:Number = 0;

        public function SynchronizedObject()
        {
            this.last = new Date().getTime();
            return;
        }// end function

        override public function update() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            if (!this._speedX)
            {
            }
            if (this._modifierX)
            {
                this._speedX = this._speedX + this._modifierX;
                this._speedX = this._speedX * this._dragX;
                if (this.mx == 0)
                {
                }
                if (this.moy == 0)
                {
                    if (this._speedX < 0)
                    {
                    }
                }
                if (this.mx <= 0)
                {
                    if (this._speedX > 0)
                    {
                    }
                }
                if (this.mx < 0)
                {
                    this._speedX = this._speedX * this._sdragX;
                }
                if (hitmap != null)
                {
                    _loc_1 = _x;
                    _x = _x + this._speedX;
                    if (hitmap.overlaps(this))
                    {
                        _x = Math.round(_loc_1);
                        this._speedX = 0;
                    }
                }
                else
                {
                    _x = _x + this._speedX;
                }
            }
            if (!this._speedY)
            {
            }
            if (this._modifierY)
            {
                this._speedY = this._speedY + this._modifierY;
                this._speedY = this._speedY * this._dragY;
                if (this.my == 0)
                {
                }
                if (this.mox == 0)
                {
                    if (this._speedY < 0)
                    {
                    }
                }
                if (this.my <= 0)
                {
                    if (this._speedY > 0)
                    {
                    }
                }
                if (this.my < 0)
                {
                    this._speedY = this._speedY * this._sdragY;
                }
                if (hitmap != null)
                {
                    _loc_2 = _y;
                    _y = _y + this._speedY;
                    if (hitmap.overlaps(this))
                    {
                        _y = Math.round(_loc_2);
                        this._speedY = 0;
                    }
                }
                else
                {
                    _y = _y + this._speedY;
                }
            }
            if (this._speedX * 512 >> 0 == 0)
            {
            }
            moving = this._speedY * 512 >> 0 != 0;
            return;
        }// end function

        public function get speedX() : Number
        {
            return this._speedX * 1000;
        }// end function

        public function set speedX(param1:Number) : void
        {
            this._speedX = param1 / 1000;
            return;
        }// end function

        public function get speedY() : Number
        {
            return this._speedY * 1000;
        }// end function

        public function set speedY(param1:Number) : void
        {
            this._speedY = param1 / 1000;
            return;
        }// end function

        public function get modifierX() : Number
        {
            return this._modifierX * 1000;
        }// end function

        public function set modifierX(param1:Number) : void
        {
            this._modifierX = param1 / 1000;
            return;
        }// end function

        public function get modifierY() : Number
        {
            return this._modifierY * 1000;
        }// end function

        public function set modifierY(param1:Number) : void
        {
            this._modifierY = param1 / 1000;
            return;
        }// end function

        public function get dragX() : Number
        {
            return this._dragX;
        }// end function

        public function set dragX(param1:Number) : void
        {
            this._dragX = param1;
            return;
        }// end function

        public function get dragY() : Number
        {
            return this._dragY;
        }// end function

        public function set dragY(param1:Number) : void
        {
            this._dragY = param1;
            return;
        }// end function

    }
}
