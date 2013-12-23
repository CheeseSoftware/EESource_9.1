package 
{
    import PlayState.*;
    
    import blitter.*;
    
    import flash.display.*;
    
    import playerio.*;

    public class PlayState extends BlState
    {
        protected var TCoin:Class;
        protected var BCoin:Class;
        protected var player:Player;
        protected var cave:World;
        protected var connection:Connection;
        protected var players:Object;
        protected var map:MiniMap;
        protected var totalCoins:int = 0;
        protected var bonusCoins:int = 0;
        protected var cointext:BlText;
        protected var cointextcontainer:BlContainer;
        protected var bcointext:BlText;
        protected var bcointextcontainer:BlContainer;
        protected var rw:int = 0;
        protected var rh:int = 0;
        private var queue:Array;
        private var pastX:uint = 0;
        private var pastY:uint = 0;
        private var pastT:Number;
        private var chatTime:Number;

        public function PlayState(param1:Connection, param2:Message, param3:int, param4:String, param5:int, param6:int, param7:int, param8:int)
        {
            var row:Array;
            var b:int;
            var t:int;
            var c:* = param1;
            var m:* = param2;
            var myid:* = param3;
            var name:* = param4;
            var x:* = param5;
            var y:* = param6;
            var rw:* = param7;
            var rh:* = param8;
            this.TCoin = PlayState_TCoin;
            this.BCoin = PlayState_BCoin;
            this.players = {};
            this.cointextcontainer = new BlContainer();
            this.bcointextcontainer = new BlContainer();
            this.queue = [];
            this.pastT = new Date().getTime();
            this.chatTime = new Date().getTime();
            this.rw = width;
            this.rh = height;
            this.connection = c;
            this.cave = new World();
            var level:* = this.cave.deserializeFromMessage(rw, rh, 9, m);
            add(this.cave);
            var a:int;
			var _loc_10:PlayState = null;
			var _loc_11:int = 0;
            while (a < level.length)
            {
                
                row = level[a];
                b;
                while (b < row.length)
                {
                    
                    t = row[b];
                    if (t == 100)
                    {
                        _loc_10 = this;
                        _loc_11 = this.totalCoins + 1;
                        _loc_10.totalCoins = _loc_11;
                    }
                    if (t == 101)
                    {
                        _loc_10 = this;
                        _loc_11 = this.bonusCoins + 1;
                        _loc_10.bonusCoins = _loc_11;
                    }
                    b = (b + 1);
                }
                a = (a + 1);
            }
            this.player = new Player(this.cave, name, true, c, this);
            this.player.x = x;
            this.player.y = y;
            this.x = -x;
            this.y = -y;
            add(this.player);
            this.cave.setPlayer(this.player);
            target = this.player;
            cameraLag = 200;
            this.player.hitmap = this.cave;
            this.map = new MiniMap(level, c, rw, rh);
            this.cointext = new BlText(12, 100, 16777215, "right");
            this.cointext.x = 526;
            this.cointextcontainer.add(this.cointext);
            this.bcointext = new BlText(12, 100, 16777215, "right");
            this.bcointext.x = 526;
            this.bcointextcontainer.add(this.bcointext);
            var tcoin:* = new BlSprite(new this.TCoin());
            tcoin.x = 626;
            tcoin.y = 4;
            this.cointextcontainer.add(tcoin);
            var btcoin:* = new BlSprite(new this.BCoin());
            btcoin.x = 626;
            btcoin.y = 4;
            this.bcointextcontainer.add(btcoin);
            var s:PlayState;
            this.connection.addMessageHandler("m", function (param1:Message, param2:int, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:int) : void
            {
                var _loc_12:Player = null;
                if (param2 != myid)
                {
                    _loc_12 = players[param2] as Player;
                    if (_loc_12)
                    {
                        _loc_12.x = param3;
                        _loc_12.y = param4;
                        _loc_12.speedX = param5;
                        _loc_12.speedY = param6;
                        _loc_12.modifierX = param7;
                        _loc_12.modifierY = param8;
                        _loc_12.mx = param9;
                        _loc_12.my = param10;
                        _loc_12.coins = param11;
                    }
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("add", function (param1:Message, param2:int, param3:String, param4:int, param5:Number, param6:Number, param7:Boolean, param8:Boolean, param9:int) : void
            {
                var _loc_10:* = players[param2] as Player;
                if (!_loc_10)
                {
                    _loc_10 = new Player(cave, param3);
                    players[param2] = _loc_10;
                    _loc_10.isgod = param7;
                    _loc_10.ismod = param8;
                    _loc_10.x = Math.min(param5, (rw - 2) * 16);
                    _loc_10.y = Math.min(param6, (rh - 2) * 16);
                    _loc_10.frame = param4;
                    _loc_10.coins = param9;
                    addBefore(_loc_10, player);
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("k", function (param1:Message, param2:int) : void
            {
                var _loc_3:String = null;
                var _loc_4:Player = null;
                player.hascrown = param2 == myid;
                for (_loc_3 in players)
                {
                    
                    _loc_4 = players[_loc_3] as Player;
                    _loc_4.hascrown = parseInt(_loc_3) == param2;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("c", function (param1:Message, param2:String, param3:int) : void
            {
                var _loc_4:* = players[param2];
                if (_loc_4 != null)
                {
                    _loc_4.coins = param3;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("b", function (param1:Message, param2:int, param3:int, param4:int) : void
            {
                setTile(param2, param3, param4, null);
                return;
            }// end function
            );
            this.connection.addMessageHandler("bc", function (param1:Message, param2:int, param3:int, param4:int, param5:int) : void
            {
                setTile(param2, param3, param4, {goal:param5});
                return;
            }// end function
            );
            this.connection.addMessageHandler("left", function (param1:Message, param2:int) : void
            {
                var _loc_3:* = players[param2];
                if (_loc_3 != null)
                {
                    delete players[param2];
                    remove(_loc_3);
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("god", function (param1:Message, param2:int, param3:Boolean) : void
            {
                if (param2 == myid)
                {
                    player.isgod = param3;
                }
                var _loc_4:* = players[param2];
                if (_loc_4 != null)
                {
                    _loc_4.isgod = param3;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("lostaccess", function (param1:Message) : void
            {
                var _loc_2:Player = null;
                if (!Bl.data.owner)
                {
                    player.isgod = false;
                }
                for each (_loc_2 in players)
                {
                    
                    _loc_2.isgod = false;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("mod", function (param1:Message, param2:int) : void
            {
                if (param2 == myid)
                {
                    player.ismod = true;
                }
                var _loc_3:* = players[param2];
                if (_loc_3 != null)
                {
                    _loc_3.ismod = true;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("say", function (param1:Message, param2:int, param3:String) : void
            {
                if (param2 == myid)
                {
                    player.say(param3);
                }
                var _loc_4:* = players[param2];
                if (_loc_4 != null)
                {
                    _loc_4.say(param3);
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("face", function (param1:Message, param2:int, param3:int) : void
            {
                var _loc_4:Player = null;
                if (param2 == myid)
                {
                    player.frame = param3;
                }
                else
                {
                    _loc_4 = players[param2] as Player;
                    if (_loc_4)
                    {
                        _loc_4.frame = param3;
                    }
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("hide", function (param1:Message, param2:String) : void
            {
                switch(param2)
                {
                    case "red":
                    {
                        showRed();
                        break;
                    }
                    case "green":
                    {
                        showGreen();
                        break;
                    }
                    case "blue":
                    {
                        showBlue();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("show", function (param1:Message, param2:String) : void
            {
                switch(param2)
                {
                    case "red":
                    {
                        hideRed();
                        break;
                    }
                    case "green":
                    {
                        hideGreen();
                        break;
                    }
                    case "blue":
                    {
                        hideBlue();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("reset", function (param1:Message) : void
            {
                var _loc_4:Array = null;
                var _loc_5:int = 0;
                var _loc_6:int = 0;
                var _loc_2:* = cave.deserializeFromMessage(rw, rh, 0, param1);
                map.reset(_loc_2);
                cave.setMapArray(_loc_2);
                player.coins = 0;
                player.bcoins = 0;
                totalCoins = 0;
                bonusCoins = 0;
                var _loc_3:int = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_4 = _loc_2[_loc_3];
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4.length)
                    {
                        
                        _loc_6 = _loc_4[_loc_5];
                        if (_loc_6 == 100)
                        {
                            var _loc_8:* = totalCoins + 1;
                            totalCoins = _loc_8;
                        }
                        if (_loc_6 == 101)
                        {
                            var _loc_834:* = bonusCoins + 1;
                            bonusCoins = _loc_834;
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("clear", function (param1:Message, param2:int, param3:int) : void
            {
                var _loc_6:int = 0;
                var _loc_4:Array = [];
                var _loc_5:int = 0;
                while (_loc_5 < param3)
                {
                    
                    _loc_4[_loc_5] = [];
                    _loc_6 = 0;
                    while (_loc_6 < param2)
                    {
                        
                        _loc_4[_loc_5][_loc_6] = 0;
                        _loc_6 = _loc_6 + 1;
                    }
                    _loc_5 = _loc_5 + 1;
                }
                _loc_5 = 0;
                while (_loc_5 < rh)
                {
                    
                    _loc_4[_loc_5][0] = 9;
                    _loc_4[_loc_5][(rw - 1)] = 9;
                    _loc_5 = _loc_5 + 1;
                }
                _loc_5 = 0;
                while (_loc_5 < rw)
                {
                    
                    _loc_4[0][_loc_5] = 9;
                    _loc_4[(rh - 1)][_loc_5] = 9;
                    _loc_5 = _loc_5 + 1;
                }
                totalCoins = 0;
                bonusCoins = 0;
                player.coins = 0;
                player.bcoins = 0;
                map.reset(_loc_4);
                cave.setMapArray(_loc_4);
                return;
            }// end function
            );
            this.connection.addMessageHandler("tele", function (param1:Message) : void
            {
                var _loc_4:int = 0;
                var _loc_5:int = 0;
                var _loc_6:int = 0;
                var _loc_7:Player = null;
                var _loc_2:* = param1.getBoolean(0);
                var _loc_3:int = 1;
                while (_loc_3 < param1.length)
                {
                    
                    _loc_4 = param1.getInt(_loc_3);
                    _loc_5 = param1.getInt((_loc_3 + 1));
                    _loc_6 = param1.getInt(_loc_3 + 2);
                    _loc_7 = players[_loc_4];
                    if (_loc_7 != null)
                    {
                        _loc_7.x = _loc_5;
                        _loc_7.y = _loc_6;
                        _loc_7.speedX = 0;
                        _loc_7.speedY = 0;
                        _loc_7.modifierX = 0;
                        _loc_7.modifierY = 0;
                        if (_loc_2)
                        {
                            _loc_7.resetCoins();
                        }
                    }
                    if (_loc_4 == myid)
                    {
                        player.x = _loc_5;
                        player.y = _loc_6;
                        player.speedX = 0;
                        player.speedY = 0;
                        player.modifierX = 0;
                        player.modifierY = 0;
                        this.x = -_loc_6;
                        this.y = -_loc_6;
                        if (_loc_2)
                        {
                            player.resetCoins();
                            cave.resetCoins();
                        }
                    }
                    _loc_3 = _loc_3 + 1;
                }
                return;
            }// end function
            );
            this.connection.send("init2");
            return;
        }// end function

        public function hideRed() : void
        {
            this.cave.hideRed = false;
            if (this.cave.overlaps(this.player))
            {
                this.cave.hideRed = true;
                this.queue.push(this.hideRed);
            }
            return;
        }// end function

        public function hideGreen() : void
        {
            this.cave.hideGreen = false;
            if (this.cave.overlaps(this.player))
            {
                this.cave.hideGreen = true;
                this.queue.push(this.hideGreen);
            }
            return;
        }// end function

        public function hideBlue() : void
        {
            this.cave.hideBlue = false;
            if (this.cave.overlaps(this.player))
            {
                this.cave.hideBlue = true;
                this.queue.push(this.hideBlue);
            }
            return;
        }// end function

        public function showRed() : void
        {
            this.cave.hideRed = true;
            if (this.cave.overlaps(this.player))
            {
                this.cave.hideRed = false;
                this.queue.push(this.showRed);
            }
            return;
        }// end function

        public function showGreen() : void
        {
            this.cave.hideGreen = true;
            if (this.cave.overlaps(this.player))
            {
                this.cave.hideGreen = false;
                this.queue.push(this.showGreen);
            }
            return;
        }// end function

        public function showBlue() : void
        {
            this.cave.hideBlue = true;
            if (this.cave.overlaps(this.player))
            {
                this.cave.hideBlue = false;
                this.queue.push(this.showBlue);
            }
            return;
        }// end function

        public function setTile(param1:int, param2:int, param3:int, param4:Object) : void
        {
            var xo:* = param1;
            var yo:* = param2;
            var value:* = param3;
            var properties:* = param4;
            var old:* = this.cave.getTile(xo, yo);
            if (old == value)
            {
            }
            if (old != 43)
            {
                return;
            }
            var ot:* = this.totalCoins;
            var pc:* = this.player.coins;
            this.cave.setTileComplex(xo, yo, value, properties);
            if (old != 100)
            {
            }
            var oldIsCoin:* = old == 110;
            if (value != 100)
            {
            }
            var newIsCoin:* = value == 110;
            if (newIsCoin)
            {
                if (!oldIsCoin)
                {
                    var _loc_6:PlayState = this;
                    var _loc_7:int = this.totalCoins + 1;
                    _loc_6.totalCoins = _loc_7;
                }
                else
                {
                    var _loc_60:Player = this.player;
                    var _loc_70:int = this.player.coins - 1;
                    _loc_60.coins = _loc_7;
                }
            }
            else if (oldIsCoin)
            {
                if (old == 110)
                {
                    var _loc_65:Player = this.player;
                    var _loc_75:int= this.player.coins - 1;
                    _loc_65.coins = _loc_7;
                }
                var _loc_6422:PlayState = this;
                var _loc_7422:int = this.totalCoins - 1;
                _loc_6422.totalCoins = _loc_7422;
            }
            if (old != 101)
            {
            }
            var oldIsBlueCoin:* = old == 111;
            if (value != 101)
            {
            }
            var newIsBlueCoin:* = value == 111;
            if (newIsBlueCoin)
            {
                if (!oldIsBlueCoin)
                {
                    var _loc_673:PlayState = this;
                    var _loc_773:int = this.bonusCoins + 1;
                    _loc_673.bonusCoins = _loc_773;
                }
                else
                {
                    var _loc_62:Player = this.player;
                    var _loc_72:int = this.player.bcoins - 1;
                    _loc_62.bcoins = _loc_72;
                }
            }
            else if (oldIsBlueCoin)
            {
                if (old == 111)
                {
                    var _loc_634:Player = this.player;
                    var _loc_734:int = this.player.bcoins - 1;
                    _loc_634.bcoins = _loc_734;
                }
                var _loc_662:PlayState = this;
                var _loc_762:int = this.bonusCoins - 1;
                _loc_662.bonusCoins = _loc_762;
            }
            if (this.cave.overlaps(this.player))
            {
                this.totalCoins = ot;
                this.player.coins = pc;
                this.cave.setTileComplex(xo, yo, old, null);
                this.queue.push(function () : void
            {
                setTile(xo, yo, value, properties);
                return;
            }// end function
            );
            }
            return;
        }// end function

        override public function enterFrame() : void
        {
            var _loc_2:Player = null;
            var _loc_3:String = null;
            super.enterFrame();
            this.cointext.text = this.player.coins + "/" + this.totalCoins;
            this.bcointext.text = this.player.bcoins + "/" + this.bonusCoins;
            var _loc_1:* = this.queue.length;
            while (_loc_1--)
            {
                
                this.queue.shift()();
            }
            for each (_loc_2 in this.players)
            {
                
                if (_loc_2.frame != 12)
                {
                    this.map.showPlayer(_loc_2, 4294967295);
                    continue;
                }
                this.map.showPlayer(_loc_2, 1157627903);
            }
            if (this.player.frame != 12)
            {
                this.map.showPlayer(this.player, 4278255360);
            }
            else
            {
                this.map.showPlayer(this.player, 1140915968);
            }
            for (_loc_3 in this.players)
            {
                
                _loc_2 = this.players[_loc_3] as Player;
                _loc_2.enterChat();
            }
            this.player.enterChat();
            return;
        }// end function

        override public function tick() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Boolean = false;
            if (Bl.isKeyJustPressed(71))
            {
                Bl.isKeyJustPressed(71);
            }
            if (Bl.data.canEdit)
            {
                this.connection.send("god", !this.player.isgod);
            }
            if (Bl.isKeyJustPressed(80))
            {
                Bl.isKeyJustPressed(80);
            }
            if (Bl.data.isModerator == true)
            {
                this.connection.send("mod");
            }
            if (Bl.isKeyJustPressed(75))
            {
                Bl.isKeyJustPressed(75);
            }
            if (Bl.data.isModerator == true)
            {
            }
            if (this.player.ismod)
            {
                this.connection.send("kill");
            }
            if (!Bl.isMouseJustPressed)
            {
                if (Bl.data.isLockedRoom)
                {
                }
            }
            if (Bl.isMouseDown)
            {
                if (Bl.mouseX <= 640)
                {
                }
                if (Bl.mouseX >= 0)
                {
                }
                if (Bl.mouseY <= 470)
                {
                }
                if (Bl.mouseY >= 0)
                {
                    _loc_1 = (Bl.mouseX - this.x) / 16 >> 0;
                    _loc_2 = (Bl.mouseY - this.y) / 16 >> 0;
                    if (Bl.data.brick == 100)
                    {
                    }
                    if (this.cave.getTile(_loc_1, _loc_2) == 110)
                    {
                        this.setTile(_loc_1, _loc_2, 100, null);
                    }
                    if (Bl.data.brick == 101)
                    {
                    }
                    if (this.cave.getTile(_loc_1, _loc_2) == 111)
                    {
                        this.setTile(_loc_1, _loc_2, 101, null);
                    }
                    if (this.connection.connected)
                    {
                    }
                    if (!this.isSame(_loc_1, _loc_2))
                    {
                    }
                    if (Bl.data.brick >= 0)
                    {
                        _loc_3 = true;
                        if (_loc_1 == this.pastX)
                        {
                        }
                        if (_loc_2 == this.pastY)
                        {
                            if (new Date().getTime() - this.pastT < 500)
                            {
                                _loc_3 = false;
                            }
                        }
                        if (_loc_3)
                        {
                            this.pastX = _loc_1;
                            this.pastY = _loc_2;
                            this.pastT = new Date().getTime();
                            switch(Bl.data.brick)
                            {
                                case 43:
                                {
                                    this.connection.send(Bl.data.m, _loc_1, _loc_2, Bl.data.brick, Bl.data.coincount);
                                    break;
                                }
                                default:
                                {
                                    this.connection.send(Bl.data.m, _loc_1, _loc_2, Bl.data.brick);
                                    break;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            super.tick();
            return;
        }// end function

        private function isSame(param1:int, param2:int) : Boolean
        {
            if (Bl.data.brick == this.cave.getTile(param1, param2))
            {
                switch(Bl.data.brick)
                {
                    case 43:
                    {
                        if (this.cave.getCoinValue(param1, param2) != Bl.data.coincount)
                        {
                            return false;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return true;
            }
            return false;
        }// end function

        override public function draw(param1:BitmapData, param2:Number, param3:Number) : void
        {
            var _loc_5:String = null;
            var _loc_6:Player = null;
            super.draw(param1, param2, param3);
            if (this.totalCoins > 0)
            {
                this.cointextcontainer.draw(param1, 0, 0);
            }
            if (this.bonusCoins > 0)
            {
                this.bcointextcontainer.draw(param1, 0, 15);
            }
            if (Math.abs(this.player.speedX) + Math.abs(this.player.speedY) >= 0.5)
            {
            }
            var _loc_4:* = Bl.data.chatisvisible;
            if (!_loc_4)
            {
                this.chatTime = new Date().getTime();
            }
            else if (new Date().getTime() - this.chatTime < 1500)
            {
                if (true)
                {
                }
                _loc_4 = Bl.data.chatisvisible;
            }
            for (_loc_5 in this.players)
            {
                
                _loc_6 = this.players[_loc_5] as Player;
                _loc_6.drawChat(param1, param2 + _x, param3 + _y, _loc_4);
            }
            this.player.drawChat(param1, param2 + _x, param3 + _y, _loc_4);
            Chat.drawAll();
            if (Bl.data.showMap)
            {
                this.map.draw(param1, param2, param3);
            }
            else
            {
                this.map.clear();
            }
            return;
        }// end function

    }
}
