package playerio
{
    import flash.display.*;

    public class QuickConnect extends Object
    {
        private var _proxy:Function;

        public function QuickConnect(param1:Function)
        {
            this._proxy = param1;
            return;
        }// end function

        public function simpleConnect(param1:Stage, param2:String, param3:String, param4:String, param5:Function = null, param6:Function = null) : void
        {
            this._proxy("quickConnect.simpleConnect", arguments);
            return;
        }// end function

        public function simpleRegister(param1:Stage, param2:String, param3:String, param4:String, param5:String, param6:String = "", param7:String = "", param8:Object = null, param9:Function = null, param10:Function = null) : void
        {
            this._proxy("quickConnect.simpleRegister", arguments);
            return;
        }// end function

        public function simpleGetCaptcha(param1:String, param2:int, param3:int, param4:Function = null, param5:Function = null) : void
        {
            this._proxy("quickConnect.simpleGetCaptcha", arguments);
            return;
        }// end function

        public function simpleRecoverPassword(param1:String, param2:String, param3:Function = null, param4:Function = null) : void
        {
            this._proxy("quickConnect.simpleRecoverPassword", arguments);
            return;
        }// end function

        public function kongregateConnect(param1:Stage, param2:String, param3:String, param4:String, param5:Function = null, param6:Function = null) : void
        {
            this._proxy("quickConnect.kongregateConnect", arguments);
            return;
        }// end function

        public function facebookConnect(param1:Stage, param2:String, param3:String, param4:String, param5:Function = null, param6:Function = null) : void
        {
            this._proxy("quickConnect.facebookConnect", arguments);
            return;
        }// end function

        public function facebookConnectPopup(param1:Stage, param2:String, param3:String, param4:Array, param5:Function = null, param6:Function = null) : void
        {
            this._proxy("quickConnect.facebookConnectPopup", arguments);
            return;
        }// end function

        public function facebookOAuthConnect(param1:Stage, param2:String, param3:String, param4:Function = null, param5:Function = null) : void
        {
            this._proxy("quickConnect.facebookOAuthConnect", arguments);
            return;
        }// end function

        public function facebookOAuthConnectPopup(param1:Stage, param2:String, param3:String, param4:Array, param5:Function = null, param6:Function = null) : void
        {
            this._proxy("quickConnect.facebookOAuthConnectPopup", arguments);
            return;
        }// end function

    }
}
