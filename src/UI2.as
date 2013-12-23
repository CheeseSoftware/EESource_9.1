package 
{
    import Facebook.*;
    import UI2.*;
    import blitter.*;
    import chat.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import playerio.*;
    import ui.*;
    import ui2.*;

    public class UI2 extends Sprite
    {
        private var lobby:ui2lobbybtn;
        private var godmode:ui2godmodebtn;
        private var toggleminimap:ui2toggleminimapbtn;
        private var soundandfullscreen:ui2soundandfullscreenbtn;
        private var mylevel:ui2mylevelbtn;
        private var mylevelhidden:ui2mylevelemptybtn;
        private var you:ui2youbtn;
        private var share:ui2sharebtn;
        private var enterkey:ui2entereditkeybox;
        private var bmd:BitmapData;
        private var bmd2:BitmapData;
        private var smilies:ui2smileyselector;
        private var coinsbmd:BitmapData;
        private var smiliesbmd:BitmapData;
        private var chatbtn:ui2chatbtn;
        private var chatinput:ui2chatinput;
        private var levelbricks:BrickContainer;
        private var bselector:BrickSelector;
        private var base:EverybodyEditsBeta;
        private var connection:Connection;
        private var above:Sprite;
        private var roomid:String;
        private var defaults:Array;
        private var coinproperties:CoinProperties;
        private var usedx:int = 0;
        private var timerArray:Array;
        private var textArray:Array;
        private var lastMessageTime:Number;
        private var justVisible:Boolean = false;

        public function UI2(param1:BitmapData, param2:BitmapData, param3:BitmapData, param4:Array, param5:EverybodyEditsBeta, param6:Connection, param7:int, param8:Boolean, param9:String, param10:SideChat)
        {
            var bricksbmd:* = param1;
            var bricksbmd2:* = param2;
            var smiliesbmd:* = param3;
            var defaults:* = param4;
            var base:* = param5;
            var connection:* = param6;
            var myid:* = param7;
            var canEdit:* = param8;
            var roomid:* = param9;
            var sidechat:* = param10;
            this.lobby = new ui2lobbybtn();
            this.godmode = new ui2godmodebtn();
            this.toggleminimap = new ui2toggleminimapbtn();
            this.soundandfullscreen = new ui2soundandfullscreenbtn();
            this.mylevel = new ui2mylevelbtn();
            this.mylevelhidden = new ui2mylevelemptybtn();
            this.share = new ui2sharebtn();
            this.enterkey = new ui2entereditkeybox();
            this.smilies = new ui2smileyselector();
            this.coinsbmd = new ui2coins();
            this.chatbtn = new ui2chatbtn();
            this.chatinput = new ui2chatinput();
            this.bselector = new BrickSelector();
            this.above = new Sprite();
            this.timerArray = [5000, 5000, 5000, 5000, 5000];
            this.textArray = ["", "", "", "", "", "", "", "", "", ""];
            this.lastMessageTime = new Date().getTime();
            Bl.data.chatisvisible = false;
            this.defaults = defaults;
            this.roomid = roomid;
            this.bmd = bricksbmd;
            this.bmd2 = bricksbmd2;
            this.smiliesbmd = smiliesbmd;
            this.base = base;
            this.connection = connection;
            addChild(new ui2background());
            this.you = new ui2youbtn(smiliesbmd);
            this.above.addChild(this.bselector);
            this.above.addChild(this.smilies);
            trace(defaults);
            var a:int;
            while (a < defaults.length)
            {
                
                switch(defaults[a][0])
                {
                    case 0:
                    {
                        defaults[a][0] = this.bmd;
                        break;
                    }
                    case 1:
                    {
                        defaults[a][0] = this.coinsbmd;
                        break;
                    }
                    case 2:
                    {
                        defaults[a][0] = this.bmd2;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                a = (a + 1);
            }
            this.levelbricks = new BrickContainer(this.bmd, defaults, this);
            this.configureInterface(canEdit);
            this.toggleMinimap(Bl.data.showMap);
            this.toggleSound(!Bl.data.playSounds);
            this.smilies.x = this.you.x - 50 + this.you.width / 2;
            this.bselector.x = 640 - this.bselector.width >> 1;
            this.bselector.visible = false;
            addChild(this.chatinput);
            this.chatinput.y = -60;
            this.chatinput.x = 65;
            this.chatinput.visible = false;
            this.chatinput.text = new TabTextField();
            this.chatinput.addChild(this.chatinput.text);
            this.chatinput.text.x = 37;
            this.chatinput.text.y = 7;
            this.chatinput.text.width = 445;
            if (sidechat != null)
            {
                this.chatinput.text.SetWordFunction(sidechat.getUsers);
            }
            this.chatinput.text.field.addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                if (event.keyCode == 27)
                {
                    hideAll();
                }
                if (event.keyCode == 13)
                {
                    sendChat();
                }
                return;
            }// end function
            );
            this.chatinput.say.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                sendChat();
                return;
            }// end function
            );
            this.chatinput.text.field.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            this.bselector.addPackage(new BrickPackage("basic", this.bmd, [9, 10, 11, 12, 13, 14, 15], this));
            if (Bl.data.hasbeta)
            {
                this.bselector.addPackage(new BrickPackage("beta", this.bmd, [37, 38, 39, 40, 41, 42], this));
            }
            this.bselector.addPackage(new BrickPackage("brick", this.bmd, [16, 17, 18, 19, 20, 21], this));
            this.bselector.addPackage(new BrickPackage("metal", this.bmd, [29, 30, 31], this));
            this.bselector.addPackage(new BrickPackage("grass", this.bmd, [34, 35, 36], this));
            this.bselector.addPackage(new BrickPackage("special", this.bmd, [22, 32, 33, 44], this));
            this.bselector.addPackage(new BrickPackage("keys", this.bmd, [6, 7, 8], this));
            if (Bl.data.owner)
            {
                this.bselector.addPackage(new BrickPackage("doors", this.bmd, [23, 24, 25, 43], this));
            }
            else
            {
                this.bselector.addPackage(new BrickPackage("doors", this.bmd, [23, 24, 25], this));
            }
            this.bselector.addPackage(new BrickPackage("gates", this.bmd, [26, 27, 28], this));
            this.bselector.addPackage(new BrickPackage("gravity", this.bmd, [0, 1, 2, 3, 4], this));
            this.bselector.addPackage(new BrickPackage("coins", this.coinsbmd, [0, 1], this));
            this.bselector.addPackage(new BrickPackage("crown", this.bmd, [5], this));
            if (Bl.data.owner)
            {
                this.bselector.addPackage(new BrickPackage("tools", this.bmd2, [127], this));
            }
            this.bselector.addPackage(new BrickPackage("Christmas 2010", this.bmd2, [121, 122, 123, 124, 125, 126], this));
            this.bselector.addPackage(new BrickPackage("New Year 2010", this.bmd2, [116, 117, 118, 119, 120], this));
            this.bselector.addPackage(new BrickPackage("Factory Package", this.bmd, [45, 46, 47, 48, 49], this));
            var smc:* = Bl.data.hasbeta ? (12) : (6);
            a;
            while (a < smc)
            {
                
                this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, a, this), a);
                a = (a + 1);
            }
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 18, this), 18);
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 12, this), 12);
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 13, this), 13);
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 14, this), 14);
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 15, this), 15);
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 16, this), 16);
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 17, this), 17);
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 19, this), 19);
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 20, this), 20);
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 21, this), 21);
            this.smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 22, this), 22);
            this.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                if (stage)
                {
                    stage.focus = Bl.data.base;
                }
                return;
            }// end function
            );
            this.lobby.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                base.ShowLobby();
                return;
            }// end function
            );
            this.godmode.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                connection.send("god", godmode.currentFrame == 1);
                return;
            }// end function
            );
            connection.addMessageHandler("god", function (param1:Message, param2:int, param3:Boolean) : void
            {
                if (param2 == myid)
                {
                    toggleGodMode(param3);
                }
                return;
            }// end function
            );
            connection.addMessageHandler("givewizard", function (param1:Message) : void
            {
                smilies.addSmiley(new ui2smileyinstance(smiliesbmd, 22, this), 22);
                setSelectedSmiley(22);
                return;
            }// end function
            );
            this.chatbtn.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                toggleChat(chatbtn.currentFrame == 1);
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            this.toggleminimap.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleMinimap(toggleminimap.currentFrame == 1);
                if (stage)
                {
                    stage.focus = Bl.data.base;
                }
                return;
            }// end function
            );
            this.soundandfullscreen.sound.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleSound(soundandfullscreen.currentFrame == 1);
                return;
            }// end function
            );
            this.soundandfullscreen.fullscreen.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                try
                {
                    if (Bl.stage.displayState == StageDisplayState.NORMAL)
                    {
                        Bl.stage.displayState = StageDisplayState.FULL_SCREEN;
                        Bl.stage.scaleMode = StageScaleMode.SHOW_ALL;
                    }
                    else
                    {
                        Bl.stage.scaleMode = StageScaleMode.NO_SCALE;
                        Bl.stage.displayState = StageDisplayState.NORMAL;
                    }
                }
                catch (e:Error)
                {
                }
                return;
            }// end function
            );
            this.mylevel.save.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(false);
                mylevel.gotoAndStop(3);
                mylevel.togglemodify.visible = false;
                connection.send("save");
                return;
            }// end function
            );
            this.mylevel.togglemodify.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(mylevel.currentFrame == 1);
                return;
            }// end function
            );
            connection.addMessageHandler("saved", function () : void
            {
                setTimeout(function () : void
                {
                    toggleLevel(false);
                    mylevel.togglemodify.visible = true;
                    return;
                }// end function
                , 2000);
                return;
            }// end function
            );
            this.mylevel.editname.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(false);
                try
                {
                    Bl.stage.displayState = StageDisplayState.NORMAL;
                    Bl.stage.scaleMode = StageScaleMode.NO_SCALE;
                }
                catch (e:Error)
                {
                }
                Bl.stage.addChild(new Prompt("Type in new level name", Bl.data.roomname, function (param1:String) : void
                {
                    connection.send("name", param1);
                    Bl.data.roomname = param1;
                    if (stage)
                    {
                        stage.focus = Bl.data.base;
                    }
                    return;
                }// end function
                ));
                return;
            }// end function
            );
            this.mylevel.editkey.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(false);
                try
                {
                    Bl.stage.displayState = StageDisplayState.NORMAL;
                    Bl.stage.scaleMode = StageScaleMode.NO_SCALE;
                }
                catch (e:Error)
                {
                }
                Bl.stage.addChild(new Prompt("Type in new super secret edit key", "", function (param1:String) : void
                {
                    connection.send("key", param1);
                    if (stage)
                    {
                        stage.focus = Bl.data.base;
                    }
                    return;
                }// end function
                ));
                return;
            }// end function
            );
            this.mylevel.clearlevel.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleLevel(false);
                Bl.stage.addChild(new Prompt("Type CLEAR and press save to clear your level!", "", function (param1:String) : void
                {
                    if (param1 == "CLEAR")
                    {
                        connection.send("clear");
                    }
                    if (stage)
                    {
                        stage.focus = Bl.data.base;
                    }
                    return;
                }// end function
                ));
                return;
            }// end function
            );
            this.you.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                smilies.x = you.x - 50 + you.width / 2;
                toggleSmiley(!smilies.visible);
                return;
            }// end function
            );
            this.share.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                if (Bl.data.isfacebook)
                {
                    FB.ui({method:"stream.publish", message:"I found a great Everybody Edits level!", attachment:{name:"Play " + (Bl.data.roomname ? (Bl.data.roomname + " in ") : ("")) + "Everybody Edits", href:"http://apps.facebook.com/everedits/games/" + roomid, caption:"{*actor*} is having a blast playing " + (Bl.data.roomname ? (Bl.data.roomname + " in ") : ("")) + "Everybody Edits", description:"Why not try the level now?", media:[{type:"image", src:"http://r.playerio.com/r/everybody-edits-su9rn58o40itdbnw69plyw/Everybody Edits/img/ee100x100.png", href:"http://apps.facebook.com/everedits/games/" + roomid}]}}, function (param1) : void
                {
                    return;
                }// end function
                );
                }
                else
                {
                    Bl.stage.addChild(new Share("Direct url to this level!", "http://" + (Bl.data.isbeta ? ("beta.") : ("")) + "everybodyedits.com/games/" + roomid.split(" ").join("-")));
                }
                return;
            }// end function
            );
            this.levelbricks.more.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                toggleMore(levelbricks.more.currentFrame == 1);
                return;
            }// end function
            );
            this.enterkey.key.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.stopImmediatePropagation();
                event.stopPropagation();
                event.preventDefault();
                return;
            }// end function
            );
            this.enterkey.key.addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent) : void
            {
                event.stopImmediatePropagation();
                event.stopPropagation();
                event.preventDefault();
                return;
            }// end function
            );
            this.enterkey.send.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                connection.send("access", enterkey.key.text);
                return;
            }// end function
            );
            connection.addMessageHandler("access", function (param1:Message) : void
            {
                Bl.data.canEdit = true;
                configureInterface(true);
                return;
            }// end function
            );
            connection.addMessageHandler("lostaccess", function (param1:Message) : void
            {
                if (!Bl.data.owner)
                {
                    toggleMore(false);
                    toggleGodMode(false);
                    Bl.data.canEdit = false;
                    configureInterface(false);
                }
                return;
            }// end function
            );
            this.setSelected(0, this.bmd);
            this.setSelectedSmiley(0);
            this.toggleLevel(false);
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            addEventListener(Event.REMOVED_FROM_STAGE, this.handleDetatch);
            return;
        }// end function

        public function toggleLevel(param1:Boolean) : void
        {
            if (param1)
            {
                this.hideAll();
                this.mylevel.gotoAndStop(2);
            }
            else
            {
                this.mylevel.gotoAndStop(1);
            }
            this.mylevel.save.visible = param1;
            this.mylevel.editkey.visible = param1;
            this.mylevel.editname.visible = param1;
            this.mylevel.clearlevel.visible = param1;
            return;
        }// end function

        public function toggleSmiley(param1:Boolean) : void
        {
            if (param1)
            {
                this.hideAll();
            }
            this.smilies.visible = param1;
            return;
        }// end function

        public function dragIt(param1:int, param2:BitmapData) : void
        {
            this.levelbricks.dragIt(param1, param2);
            return;
        }// end function

        public function setDefault(param1:int, param2:int, param3:BitmapData) : void
        {
            var _loc_4:* = new Dictionary();
            _loc_4[this.bmd] = 0;
            _loc_4[this.coinsbmd] = 1;
            _loc_4[this.bmd2] = 2;
            this.defaults[param1] = [_loc_4[param3], param2];
            this.levelbricks.setDefault(param1, param2, param3);
            return;
        }// end function

        public function toggleGodMode(param1:Boolean) : void
        {
            this.godmode.gotoAndStop(param1 ? (2) : (1));
            return;
        }// end function

        public function toggleMinimap(param1:Boolean) : void
        {
            this.toggleminimap.gotoAndStop(param1 ? (2) : (1));
            Bl.data.showMap = param1;
            return;
        }// end function

        public function toggleSound(param1:Boolean) : void
        {
            Bl.data.playSounds = !param1;
            this.soundandfullscreen.gotoAndStop(param1 ? (2) : (1));
            return;
        }// end function

        public function setSelected(param1:int, param2:BitmapData) : void
        {
            this.hideCoinsProperties();
            if (this.bselector.visible)
            {
                switch(param1)
                {
                    case 43:
                    {
                        this.showCoinsProperties(this.bselector.getPosition(param1));
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (param2 is ui2coins)
            {
                Bl.data.brick = param1 + 100;
            }
            else if (param2 == this.bmd2)
            {
                Bl.data.brick = param1 + 128;
            }
            else
            {
                Bl.data.brick = param1;
            }
            this.levelbricks.setSelected(param1, param2);
            this.bselector.setSelected(param1, param2);
            return;
        }// end function

        public function showCoinsProperties(param1:Point) : void
        {
            this.hideCoinsProperties();
            if (!param1)
            {
                return;
            }
            this.coinproperties = new CoinProperties();
            this.above.addChild(this.coinproperties);
            this.coinproperties.x = param1.x + this.bselector.x;
            this.coinproperties.y = param1.y + this.bselector.y;
            return;
        }// end function

        public function hideCoinsProperties() : void
        {
            if (this.coinproperties)
            {
            if (this.coinproperties.parent)
            {
                this.coinproperties.parent.removeChild(this.coinproperties);
            }
			}
            this.coinproperties = null;
            return;
        }// end function

        public function setSelectedSmiley(param1:int) : void
        {
            this.connection.send(Bl.data.m + "f", param1);
            this.you.setSelectedSmiley(param1);
            this.smilies.setSelectedSmiley(param1);
            this.toggleSmiley(false);
            return;
        }// end function

        public function toggleMore(param1:Boolean) : void
        {
            if (this.levelbricks.parent == null)
            {
                return;
            }
            if (param1)
            {
                this.hideAll();
            }
            else
            {
                this.hideCoinsProperties();
            }
            this.levelbricks.more.gotoAndStop(param1 ? (2) : (1));
            this.bselector.visible = param1;
            return;
        }// end function

        public function toggleChat(param1:Boolean) : void
        {
            if (param1)
            {
            if (Bl.data.canchat)
            {
                this.hideAll();
                Bl.data.chatisvisible = true;
                this.chatbtn.gotoAndStop(2);
                this.chatinput.visible = true;
                if (stage)
                {
                    stage.focus = this.chatinput.text.field;
					
                }
                this.chatinput.text.field.text = "";
            }
            else
            {
                this.chatbtn.gotoAndStop(1);
                this.chatinput.visible = false;
                Bl.data.chatisvisible = false;
            }
			}
            return;
        }// end function

        public function hideAll() : void
        {
            this.toggleSmiley(false);
            this.toggleLevel(false);
            this.toggleChat(false);
            this.toggleMore(false);
            this.hideCoinsProperties();
            return;
        }// end function

        private function configureInterface(param1:Boolean) : void
        {
            this.usedx = 0;
            if (this.godmode.parent)
            {
                removeChild(this.godmode);
            }
            if (this.you.parent)
            {
                removeChild(this.you);
            }
            if (this.levelbricks.parent)
            {
                removeChild(this.levelbricks);
            }
            if (this.mylevel.parent)
            {
                removeChild(this.mylevel);
            }
            if (this.enterkey.parent)
            {
                removeChild(this.enterkey);
            }
            if (this.mylevelhidden.parent)
            {
                removeChild(this.mylevelhidden);
            }
            this.add(this.lobby);
            this.add(this.share);
            if (param1)
            {
                this.add(this.godmode);
                this.godmode.visible = Bl.data.isLockedRoom;
                this.add(this.you);
                this.add(this.chatbtn);
                this.add(this.levelbricks);
                this.add(this.mylevel);
                this.mylevel.visible = Bl.data.owner;
            }
            else
            {
                this.add(this.you);
                this.add(this.chatbtn);
                this.add(this.enterkey);
            }
            if (!Bl.data.canchat)
            {
                this.chatbtn.visible = false;
            }
            this.add(this.soundandfullscreen);
            this.add(this.toggleminimap);
            addChild(this.above);
            return;
        }// end function

        private function add(param1:InteractiveObject) : void
        {
            param1.y = -29;
            param1.x = this.usedx;
            addChild(param1);
            this.usedx = this.usedx + (param1.width - 1);
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            stage.stageFocusRect = false;
            stage.focus = stage;
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
            return;
        }// end function

        private function handleDetatch(event:Event) : void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
            stage.removeEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
            return;
        }// end function

        private function handleMouseDown(event:MouseEvent) : void
        {
            return;
        }// end function

        private function sendChat() : void
        {
            var _loc_6:int = 0;
            var _loc_1:* = this.chatinput.text.field.text;
            var _loc_2:* = _loc_1.toLocaleLowerCase();
            this.textArray.push(_loc_1);
            this.textArray.shift();
            this.timerArray.push(new Date().getTime() - this.lastMessageTime);
            this.timerArray.shift();
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            while (_loc_4 < this.timerArray.length)
            {
                
                _loc_3 = _loc_3 + this.timerArray[_loc_4];
                _loc_4 = _loc_4 + 1;
            }
            _loc_1 = _loc_1.replace(/([\?\!]{2})[\?\!]+""([\?\!]{2})[\?\!]+/gi, "$1");
            _loc_1 = _loc_1.replace(/\.{4,}""\.{4,}/gi, "...");
            var _loc_5:* = _loc_1.replace(/(:?.+)\1{4,}""(:?.+)\1{4,}/gi, "$1$1$1");
            while (_loc_5 != _loc_1)
            {
                
                _loc_1 = _loc_5;
                _loc_5 = _loc_1.replace(/(:?.+)\1{4,}""(:?.+)\1{4,}/gi, "$1$1$1");
            }
            if (_loc_1.length > 4)
            {
            }
            if (_loc_1.match(/[A-Z]""[A-Z]/g).length > _loc_1.length / 2)
            {
                _loc_1 = _loc_1.toLowerCase();
            }
            this.hideAll();
            if (_loc_1.charAt(0) == "/")
            {
                this.connection.send("say", _loc_1);
            }
            else if (_loc_1.replace(/\s""\s/gi, "").length > 0)
            {
                this.lastMessageTime = new Date().getTime();
                if (_loc_3 < 5000)
                {
                    Bl.data.base.SystemSay("Easy now, you don\'t want the other players mistaking you for a spammer!");
                    return;
                }
                _loc_6 = 0;
                _loc_4 = 0;
                while (_loc_4 < this.textArray.length)
                {
                    
                    if (this.textArray[_loc_4] == _loc_1)
                    {
                        _loc_6 = _loc_6 + 1;
                    }
                    _loc_4 = _loc_4 + 1;
                }
                if (_loc_6 > 3)
                {
                    Bl.data.base.SystemSay("This is the fourth time out of ten you try to say \"" + _loc_1 + "\". Time to try something new?");
                    return;
                }
                this.connection.send("say", _loc_1);
            }
            return;
        }// end function

        private function handleKeyDown(event:KeyboardEvent) : void
        {
            if (event.keyCode == 16)
            {
                Bl.data.chatisvisible = true;
            }
            if (event.keyCode == 9)
            {
                this.toggleMore(true);
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
            }
            if (event.keyCode != 13)
            {
            }
            if (event.keyCode == 84)
            {
                if (this.chatbtn.currentFrame == 1)
                {
                    this.justVisible = true;
                }
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                this.toggleChat(true);
            }
            if (event.keyCode == 77)
            {
                this.toggleMinimap(this.toggleminimap.currentFrame == 1);
            }
            if (event.keyCode == 27)
            {
                this.hideAll();
            }
            return;
        }// end function

        private function handleKeyUp(event:KeyboardEvent) : void
        {
            if (event.keyCode == 16)
            {
                Bl.data.chatisvisible = this.chatbtn.currentFrame != 1;
            }
            if (event.keyCode == 9)
            {
                this.toggleMore(false);
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
            }
            if (this.justVisible)
            {
                this.toggleChat(true);
            }
            this.justVisible = false;
            return;
        }// end function

    }
}
