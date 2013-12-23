package 
{
    import EverybodyEditsBeta.*;
    
    import Facebook.*;
    
    import SWFStats.*;
    
    import blitter.*;
    
    import chat.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    
    import playerio.*;
    
    import ui2.*;

    public class EverybodyEditsBeta extends BlGame
    {
        protected var Rocks:Class;
        protected var Rocks2:Class;
        public var client:Client;
        protected var ui:UI2;
        protected var iseecom:Boolean;
        protected var multiplayerversion:String = "EE42";
        protected var betagameversion:String = "EE42";
        protected var serviceVersion:String = "Lobby12";
        protected var gameid:String = "eeo-ruiegvlaw0sdzzak1msc3a";
        public var hasBeta:Boolean = false;
        public var userid:String = "";
        protected var lb:LoginBox;
        protected var bp:BetaProgram;
        protected var fbsave:SharedObject;
        protected var roomname:String = null;
        protected var kongregate:Object;
        protected var habbo:habbologo;
        protected var sidechat:SideChat;
        public var isguest:Boolean = false;
        protected var forceBeta:Boolean;
        private var savetimer:Number = 0;
        private var rpcCon:Connection;
        private var connection:Connection;
        private var deltas:Array;
        private var inited:Boolean = false;
        private var upgrade:Boolean = false;

        public function EverybodyEditsBeta()
        {
            this.Rocks = EverybodyEditsBeta_Rocks;
            this.Rocks2 = EverybodyEditsBeta_Rocks2;
            this.lb = new LoginBox();
            this.bp = new BetaProgram();
            this.fbsave = SharedObject.getLocal("fbauth");
            this.habbo = new habbologo();
            if (true)
            {
            }
            this.forceBeta = false;
            this.deltas = [];
            super(800, 480, 1);
            screenContainer.smoothing = true;
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            Bl.data.brick = 0;
            Bl.data.base = this;
            if (true)
            {
            }
            Bl.data.isbeta = this.forceBeta;
            Bl.data.iskongregate = false;
            Bl.data.isfacebook = false;
            Bl.data.onsite = false;
            Bl.data.config = [[0, 0], [0, 9], [0, 10], [0, 11], [0, 16], [0, 17], [0, 18], [0, 29], [0, 32], [0, 2], [1, 0]];
            Bl.data.chatisvisible = true;
            Bl.data.hasbeta = false;
            Bl.data.roomname = "";
            Bl.data.name = "";
            Bl.data.coincount = 10;
            return;
        }// end function

        public function ShowLobby() : void
        {
            if (this.ui.parent)
            {
                removeChild(this.ui);
            }
            if (this.sidechat)
            {
            }
            if (this.sidechat.parent)
            {
                removeChild(this.sidechat);
            }
            if (this.connection.connected)
            {
                this.connection.disconnect();
            }
            this.showLobby();
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            var paramObj:Object;
            var apiPath:String;
            var request:URLRequest;
            var loader:Loader;
            var e:* = event;
            Log.View(407, "b24c9cd3-870b-49ac-b017-cbee232cf768", root.loaderInfo.loaderURL);
            Bl.data.showMap = false;
            Bl.data.canEdit = false;
            Bl.data.playSounds = true;
            Bl.stage.align = StageAlign.TOP_LEFT;
            var lstate:* = new LoadState();
            state = lstate;
            if (!LoaderInfo(stage.root.loaderInfo).parameters.nonoba$referer)
            {
            }
            this.iseecom = ("" + "").toLowerCase().indexOf("kongregate") == -1;
            if (ExternalInterface.available)
            {
                try
                {
                    this.roomname = ExternalInterface.call("ee_roomname.toString");
                    if (ExternalInterface.call("isbeta.toString") != "true")
                    {
                    }
                    Bl.data.isbeta = this.forceBeta;
                    if (ExternalInterface.call("iseecom.toString") == "true")
                    {
                    }
                    if (Bl.data.isbeta)
                    {
                    }
                    Bl.data.onsite = true;
                }
                catch (e:Error)
                {
                }
            }
            if (this.roomname != null)
            {
                if (this.roomname.substring(0, 2) != "PW")
                {
                }
				if (this.roomname.substring(0, 2) == "BW")
				{
					this.roomname.replace(" ", "-");
				}
            }
            if (Bl.data.isdebug)
            {
                this.roomname = "ChrisWorld";
            }
            var parameters:* = LoaderInfo(this.root.loaderInfo).parameters;
            if (parameters.fb_access_token)
            {
                PlayerIO.quickConnect.facebookOAuthConnect(stage, this.gameid, parameters.fb_access_token, this.simpleConnect, this.handleError);
                FB.init({access_token:parameters.fb_access_token, app_id:"132690750091157", debug:true});
                Bl.data.isfacebook = true;
            }
            else
            {
                if (this.fbsave.data.remember)
                {
                    this.lb.keeplogin.gotoAndStop(2);
                }
                if (this.fbsave.data.username)
                {
                }
                if (this.fbsave.data.password)
                {
                }
                if (Bl.data.isdebug)
                {
                    PlayerIO.quickConnect.simpleConnect(Bl.stage, this.gameid, this.fbsave.data.username, this.fbsave.data.password, this.simpleConnect, function (param1:PlayerIOError) : void
            {
                baseInit();
                return;
            }// end function
            );
                }
                else
                {
                    paramObj = LoaderInfo(root.loaderInfo).parameters;
                    apiPath = paramObj.kongregate_api_path;
                    if (apiPath)
                    {
                        this.lb.recoverpass.visible = false;
                        Bl.data.iskongregate = true;
                        Security.allowDomain(apiPath);
                        request = new URLRequest(apiPath);
                        loader = new Loader();
                        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                var user_id:String;
                var token:String;
                var e:* = event;
                kongregate = e.target.content;
                kongregate.services.connect();
                kongregate.stats.submit("Inited", 1);
                var isGuest:* = kongregate.services.isGuest();
                if (isGuest)
                {
                    baseInit();
                    kongregate.services.addEventListener("login", function () : void
                {
                    var _loc_1:* = kongregate.services.getUserId();
                    var _loc_2:* = kongregate.services.getGameAuthToken();
                    PlayerIO.quickConnect.kongregateConnect(stage, gameid, _loc_1, _loc_2, simpleConnect, handleError);
                    return;
                }// end function
                );
                }
                else
                {
                    user_id = kongregate.services.getUserId();
                    token = kongregate.services.getGameAuthToken();
                    PlayerIO.quickConnect.kongregateConnect(stage, gameid, user_id, token, simpleConnect, handleError);
                }
                return;
            }// end function
            );
                        loader.load(request);
                        this.addChild(loader);
                    }
                    else
                    {
                        this.baseInit();
                    }
                }
            }
            return;
        }// end function

        private function baseInit() : void
        {
            setTimeout(function () : void
            {
                if (Bl.data.isbeta)
                {
                    lb.gotoAndStop(3);
                    if (fbsave.data.remember)
                    {
                        lb.keeplogin.gotoAndStop(2);
                    }
                }
                lb.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
                {
                    event.preventDefault();
                    event.stopImmediatePropagation();
                    event.stopPropagation();
                    return;
                }// end function
                );
                lb.x = 20;
                lb.y = 280;
                lb.fbbtn.addEventListener(MouseEvent.CLICK, function () : void
                {
                    lb.fbbtn.mouseEnabled = false;
                    lb.fbbtn.enabled = false;
                    setTimeout(function () : void
                    {
                        lb.fbbtn.mouseEnabled = true;
                        lb.fbbtn.enabled = false;
                        return;
                    }// end function
                    , 1000);
                    if (fbsave.data.access_token)
                    {
                    }
                    if (lb.keeplogin.currentFrame == 2)
                    {
                        PlayerIO.quickConnect.facebookOAuthConnect(stage, gameid, fbsave.data.access_token, simpleConnect, function (param1:PlayerIOError) : void
                    {
                        fbconnect(lb.keeplogin.currentFrame == 2);
                        return;
                    }// end function
                    );
                    }
                    else
                    {
                        fbconnect(lb.keeplogin.currentFrame == 2);
                    }
                    return;
                }// end function
                );
                lb.recoverpass.addEventListener(MouseEvent.CLICK, function () : void
                {
                    showRecoverPassword();
                    Bl.stage.removeChild(lb);
                    return;
                }// end function
                );
                lb.recoverpass.tabEnabled = false;
                lb.keeplogin.addEventListener(MouseEvent.CLICK, function () : void
                {
                    lb.keeplogin.gotoAndStop(lb.keeplogin.currentFrame == 1 ? (2) : (1));
                    return;
                }// end function
                );
                lb.registerbtn.addEventListener(MouseEvent.CLICK, function () : void
                {
                    showRegister();
                    Bl.stage.removeChild(lb);
                    return;
                }// end function
                );
                if (!fbsave.data.username)
                {
                }
                lb.inpusername.text = "";
                if (!fbsave.data.password)
                {
                }
                lb.inppassword.text = "";
                lb.loginbtn.addEventListener(MouseEvent.CLICK, function () : void
                {
                    lb.loginbtn.mouseEnabled = false;
                    lb.loginbtn.enabled = false;
                    setTimeout(function () : void
                    {
                        lb.loginbtn.mouseEnabled = true;
                        lb.loginbtn.enabled = false;
                        return;
                    }// end function
                    , 1000);
                    PlayerIO.quickConnect.simpleConnect(Bl.stage, gameid, lb.inpusername.text, lb.inppassword.text, function (param1:Client) : void
                    {
                        if (lb.keeplogin.currentFrame == 2)
                        {
                            fbsave.data.username = lb.inpusername.text;
                            fbsave.data.password = lb.inppassword.text;
                            fbsave.data.remember = true;
                            fbsave.flush();
                        }
                        else
                        {
                            fbsave.data.access_token = "";
                            fbsave.data.facebookuserid = "";
                            fbsave.data.username = "";
                            fbsave.data.password = "";
                            fbsave.data.remember = false;
                            fbsave.flush();
                        }
                        if (lb.parent)
                        {
                            Bl.stage.removeChild(lb);
                        }
                        simpleConnect(param1);
                        return;
                    }// end function
                    , function (param1:PlayerIOError) : void
                    {
                        setError(lb.labelemail, param1.message.toString().toLowerCase().indexOf("password") == -1);
                        setError(lb.labelepassword, param1.message.toString().toLowerCase().indexOf("password") != -1);
                        return;
                    }// end function
                    );
                    return;
                }// end function
                );
                if (lb.joinbeta)
                {
                    lb.joinbeta.addEventListener(MouseEvent.CLICK, function () : void
                {
                    navigateToURL(new URLRequest("http://beta.everybodyedits.com/"), "_blank");
                    return;
                }// end function
                );
                }
                if (lb.guestbtn)
                {
                    lb.guestbtn.addEventListener(MouseEvent.CLICK, function () : void
                {
                    PlayerIO.quickConnect.simpleConnect(stage, gameid, "guest", "guest", function (param1:Client) : void
                    {
                        isguest = true;
                        if (lb.parent)
                        {
                            Bl.stage.removeChild(lb);
                        }
                        simpleConnect(param1);
                        return;
                    }// end function
                    , handleError);
                    return;
                }// end function
                );
                }
                Bl.stage.addChild(lb);
                if (Bl.data.iskongregate)
                {
                    lb.gotoAndStop(2);
                    lb.kongloginbtn.addEventListener(MouseEvent.CLICK, function () : void
                {
                    kongregate.services.showSignInBox();
                    return;
                }// end function
                );
                }
                return;
            }// end function
            , Bl.data.isdebug ? (0) : (800));
            return;
        }// end function

        public function buyGemsWithKongregate(param1:int, param2:Function) : void
        {
            var count:* = param1;
            var callback:* = param2;
            this.kongregate.mtx.purchaseItems(["coins" + count], function (param1:Object) : void
            {
                var result:* = param1;
                setTimeout(function () : void
                {
                    Shop.refresh(callback);
                    return;
                }// end function
                , 1000);
                return;
            }// end function
            );
            return;
        }// end function

        private function showRecoverPassword() : void
        {
            var r:ForgotPassword;
            r = new ForgotPassword();
            r.x = 20;
            r.y = 280;
            Bl.stage.addChild(r);
            r.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            r.close.addEventListener(MouseEvent.CLICK, function () : void
            {
                Bl.stage.addChild(lb);
                Bl.stage.removeChild(r);
                return;
            }// end function
            );
            r.recoverbtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                r.errors.text = "";
                PlayerIO.quickConnect.simpleRecoverPassword(gameid, r.inpemail.text, function () : void
                {
                    r.gotoAndStop(2);
                    return;
                }// end function
                , function (param1:PlayerIOError) : void
                {
                    r.errors.text = param1.message;
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function showRegister() : void
        {
            var r:RegisterBox;
            r = new RegisterBox();
            r.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            r.x = 20;
            r.y = 280;
            Bl.stage.addChild(r);
            r.close.addEventListener(MouseEvent.CLICK, function () : void
            {
                Bl.stage.addChild(lb);
                Bl.stage.removeChild(r);
                return;
            }// end function
            );
            r.close.tabEnabled = false;
            r.registerbtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                setError(r.labelpassword, false);
                setError(r.labelpassword2, false);
                setError(r.labelemail, false);
                if (r.inppassword.text != r.inppassword2.text)
                {
                    setError(r.labelpassword, true);
                    setError(r.labelpassword2, true);
                    r.errors.text = "Passwords does not match";
                    return;
                }
                PlayerIO.quickConnect.simpleRegister(Bl.stage, gameid, new Date().getTime() + "x" + (Math.random() * 100 >> 0), r.inppassword.text, r.inpemail.text, "", "", {}, function (param1:Client) : void
                {
                    Bl.stage.removeChild(r);
                    simpleConnect(param1);
                    return;
                }// end function
                , function (param1:PlayerIORegistrationError) : void
                {
                    r.errors.text = "";
                    if (param1.usernameError != null)
                    {
                        r.errors.appendText(param1.usernameError + "\n");
                    }
                    if (param1.emailError != null)
                    {
                        r.errors.appendText(param1.emailError + "\n");
                        setError(r.labelemail, true);
                    }
                    if (param1.passwordError != null)
                    {
                        r.errors.appendText(param1.passwordError + "\n");
                        setError(r.labelpassword, true);
                        setError(r.labelpassword2, true);
                    }
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function setError(param1:TextField, param2:Boolean) : void
        {
            var _loc_3:* = new TextFormat();
            _loc_3.color = param2 ? (16711680) : (16777215);
            param1.setTextFormat(_loc_3, -1, -1);
            return;
        }// end function

        private function simpleConnect(param1:Client, param2:String = "") : void
        {
            var c:* = param1;
            var id:* = param2;
            this.loadObject(c, function (param1:DatabaseObject) : void
            {
                var o:* = param1;
                if (lb.parent)
                {
                    lb.parent.removeChild(lb);
                }
                userid = c.connectUserId;
                var _loc_3:* = o.haveSmileyPackage;
                hasBeta = o.haveSmileyPackage;
                Bl.data.hasbeta = _loc_3;
                Bl.data.isModerator = o.isModerator;
                if (!o.name)
                {
                }
                Bl.data.name = "";
                setClient(c);
                if (roomname)
                {
                    setTimeout(function () : void
                {
                    LoadState(state).fadeOut(function () : void
                    {
                        joinRoom(roomname, true);
                        return;
                    }// end function
                    );
                    return;
                }// end function
                , Bl.data.isdebug ? (0) : (1000));
                }
                else
                {
                    showLobby(LoadState(state));
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function SystemSay(param1:String) : void
        {
            if (this.sidechat)
            {
                this.sidechat.addLine("* Warning", param1);
            }
            return;
        }// end function

        public function showKongregatePayment() : void
        {
            var kongbox:BetaProgramInfoKong;
            LobbyState(state).reset();
            kongbox = new BetaProgramInfoKong();
            kongbox.closebtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                if (kongbox.parent)
                {
                    kongbox.parent.removeChild(kongbox);
                }
                showLobby();
                return;
            }// end function
            );
            kongbox.buybtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                kongbox.buybtn.visible = false;
                kongregate.mtx.purchaseItems(["itempro"], function (param1:Object) : void
                {
                    if (param1.success)
                    {
                        if (kongbox.parent)
                        {
                            kongbox.parent.removeChild(kongbox);
                        }
                        var _loc_2:Boolean = true;
                        hasBeta = true;
                        Bl.data.hasbeta = _loc_2;
                        showLobby();
                    }
                    else
                    {
                        kongbox.buybtn.visible = true;
                    }
                    return;
                }// end function
                );
                return;
            }// end function
            );
            Bl.stage.addChild(kongbox);
            return;
        }// end function

        private function handleFacebookAuthSuccess(param1:Client, param2:String, param3:String) : void
        {
            var c:* = param1;
            var access_token:* = param2;
            var facebookuserid:* = param3;
            if (this.lb.keeplogin.currentFrame == 2)
            {
                this.fbsave.data.access_token = access_token;
                this.fbsave.data.facebookuserid = facebookuserid;
                this.fbsave.data.remember = true;
                this.fbsave.flush();
            }
            else
            {
                this.fbsave.data.access_token = "";
                this.fbsave.data.facebookuserid = "";
                this.fbsave.data.username = "";
                this.fbsave.data.password = "";
                this.fbsave.data.remember = false;
                this.fbsave.flush();
            }
            if (this.lb.parent == null)
            {
                return;
            }
            this.loadObject(c, function (param1:DatabaseObject) : void
            {
                var o:* = param1;
                userid = c.connectUserId;
                hasBeta = o.haveSmileyPackage;
                Bl.data.hasbeta = hasBeta;
                Bl.data.isModerator = o.isModerator;
                Bl.stage.removeChild(lb);
                setClient(c);
                if (roomname)
                {
                    setTimeout(function () : void
                {
                    LoadState(state).fadeOut(function () : void
                    {
                        joinRoom(roomname, true);
                        return;
                    }// end function
                    );
                    return;
                }// end function
                , Bl.data.isdebug ? (0) : (1000));
                }
                else
                {
                    showLobby(LoadState(state));
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function requestRemoteMethod(param1:String, param2:Function, ... args) : void
        {
            args = new activation;
            var name:* = param1;
            var callback:* = param2;
            var args:* = args;
            this.getRPCConnection(function (param1:Connection) : void
            {
                var con:* = param1;
                con.addMessageHandler(name, function (param1:Message) : void
                {
                    callback(param1);
                    con.removeMessageHandler(name, arguments.callee);
                    return;
                }// end function
                );
                var m:* = con.createMessage.apply(this, [name].concat(args));
                con.sendMessage(m);
                return;
            }// end function
            );
            return;
        }// end function

        public function getRPCConnection(param1:Function, param2:Function = null) : void
        {
            var callback:* = param1;
            var errorHandler:* = param2;
            if (this.rpcCon != null)
            {
				callback(this.rpcCon);
            }
            else
            {
                trace("Trying to connect to RPC");
                this.client.multiplayer.createJoinRoom(this.client.connectUserId, this.serviceVersion, true, {}, {}, function (param1:Connection) : void
            {
                var con:* = param1;
                rpcCon = con;
                con.addMessageHandler("info", function (param1:Message, param2:String, param3:String) : void
                {
                    showInfo(param2, param3);
                    return;
                }// end function
                );
                con.addDisconnectHandler(function () : void
                {
                    rpcCon = null;
                    return;
                }// end function
                );
                trace("RPC Connected");
                callback(con);
                return;
            }// end function
            , errorHandler);
            }
            return;
        }// end function

        public function disconnectRPC() : void
        {
            if (this.rpcCon != null)
            {
                trace("RPC Disconnect");
                if (this.rpcCon.connected)
                {
                    this.rpcCon.disconnect();
                }
                this.rpcCon = null;
            }
            return;
        }// end function

        private function migrateUsername(param1:DatabaseObject, param2:Client, param3:Function) : void
        {
            var um:UsernameMigration;
            var tff:TextFormat;
            var o:* = param1;
            var c:* = param2;
            var callback:* = param3;
            if (!o.name)
            {
            }
            if (c.connectUserId != "simpleguest")
            {
                um = new UsernameMigration();
                um.inputvar.maxChars = 20;
                um.inputvar.restrict = "0-9A-Z";
                um.inputvar.embedFonts = true;
                tff = new TextFormat("visitor", 20, 0);
                um.inputvar.defaultTextFormat = tff;
                Bl.stage.addChild(um);
                um.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
                um.sendbtn.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                var e:* = event;
                um.sendbtn.visible = false;
                getRPCConnection(function (param1:Connection) : void
                {
                    var gotUsername:Function;
                    var gotError:Function;
                    var con:* = param1;
                    gotUsername = function (param1:Message, param2:String) : void
                    {
                        o.name = param2;
                        um.parent.removeChild(um);
                        callback();
                        con.removeMessageHandler("username", gotUsername);
                        con.removeMessageHandler("error", gotError);
                        return;
                    }// end function
                    ;
                    gotError = function (param1:Message, param2:String) : void
                    {
                        um.errortext.text = param2;
                        um.sendbtn.visible = true;
                        con.removeMessageHandler("username", gotUsername);
                        con.removeMessageHandler("error", gotError);
                        return;
                    }// end function
                    ;
                    con.addMessageHandler("username", gotUsername);
                    con.addMessageHandler("error", gotError);
                    con.send("setUsername", um.inputvar.text);
                    return;
                }// end function
                , function (param1:PlayerIOError) : void
                {
                    trace("GAH", param1);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            }
            else
            {
                callback();
            }
            return;
        }// end function

        private function loadObject(param1:Client, param2:Function, param3:Boolean = true) : void
        {
            var c:* = param1;
            var callback:* = param2;
            var showlog:* = param3;
            if (showlog)
            {
                PlayerIO.showLogo(stage, "BC");
            }
            Shop.setBase(this, c);
            this.setClient(c);
            this.userid = c.connectUserId;
            c.bigDB.loadMyPlayerObject(function (param1:DatabaseObject) : void
            {
                var o:* = param1;
                Bl.data.canchat = !o.chatbanned;
                Bl.data.chatbanned = o.chatbanned;
                migrateUsername(o, c, function () : void
                {
                    callback(o);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        public function fbconnect(param1:Boolean) : void
        {
            var keep:* = param1;
            try
            {
                if (ExternalInterface.available)
                {
                }
            }
            catch (e:Error)
            {
            }
            PlayerIO.quickConnect.facebookOAuthConnectPopup(stage, this.gameid, "facebookpopup", keep ? (["offline_access"]) : ([]), this.handleFacebookAuthSuccess, this.handleError);
            return;
        }// end function

        private function setClient(param1:Client) : void
        {
            this.client = param1;
            Shop.setBase(this, param1);
            //if (Bl.data.useDebugServer)
            if(true)
			{
                this.client.multiplayer.developmentServer = "127.0.0.1:8184";
            }
            return;
        }// end function

        private function showLobby(param1:LoadState = null) : void
        {
            var self:EverybodyEditsBeta = this;
            var lstate:* = param1;
            if (!Bl.data.isbeta)
            {
            }
            if (Bl.data.onsite)
            {
            }
            if (Bl.data.canchat)
            {
                stage.align = StageAlign.TOP;
            }
            Bl.data.roomname = "";
            try
            {
                Bl.stage.displayState = StageDisplayState.NORMAL;
                Bl.stage.scaleMode = StageScaleMode.NO_SCALE;
            }
            catch (e:Error)
            {
            }
            if (lstate == null)
            {
                lstate = new LoadState();
            }
            state = lstate;
            if (this.upgrade)
            {
                return;
            }
            setTimeout(function () : void
            {
                client.multiplayer.listRooms(multiplayerversion, {}, 0, 0, function (param1:Array) : void
                {
                    var rooms:* = param1;
                    getBetaRooms(function (param1:Array) : void
                    {
                        var rooms2:* = param1;
                        Shop.refresh(function () : void
                        {
                            lstate.fadeOut(function () : void
                            {
                                state = new LobbyState(rooms.concat(rooms2), joinRoom, createRoom, joinMyRoom, iseecom, self, handleJoinSaved);
                                if (!hasBeta)
                                {
                                }
                                if (Bl.data.onsite)
                                {
                                }
                                return;
                            }// end function
                            );
                            return;
                        }// end function
                        );
                        return;
                    }// end function
                    );
                    return;
                }// end function
                );
                return;
            }// end function
            , Bl.data.isdebug ? (0) : (1500));
            return;
        }// end function

        private function getBetaRooms(param1:Function) : void
        {
            if (Bl.data.isbeta)
            {
                this.client.multiplayer.listRooms(this.betagameversion, {}, 0, 0, param1);
            }
            else
            {
                param1([]);
            }
            return;
        }// end function

        private function joinRoom(param1:String, param2:Boolean = false) : void
        {
            var rid:* = param1;
            var direct:* = param2;
            state = new JoinState();
            if (rid.substring(0, 2) != "PW")
            {
            }
            if (rid.substring(0, 2) != "BW")
            {
            }
            if (rid == "ChrisWorld")
            {
                this.joinSaved(rid);
            }
            else
            {
                this.client.multiplayer.joinRoom(rid, {}, function (param1:Connection) : void
            {
                handleJoin(param1, rid, direct);
                return;
            }// end function
            , function (param1:PlayerIOError) : void
            {
                showLobby();
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function joinSaved(param1:String) : void
        {
            var roomid:* = param1;
            roomid = roomid.split(" ").join("-");
            this.executeJoinPrivate(roomid);
            return;
        }// end function

        private function executeJoinPrivate(param1:String) : void
        {
            var roomid:* = param1;
            trace("here");
            this.client.multiplayer.createJoinRoom(roomid, roomid.substring(0, 2) == "BW" ? (this.betagameversion) : (this.multiplayerversion), true, {owned:"true"}, {}, function (param1:Connection) : void
            {
                handleJoin(param1, roomid, false, true);
                return;
            }// end function
            , function (param1:PlayerIOError) : void
            {
                trace(param1);
                showLobby();
                return;
            }// end function
            );
            return;
        }// end function

        private function handleJoinSaved(param1:int, param2:int) : void
        {
            var type:* = param1;
            var offset:* = param2;
            state = new JoinState();
            this.getRPCConnection(function (param1:Connection) : void
            {
                var con:* = param1;
                con.addMessageHandler("r", function (param1:Message, param2:String) : void
                {
                    joinSaved(param2);
                    con.removeMessageHandler("r", arguments.callee);
                    return;
                }// end function
                );
                trace("Sending request");
                con.send("getSavedLevel", type, offset);
                return;
            }// end function
            , function (param1:PlayerIOError) : void
            {
                trace(param1);
                showLobby();
                return;
            }// end function
            );
            trace(type, offset);
            return;
        }// end function

        private function joinMyRoom(param1:Boolean = false) : void
        {
            var isbetaroom:* = param1;
            if (!this.hasBeta)
            {
                return;
            }
            state = new JoinState();
            this.getRPCConnection(function (param1:Connection) : void
            {
                var con:* = param1;
                con.addMessageHandler("r", function (param1:Message, param2:String) : void
                {
                    joinSaved(param2);
                    con.removeMessageHandler("r", arguments.callee);
                    return;
                }// end function
                );
                con.send(isbetaroom ? ("getBetaRoom") : ("getRoom"));
                return;
            }// end function
            , function (param1:PlayerIOError) : void
            {
                showLobby();
                return;
            }// end function
            );
            return;
        }// end function

        private function handleJoin(param1:Connection, param2:String, param3:Boolean = false, param4:Boolean = false) : void
        {
            var self:EverybodyEditsBeta = this;
            var connection:* = param1;
            var roomid:* = param2;
            var direct:* = param3;
            var isLockedRoom:* = param4;
            this.sidechat = new SideChat(connection);
            this.sidechat.x = 640 - 1;
            this.disconnectRPC();
            this.deltas = [];
            this.inited = false;
            this.connection = connection;
            Log.Play();
            if (Bl.data.iskongregate)
            {
            }
            if (this.kongregate)
            {
                this.kongregate.stats.submit("Play", 1);
            }
            connection.addMessageHandler("upgrade", function () : void
            {
                var _loc_1:* = new Upgrade();
                Bl.stage.addChild(_loc_1);
                upgrade = true;
                return;
            }// end function
            );
            connection.addMessageHandler("info", function (param1:Message, param2:String, param3:String) : void
            {
                showInfo(param2, param3);
                return;
            }// end function
            );
            connection.addMessageHandler("init", function (param1:Message, param2:String, param3:int, param4:int, param5:int, param6:String, param7:Boolean, param8:Boolean, param9:int, param10:int) : void
            {
                if (sidechat)
                {
                    sidechat.setMe(param3.toString(), param6, Bl.data.canchat);
                }
                if (!Bl.data.isbeta)
                {
                }
                if (Bl.data.onsite)
                {
                }
                if (Bl.data.canchat)
                {
                    stage.align = StageAlign.TOP_LEFT;
                }
                Bl.data.m = derot(param2);
                if (!isLockedRoom)
                {
                }
                if (param7)
                {
                }
                Bl.data.isLockedRoom = param8;
                Bl.data.owner = param8;
                state = new PlayState(connection, param1, param3, param6, param4, param5, param9, param10);
                Bl.data.canEdit = param7;
                ui = new UI2(new Rocks(), new Rocks2(), new ui2smilies(), Bl.data.config, self, connection, param3, param7, roomid, sidechat);
                ui.y = 500;
                addChild(ui);
                if (sidechat)
                {
                    addChild(sidechat);
                }
                return;
            }// end function
            );
            connection.addDisconnectHandler(function () : void
            {
                showLobby();
                if (ui)
                {
                if (ui.parent)
                {
                    removeChild(ui);
                }
				}
                if (sidechat)
                {
                if (sidechat.parent)
                {
                    removeChild(sidechat);
                }
				}
                return;
            }// end function
            );
            this.inited = true;
            connection.send("init");
            return;
        }// end function

        public function showInfo(param1:String, param2:String) : void
        {
            var inf:InfoBox;
            var title:* = param1;
            var body:* = param2;
            inf = new InfoBox();
            inf.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            inf.ttitle.text = title;
            inf.tbody.text = body;
            inf.closebtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                Bl.stage.removeChild(inf);
                return;
            }// end function
            );
            inf.addEventListener(Event.ENTER_FRAME, function () : void
            {
                if (inf.parent)
                {
                    inf.parent.addChild(inf);
                }
                else
                {
                    inf.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                }
                return;
            }// end function
            );
            Bl.stage.addChild(inf);
            return;
        }// end function

        private function derot(param1:String) : String
        {
            var _loc_4:int = 0;
            var _loc_2:String = "";
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1.charCodeAt(_loc_3);
                if (_loc_4 >= "a".charCodeAt(0))
                {
                }
                if (_loc_4 <= "z".charCodeAt(0))
                {
                    if (_loc_4 > "m".charCodeAt(0))
                    {
                        _loc_4 = _loc_4 - 13;
                    }
                    else
                    {
                        _loc_4 = _loc_4 + 13;
                    }
                }
                else
                {
                    if (_loc_4 >= "A".charCodeAt(0))
                    {
                    }
                    if (_loc_4 <= "Z".charCodeAt(0))
                    {
                        if (_loc_4 > "M".charCodeAt(0))
                        {
                            _loc_4 = _loc_4 - 13;
                        }
                        else
                        {
                            _loc_4 = _loc_4 + 13;
                        }
                    }
                }
                _loc_2 = _loc_2 + String.fromCharCode(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        private function createRoom(param1:String, param2:String = "") : void
        {
            var roomid:String;
            var rid:* = param1;
            var editkey:* = param2;
            Bl.data.roomname = rid;
            state = new JoinState();
            roomid = ((Math.random() * 1000 >> 0) + new Date().getMilliseconds()).toString(36) + " " + rid;
            this.client.multiplayer.createJoinRoom(roomid, this.multiplayerversion, true, editkey == "" ? ({name:rid}) : ({editkey:editkey, name:rid}), editkey == "" ? ({}) : ({editkey:editkey}), function (param1:Connection) : void
            {
                handleJoin(param1, roomid, false, editkey != "");
                return;
            }// end function
            , function (param1:PlayerIOError) : void
            {
                trace(param1);
                showLobby();
                return;
            }// end function
            );
            return;
        }// end function

        private function handleError(param1:PlayerIOError) : void
        {
            trace("Got", param1);
            return;
        }// end function

    }
}
