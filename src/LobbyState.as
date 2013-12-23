package 
{
    import LobbyState.*;
    
    import blitter.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
    
    import playerio.*;
    
    import ui.*;

    public class LobbyState extends BlState
    {
        protected var world:Class;
        protected var levelstate:Class;
        protected var twitter:Class;
        protected var image:BitmapData;
        protected var levels:Object;
        protected var callback:Function;
        protected var createCallback:Function;
        protected var subtext:BlText;
        protected var roomlist:RoomList;
        protected var roomlist2:RoomList;
        protected var betalist:RoomList;
        protected var createroom:CreateRoom;
        protected var filter:WorldsFilter;
        protected var fbtextfield:TextField;
        protected var tw:Sprite;
        protected var probtn:gopro;
        protected var shopbar:ShopBar;
        protected var myworlds:MyWorlds;

        public function LobbyState(param1:Array, param2:Function, param3:Function, param4:Function, param5:Boolean, param6:EverybodyEditsBeta, param7:Function)
        {
			super();
            var tb:BlText;
            var r:RoomInfo;
            var t3:BlText;
            var f:TextFormat;
            var f2:TextFormat;
            var rooms:* = param1;
            var callback:* = param2;
            var createCallback:* = param3;
            var myroomsCallback:* = param4;
            var iseecom:* = param5;
            var base:* = param6;
            var handleJoinSaved:* = param7;
            this.world = LobbyState_world;
            this.levelstate = LobbyState_levelstate;
            this.twitter = LobbyState_twitter;
            this.image = new this.world();
            this.levels = {};
            this.subtext = new BlText(11, 300, 11184810);
            this.tw = new Sprite();
            this.probtn = new gopro();
            this.shopbar = new ShopBar();
            this.callback = callback;
            this.createCallback = createCallback;
            var t:* = new BlText(30, 400, 14179354);
            t.text = "Everybody Edits";
            t.x = 10;
            t.y = 5 + (!base.isguest ? (30) : (0));
            add(t);
            if (Bl.data.hasbeta)
            {
                tb = new BlText(11, 400, 16758528);
                tb.text = Bl.data.isbeta ? ("Beta") : ("");
                tb.x = 286;
                tb.y = 3 + (!base.isguest ? (30) : (0));
                add(tb);
            }
            this.subtext.x = 10;
            this.subtext.y = 42 + (!base.isguest ? (30) : (0));
            add(this.subtext);
            var betaonline:int;
            var openonline:int;
            var protectedonline:int;
            var ownlist:Array = new Array();
            var ownlist2:Array = new Array();
            var betaonly:Array = new Array();
            var ra:int;
            while (ra < rooms.length)
            {
                
                r = rooms[ra] as RoomInfo;
                if (r.data.name == Chat.filter(r.data.name))
                {
                    if (r.data.owned == "true")
                    {
                    }
                    if (!r.data.name)
                    {
                    }
                    else
                    {
                        if (r.id != "ChrisWorld")
                        {
                        }
                        if (r.data.name.replace(/benjaminsen|benjaminson""benjaminsen|benjaminson/gi, "") != r.data.name)
                        {
                        }
                        else if (r.data.beta)
                        {
                            betaonly.push(r);
                            betaonline = betaonline + r.onlineUsers;
                        }
                        else if (r.data.needskey)
                        {
                            ownlist.push(r);
                            protectedonline = protectedonline + r.onlineUsers;
                        }
                        else
                        {
                            ownlist2.push(r);
                            openonline = openonline + r.onlineUsers;
                        }
                    }
                }
                ra = (ra + 1);
            }
            var t2:* = new BlText(14, 400, 16777215);
            t2.text = "Protected Worlds - " + protectedonline + " Online";
            t2.x = 420 - 69 - 20 - 5;
            t2.y = 68 + (Bl.data.isbeta ? (189) : (!base.isguest ? (30) : (0)));
            add(t2);
            var t22:* = new BlText(14, 400, 16777215);
            t22.text = "Open Worlds - " + openonline + " Online";
            t22.x = 19 - 5;
            t22.y = 68 + (!base.isguest ? (30) : (0));
            add(t22);
            var t23:* = new BlText(14, 400, 16777215);
            t23.text = "My Saved Worlds";
            t23.x = 19 - 5;
            t23.y = 150 + 90;
            add(t23);
            if (Bl.data.isbeta)
            {
                t3 = new BlText(14, 400, 16758528);
                t3.text = "Beta only worlds - " + betaonline + " Online";
                t3.x = 420 - 69 - 20 - 5;
                t3.y = 68 + 30;
                add(t3);
            }
            if (Bl.data.isbeta)
            {
                this.betalist = new RoomList(betaonly, 125, this.joinRoom);
                this.betalist.x = 420 - 68 - 25;
                this.betalist.y = 92 + 30;
                Bl.stage.addChild(this.betalist);
            }
            this.roomlist2 = new RoomList(ownlist2, base.isguest ? (270) : (110), this.joinRoom);
            this.roomlist2.x = 15;
            this.roomlist2.y = 92 + (!base.isguest ? (30) : (0));
            Bl.stage.addChild(this.roomlist2);
            this.roomlist = new RoomList(ownlist, 200 + (Bl.data.isbeta ? (-20) : (!base.isguest ? (139) : (169))), this.joinRoom);
            this.roomlist.x = 420 - 68 - 25;
            this.roomlist.y = 92 + (Bl.data.isbeta ? (189) : (!base.isguest ? (30) : (0)));
            Bl.stage.addChild(this.roomlist);
            if (!base.isguest)
            {
                this.myworlds = new MyWorlds(base.client, Bl.data.hasbeta, Bl.data.isbeta, function (param1:String) : void
            {
                var _loc_2:* = undefined;
                reset();
                if (param1 == "savedworld")
                {
                    myroomsCallback();
                }
                else if (param1 == "savedbetaworld")
                {
                    myroomsCallback(true);
                }
                else
                {
                    _loc_2 = param1.split("x");
                    handleJoinSaved(_loc_2[0], _loc_2[1]);
                }
                return;
            }// end function
            );
                Bl.stage.addChild(this.myworlds);
                this.myworlds.x = 15;
                this.myworlds.y = 150 + 92 + 20;
            }
            this.createroom = new CreateRoom(this.createRoom, function (param1:Boolean) : void
            {
                reset();
                myroomsCallback(param1);
                return;
            }// end function
            , false, false);
            this.createroom.x = 15;
            this.createroom.y = 334 + 44;
            Bl.stage.addChild(this.createroom);
            this.refresh(rooms);
            this.filter = new WorldsFilter(this.applyFilter);
            this.filter.x = 420 - 68 - 15;
            this.filter.y = 10 + (!base.isguest ? (30) : (0));
            Bl.stage.addChild(this.filter);
            this.tw.addChild(DisplayObject(new Bitmap(new this.twitter())));
            this.tw.x = 285;
            this.tw.y = 55 + (!base.isguest ? (30) : (0));
            this.tw.buttonMode = true;
            this.tw.addEventListener(MouseEvent.CLICK, function (event:Event) : void
            {
                var e:* = event;
                var url:String;
                var request:* = new URLRequest(url);
                try
                {
                    navigateToURL(request, "_new");
                }
                catch (e:Error)
                {
                    trace("Error occurred!");
                }
                return;
            }// end function
            );
            Bl.stage.addChild(this.tw);
            if (!base.isguest)
            {
                var refreshTopBar:* = function () : void
            {
                shopbar.gems.text = "Gems: " + Shop.gems;
                shopbar.energy.text = "Energy: " + Shop.energy + "/" + Shop.totalEnergy;
                shopbar.timetonext.text = "More in: " + Shop.prettyTimeToNext;
                shopbar.timetonext.visible = Shop.energy != Shop.totalEnergy;
                shopbar.energy.y = shopbar.timetonext.visible ? (3) : (shopbar.gems.y);
                return;
            }// end function
            ;
                Bl.stage.addChild(this.shopbar);
                this.shopbar.addEventListener(Event.ENTER_FRAME, function () : void
            {
                if (shopbar.parent)
                {
                    refreshTopBar();
                }
                else
                {
                    shopbar.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                }
                return;
            }// end function
            );
                this.refreshTopBar();
                this.shopbar.shop.visible = false;
                this.shopbar.shop.closebtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                shopbar.shop.visible = false;
                return;
            }// end function
            );
                this.shopbar.shopbtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                shopbar.shop.visible = !shopbar.shop.visible;
                return;
            }// end function
            );
                this.shopbar.gemsbtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                Shop.getMoreGems();
                return;
            }// end function
            );
                Shop.renderShopItems(this.shopbar.shop.content);
            }
            if (iseecom)
            {
                if (base.userid)
                {
                    this.fbtextfield = new TextField();
                    this.fbtextfield.width = 200;
                    this.fbtextfield.x = 640 - 200;
                    this.fbtextfield.y = 500 - 20;
                    f = new TextFormat();
                    f.align = TextFormatAlign.RIGHT;
                    f.color = 6710886;
                    this.fbtextfield.defaultTextFormat = f;
                    this.fbtextfield.text = base.userid;
                    Bl.stage.addChild(this.fbtextfield);
                }
            }
            else
            {
                this.fbtextfield = new TextField();
                this.fbtextfield.width = 200;
                this.fbtextfield.x = 640 - 200;
                this.fbtextfield.y = 500 - 20;
                f2 = new TextFormat();
                f2.align = TextFormatAlign.RIGHT;
                f2.color = 2236962;
                this.fbtextfield.defaultTextFormat = f2;
                if (!LoaderInfo(Bl.stage.root.loaderInfo).parameters.nonoba$referer)
                {
                }
                this.fbtextfield.text = ">" + "" + "<";
                Bl.stage.addChild(this.fbtextfield);
            }
            return;
        }// end function

        private function applyFilter(param1:String) : void
        {
            if (this.roomlist)
            {
                this.roomlist.render(param1);
            }
            if (this.roomlist2)
            {
                this.roomlist2.render(param1);
            }
            if (this.betalist)
            {
                this.betalist.render(param1);
            }
            return;
        }// end function

        public function refresh(param1:Array) : void
        {
            var _loc_3:RoomInfo = null;
            var _loc_2:Number = 0;
            for each (_loc_3 in param1)
            {
                
                _loc_2 = _loc_2 + _loc_3.onlineUsers;
            }
            this.subtext.text = _loc_2 + " Online - Click a world to join it!";
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:Number, param3:Number) : void
        {
            param1.copyPixels(this.image, this.image.rect, new Point(0, 0));
            super.draw(param1, param2, param3);
            return;
        }// end function

        private function joinRoom(param1:String, param2:String = "") : void
        {
            Bl.data.roomname = param2;
            this.reset();
            this.callback(param1);
            return;
        }// end function

        private function createRoom(param1:String, param2:String = "", param3:Boolean = false) : void
        {
            this.reset();
            this.createCallback(param1, param2);
            return;
        }// end function

        public function reset() : void
        {
            if (this.fbtextfield)
            {
                Bl.stage.removeChild(this.fbtextfield);
            }
            if (this.roomlist)
            {
            }
            if (this.roomlist.parent)
            {
                Bl.stage.removeChild(this.roomlist);
            }
            if (this.roomlist2)
            {
            }
            if (this.roomlist2.parent)
            {
                Bl.stage.removeChild(this.roomlist2);
            }
            Bl.stage.removeChild(this.createroom);
            Bl.stage.removeChild(this.filter);
            Bl.stage.removeChild(this.tw);
            if (this.myworlds)
            {
            if (this.myworlds.parent)
            {
                this.myworlds.parent.removeChild(this.myworlds);
            }
			}
            if (this.betalist)
            {
            if (this.betalist.parent)
            {
                Bl.stage.removeChild(this.betalist);
            }
			}
            if (this.probtn.parent)
            {
                Bl.stage.removeChild(this.probtn);
            }
            if (this.shopbar)
            {
            if (this.shopbar.parent)
            {
                this.shopbar.parent.removeChild(this.shopbar);
            }
			}
            return;
        }// end function

    }
}
