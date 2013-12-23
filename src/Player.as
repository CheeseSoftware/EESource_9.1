package 
{
    import Player.*;
    import SynchronizedSprite.*;
    import __AS3__.vec.*;
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import playerio.*;

    public class Player extends SynchronizedSprite
    {
        protected var Ding:Class;
        protected var PlayerImage:Class;
        protected var Crown:Class;
        protected var Aura:Class;
        protected var ModAura:Class;
        protected var ding:Sound;
        private var cave:World;
        private var isme:Boolean;
        private var crown:BitmapData;
        private var aura:BitmapData;
        private var modaura:BitmapData;
        private var connection:Connection;
        private var state:PlayState;
        private var chat:Chat;
        private var morx:int = 0;
        private var mory:int = 0;
        public var coins:int = 0;
        public var bcoins:int = 0;
        public var hascrown:Boolean = false;
        public var isgod:Boolean = false;
        public var ismod:Boolean = false;
        private var rect2:Rectangle;
        private var total:Number = 0;
        private var pastx:int = 0;
        private var pasty:int = 0;
        private var queue:Vector.<int>;
        private var lastJump:Number = 0;
        private var changed:Boolean = false;
        private static var admins:Object = {krock:true, era:true};

        public function Player(param1:World, param2:String, param3:Boolean = false, param4:Connection = null, param5:PlayState = null)
        {
            this.Ding = Player_Ding;
            this.PlayerImage = Player_PlayerImage;
            this.Crown = Player_Crown;
            this.Aura = Player_Aura;
            this.ModAura = Player_ModAura;
            this.ding = new this.Ding();
            this.crown = new this.Crown();
            this.aura = new this.Aura();
            this.modaura = new this.ModAura();
            this.rect2 = new Rectangle(0, 0, 16, 26);
            this.queue = new Vector.<int>(20);
            super(new this.PlayerImage());
            this.state = param5;
            this.connection = param4;
            this.cave = param1;
            this.hitmap = param1;
            this.x = 16;
            this.y = 16;
            this.dragX = 0.998;
            this.dragY = 0.998;
            this.isme = param3;
            this.chat = new Chat(param2.indexOf(" ") != -1 ? ("") : (param2));
            size = 16;
            width = 16;
            height = 16;
            return;
        }// end function

        override public function tick() : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:Boolean = false;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            var _loc_15:Boolean = false;
            var _loc_16:Boolean = false;
            if (Bl.now - last > 5000)
            {
                last = Bl.now - 5000;
            }
            var _loc_1:* = last;
            while (_loc_1 < Bl.now)
            {
                
                if (this.isme)
                {
                    _loc_7 = 1;
                    _loc_8 = false;
                    if (Bl.isKeyJustPressed(32))
                    {
                        this.lastJump = -new Date().getTime();
                        _loc_8 = true;
                        _loc_7 = -1;
                    }
                    if (Bl.isKeyDown(32))
                    {
                        _loc_16 = false;
                        if (this.lastJump < 0)
                        {
                            if (new Date().getTime() + this.lastJump > 750)
                            {
                                _loc_16 = true;
                            }
                        }
                        else if (new Date().getTime() - this.lastJump > 150)
                        {
                            _loc_16 = true;
                        }
                        if (_loc_16)
                        {
                            _loc_8 = true;
                        }
                    }
                    _loc_9 = 1;
                    _loc_10 = 0;
                    _loc_11 = 0;
                    if (_loc_8)
                    {
                        if (this.speedY == 0)
                        {
                        }
                        if (this.mory)
                        {
                        }
                        if (this.moy)
                        {
                            this.speedY = this.speedY - this.mory * 280;
                            this.changed = true;
                            this.lastJump = new Date().getTime() * _loc_7;
                        }
                        if (this.speedX == 0)
                        {
                        }
                        if (this.morx)
                        {
                        }
                        if (this.mox)
                        {
                            this.speedX = this.speedX - this.morx * 280;
                            this.changed = true;
                            this.lastJump = new Date().getTime() * _loc_7;
                        }
                    }
                    if (this.moy)
                    {
                        if (!Bl.isKeyDown(37))
                        {
                            Bl.isKeyDown(37);
                        }
                        if (Bl.isKeyDown(65))
                        {
                            _loc_10 = -_loc_9;
                        }
                        else
                        {
                            if (!Bl.isKeyDown(39))
                            {
                                Bl.isKeyDown(39);
                            }
                            if (Bl.isKeyDown(68))
                            {
                                _loc_10 = _loc_9;
                            }
                        }
                    }
                    else if (this.mox)
                    {
                        if (!Bl.isKeyDown(38))
                        {
                            Bl.isKeyDown(38);
                        }
                        if (Bl.isKeyDown(87))
                        {
                            _loc_11 = -_loc_9;
                        }
                        else
                        {
                            if (!Bl.isKeyDown(40))
                            {
                                Bl.isKeyDown(40);
                            }
                            if (Bl.isKeyDown(83))
                            {
                                _loc_11 = _loc_9;
                            }
                        }
                    }
                    else
                    {
                        if (!Bl.isKeyDown(37))
                        {
                            Bl.isKeyDown(37);
                        }
                        if (Bl.isKeyDown(65))
                        {
                            _loc_10 = -_loc_9;
                        }
                        else
                        {
                            if (!Bl.isKeyDown(39))
                            {
                                Bl.isKeyDown(39);
                            }
                            if (Bl.isKeyDown(68))
                            {
                                _loc_10 = _loc_9;
                            }
                        }
                        if (!Bl.isKeyDown(38))
                        {
                            Bl.isKeyDown(38);
                        }
                        if (Bl.isKeyDown(87))
                        {
                            _loc_11 = -_loc_9;
                        }
                        else
                        {
                            if (!Bl.isKeyDown(40))
                            {
                                Bl.isKeyDown(40);
                            }
                            if (Bl.isKeyDown(83))
                            {
                                _loc_11 = _loc_9;
                            }
                        }
                    }
                    _loc_12 = (x + 8) / 16;
                    _loc_13 = (y + 8) / 16;
                    _loc_14 = this.cave.getTile(_loc_12, _loc_13);
                    _loc_15 = false;
					var _loc_17:Player = null;
					var _loc_18:int = 0;
                    if (_loc_14 >= 100)
                    {
                        if (_loc_14 == 100)
                        {
                            if (Bl.data.playSounds)
                            {
                                this.ding.play();
                            }
                            this.cave.setTileComplex(_loc_12, _loc_13, _loc_14 + 10, null);
                            _loc_17 = this;
                            _loc_18 = this.coins + 1;
                            _loc_17.coins = _loc_18;
                            _loc_15 = true;
                        }
                        else if (_loc_14 == 101)
                        {
                            if (Bl.data.playSounds)
                            {
                                this.ding.play();
                            }
                            this.cave.setTileComplex(_loc_12, _loc_13, _loc_14 + 10, null);
                            _loc_17 = this;
                            _loc_18 = this.bcoins + 1;
                            _loc_17.bcoins = _loc_18;
                        }
                    }
                    if (this.mx == _loc_10)
                    {
                    }
                    if (this.my == _loc_11)
                    {
                    }
                    if (this.changed)
                    {
                        this.mx = _loc_10;
                        this.my = _loc_11;
                        if (this.connection.connected)
                        {
                            this.connection.send("m", this.x, this.y, this.speedX, this.speedY, this.modifierX, this.modifierY, this.mx, this.my, this.coins);
                        }
                        _loc_15 = false;
                    }
                    if (_loc_15)
                    {
                        this.connection.send("c", this.coins, this.x, this.y);
                    }
                    Bl.resetJustPressed();
                    this.changed = false;
                }
                _loc_2 = 2;
                _loc_3 = this.x + 8 >> 4;
                _loc_4 = this.y + 8 >> 4;
                _loc_5 = this.cave.getTile(_loc_3, _loc_4);
                this.queue.push(_loc_5);
                _loc_6 = this.queue.shift();
                if (!this.isgod)
                {
                }
                if (this.ismod)
                {
                    this.morx = 0;
                    this.mory = 0;
                }
                else
                {
                    switch(_loc_5)
                    {
                        case 1:
                        {
                            this.morx = -_loc_2;
                            this.mory = 0;
                            break;
                        }
                        case 2:
                        {
                            this.morx = 0;
                            this.mory = -_loc_2;
                            break;
                        }
                        case 3:
                        {
                            this.morx = _loc_2;
                            this.mory = 0;
                            break;
                        }
                        case 4:
                        {
                            this.morx = 0;
                            this.mory = 0;
                            break;
                        }
                        default:
                        {
                            this.morx = 0;
                            this.mory = _loc_2;
                            break;
                            break;
                        }
                    }
                }
                if (!this.isgod)
                {
                }
                if (this.ismod)
                {
                    this.mox = 0;
                    this.moy = 0;
                }
                else
                {
                    switch(_loc_6)
                    {
                        case 1:
                        {
                            this.mox = -_loc_2;
                            this.moy = 0;
                            break;
                        }
                        case 2:
                        {
                            this.mox = 0;
                            this.moy = -_loc_2;
                            break;
                        }
                        case 3:
                        {
                            this.mox = _loc_2;
                            this.moy = 0;
                            break;
                        }
                        case 4:
                        {
                            this.mox = 0;
                            this.moy = 0;
                            break;
                        }
                        default:
                        {
                            this.mox = 0;
                            this.moy = _loc_2;
                            break;
                            break;
                        }
                    }
                }
                this.modifierX = this.mox + mx;
                this.modifierY = this.moy + my;
                if (this.isme)
                {
                    if (this.pastx == _loc_3)
                    {
                    }
                    if (this.pasty != _loc_4)
                    {
                        switch(_loc_5)
                        {
                            case 5:
                            {
                                if (!this.hascrown)
                                {
                                    this.connection.send(Bl.data.m + "k");
                                }
                                break;
                            }
                            case 6:
                            {
                                this.connection.send(Bl.data.m + "r");
                                this.state.showRed();
                                break;
                            }
                            case 7:
                            {
                                this.connection.send(Bl.data.m + "g");
                                this.state.showGreen();
                                break;
                            }
                            case 8:
                            {
                                this.connection.send(Bl.data.m + "b");
                                this.state.showBlue();
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        this.pastx = _loc_3;
                        this.pasty = _loc_4;
                    }
                }
                update();
                _loc_1 = _loc_1 + 1;
            }
            last = Bl.now;
            return;
        }// end function

        public function drawChat(param1:BitmapData, param2:Number, param3:Number, param4:Boolean) : void
        {
            this.chat.drawChat(param1, param2 + _x, param3 + _y, param4);
            return;
        }// end function

        public function enterChat() : void
        {
            this.chat.enterFrame();
            return;
        }// end function

        public function say(param1:String) : void
        {
            this.chat.say(param1);
            return;
        }// end function

        public function resetCoins() : void
        {
            this.coins = 0;
            this.bcoins = 0;
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:Number, param3:Number) : void
        {
            if (this.isgod)
            {
                param1.copyPixels(this.aura, this.aura.rect, new Point(_x + param2 - 5, _y + param3 - 5));
            }
            else if (this.ismod)
            {
                param1.copyPixels(this.modaura, this.modaura.rect, new Point(_x + param2 - 24, _y + param3 - 24));
            }
            param1.copyPixels(bmd, this.rect2, new Point(x + param2, y + param3 - 5));
            if (this.hascrown)
            {
                param1.copyPixels(this.crown, this.crown.rect, new Point(_x + param2, _y + param3 - 6));
            }
            return;
        }// end function

        override public function set frame(param1:int) : void
        {
            this.rect2.x = param1 * 16;
            return;
        }// end function

        override public function get frame() : int
        {
            return this.rect2.x / 16;
        }// end function

        public static function isAdmin(param1:String) : Boolean
        {
            if (!admins[param1])
            {
            }
            return false;
        }// end function

    }
}
