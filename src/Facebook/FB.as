﻿package Facebook
{
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;

    public class FB extends Object
    {
        private static var allowedMethods:Object = {GET:1, POST:1, DELETE:1, PUT:1};
        private static var readOnlyCalls:Object = {fql_query:1, fql_multiquery:1, friends_get:1, notifications_get:1, stream_get:1, users_getinfo:1};
        private static var access_token:String = null;
        private static var app_id:String = null;
        private static var debug:Boolean = false;
        private static var uiFlashId:String = null;
        private static var uiCallbackId:Number = 0;
        private static var data:FBData = new FBData();
        private static var _formatRE:RegExp = /(\{[^\}^\{]+\})""(\{[^\}^\{]+\})/g;
        private static var _trimRE:RegExp = /^\s*|\s*$""^\s*|\s*$/g;
        private static var _quoteRE:RegExp = /[""\\\\\ 0-\f\f-\	f]""["\\\x00-\x1f\x7f-\x9f]/g;

        public function FB()
        {
            return;
        }// end function

        public static function get Data() : FBData
        {
            return data;
        }// end function

        public static function init(param1) : void
        {
            debug = param1.debug;
            app_id = param1.app_id;
            if ((param1.access_token + "").length < 3)
            {
                error("You must supply the init method with an not-null access_token string.");
            }
            else
            {
                access_token = param1.access_token;
                log("Initializing with access_token: " + access_token);
            }
            return;
        }// end function

        public static function api(... args) : void
        {
            requireAccessToken("api");
            if (typeof(args[0]) == "string")
            {
                graphCall.apply(null, args);
            }
            else
            {
                restCall.apply(null, args);
            }
            return;
        }// end function

        public static function get uiAvailable() : Boolean
        {
            return initUI() == null;
        }// end function

        public static function ui(param1, param2:Function) : void
        {
            var params:* = param1;
            var cb:* = param2;
            var err:* = initUI();
            if (err != null)
            {
                error(err);
            }
            if (!params.method)
            {
                error("\"method\" is a required parameter for FB.ui().");
            }
            var callbackId:* = "as_ui_callback_" + uiCallbackId++;
            ExternalInterface.addCallback(callbackId, function (param1) : void
            {
                log("Got response from Javascript FB.ui: " + toString(param1));
                cb(param1);
                return;
            }// end function
            );
            ExternalInterface.call("__doFBUICall", uiFlashId, params, callbackId);
            return;
        }// end function

        private static function initUI() : String
        {
            var allowsExternalInterface:Boolean;
            var hasJavascript:Boolean;
            var source:String;
            if (uiFlashId == null)
            {
                Security.allowDomain("*");
                allowsExternalInterface;
                try
                {
                    allowsExternalInterface = ExternalInterface.call("eval", "true");
                }
                catch (e)
                {
                }
                if (!allowsExternalInterface)
                {
                    return "The flash element must not have allowNetworking = \'none\' in the containing page in order to call the FB.ui() method.";
                }
                hasJavascript = ExternalInterface.call("eval", "typeof(FB)!=\'undefined\' && typeof(FB.ui)!=\'undefined\'");
                if (!hasJavascript)
                {
                    return "The FB.ui() method can only be used when the containing page includes the Facebook Javascript SDK. Read more here: http://developers.facebook.com/docs/reference/javascript/FB.init";
                }
                uiFlashId = "flash_" + new Date().getTime() + Math.round(Math.random() * 9999999);
                ExternalInterface.addCallback("getFlashId", function () : String
            {
                return uiFlashId;
            }// end function
            );
                source;
                source = source + "__doFBUICall = function(uiFlashId,params,callbackId){";
                source = source + (" var find = function(tag){var list=document.getElementsByTagName(tag);for(var i=0;i!=list.length;i++){if(list[i].getFlashId&&list[i].getFlashId()==\"" + uiFlashId + "\"){return list[i]}}};");
                source = source + " var flashObj = find(\"embed\") || find(\"object\");";
                source = source + " if(flashObj != null){";
                source = source + "  FB.ui(params, function(response){";
                source = source + "   flashObj[callbackId](response);";
                source = source + "  })";
                source = source + (" }else{alert(\"could not find flash element on the page w/ uiFlashId: " + uiFlashId + "\")}");
                source = source + "};";
                ExternalInterface.call("eval", source);
            }
            return null;
        }// end function

        private static function graphCall(... args) : void
        {
            var _loc_7:String = null;
            var _loc_8:String = null;
            args = null;
            var _loc_3:* = null;
            var _loc_4:Function = null;
            var _loc_5:* = args.shift();
            var _loc_6:* = args.shift();
            while (_loc_6)
            {
                
                _loc_7 = typeof(_loc_6);
                if (_loc_7 === "string")
                {
                }
                if (args == null)
                {
                    _loc_8 = _loc_6.toUpperCase();
                    if (allowedMethods[_loc_8])
                    {
                        args = _loc_8;
                    }
                    else
                    {
                        error("Invalid method passed to FB.api(" + _loc_5 + "): " + _loc_6);
                    }
                }
                else
                {
                    if (_loc_7 === "function")
                    {
                    }
                    if (_loc_4 == null)
                    {
                        _loc_4 = _loc_6;
                    }
                    else
                    {
                        if (_loc_7 === "object")
                        {
                        }
                        if (_loc_3 == null)
                        {
                            _loc_3 = _loc_6;
                        }
                        else
                        {
                            error("Invalid argument passed to FB.api(" + _loc_5 + "): " + _loc_6);
                        }
                    }
                }
                _loc_6 = args.shift();
            }
            if (!args)
            {
            }
            args = "GET";
            if (!_loc_3)
            {
            }
            _loc_3 = {};
            log("Graph call: path=" + _loc_5 + ", method=" + args + ", params=" + toString(_loc_3));
            oauthRequest("https://graph.facebook.com" + _loc_5, args, _loc_3, _loc_4);
            return;
        }// end function

        private static function restCall(param1, param2:Function) : void
        {
            var _loc_3:* = (param1.method + "").toLowerCase().replace(".", "_");
            param1.format = "json-strings";
            param1.api_key = app_id;
            log("REST call: method=" + _loc_3 + ", params=" + toString(param1));
            oauthRequest("https://" + (readOnlyCalls[_loc_3] ? ("api-read") : ("api")) + ".facebook.com/restserver.php", "get", param1, param2);
            return;
        }// end function

        private static function oauthRequest(param1:String, param2:String, param3, param4:Function) : void
        {
            var x:*;
            var loader:URLLoader;
            var url:* = param1;
            var method:* = param2;
            var params:* = param3;
            var cb:* = param4;
            var request:* = new URLRequest(url);
            request.method = method;
            request.data = new URLVariables();
            request.data.access_token = access_token;
            var _loc_6:int = 0;
            var _loc_7:* = params;
            while (_loc_7 in _loc_6)
            {
                
                x = _loc_7[_loc_6];
                request.data[x] = params[x];
            }
            request.data.callback = "c";
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                var _loc_2:* = loader.data;
                if (_loc_2.length > 2)
                {
                }
                if (_loc_2.substring(0, 2) == "c(")
                {
                    _loc_2 = loader.data.substring((loader.data.indexOf("(") + 1), loader.data.lastIndexOf(")"));
                }
                var _loc_3:* = JSON.deserialize(_loc_2);
                if (url.substring(0, 11) == "https://api")
                {
                    log("REST call result, method=" + params.method + " => " + toString(_loc_3));
                }
                else
                {
                    log("Graph call result, path=" + url + " => " + toString(_loc_3));
                }
                cb(_loc_3);
                return;
            }// end function
            );
            loader.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent) : void
            {
                error("Error in response from Facebook api servers, most likely cause is expired or invalid access_token. Error message: " + event.text);
                return;
            }// end function
            );
            loader.load(request);
            return;
        }// end function

        private static function requireAccessToken(param1:String) : void
        {
            if (access_token == null)
            {
                error("You must call FB.init({access_token:\"...\") before attempting to call FB." + param1 + "()");
            }
            return;
        }// end function

        private static function error(param1:String) : void
        {
            if (debug)
            {
                trace("FB Error: " + param1);
            }
            throw new Error(param1);
        }// end function

        private static function log(param1:String) : void
        {
            if (debug)
            {
                trace("FB: " + param1);
            }
            return;
        }// end function

        public static function toString(param1) : String
        {
            var _loc_2:String = null;
            var _loc_3:String = null;
            var _loc_4:Boolean = false;
            var _loc_5:Boolean = false;
            var _loc_6:* = undefined;
            if (param1 == null)
            {
                return "[null]";
            }
            switch(typeof(param1))
            {
                case "object":
                {
                    _loc_2 = "{";
                    _loc_3 = "[";
                    _loc_4 = true;
                    _loc_5 = false;
                    for (_loc_6 in param1)
                    {
                        
                        _loc_2 = _loc_2 + ((_loc_2 == "{" ? ("") : (", ")) + _loc_6 + "=" + toString(param1[_loc_6]));
                        _loc_3 = _loc_3 + ((_loc_3 == "[" ? ("") : (", ")) + toString(param1[_loc_6]));
                        if (typeof(_loc_6) != "number")
                        {
                            _loc_4 = false;
                        }
                        _loc_5 = true;
                    }
                    if (_loc_4)
                    {
                    }
                    return _loc_5 ? (_loc_3 + "]") : (_loc_2 + "}");
                }
                case "string":
                {
                    return "\"" + param1.replace("\n", "\\n").replace("\r", "\\r") + "\"";
                }
                default:
                {
                    return param1 + "";
                    break;
                }
            }
        }// end function

        static function stringTrim(param1:String) : String
        {
            return param1.replace(_trimRE, "");
        }// end function

        static function stringFormat(param1:String, ... args) : String
        {
            args = new activation;
            var format:* = param1;
            var args:* = args;
            return replace(_formatRE, function (param1:String, param2:String, param3:int, param4:String) : String
            {
                param3 = parseInt(param2.substr(1), 10);
                var _loc_5:* = args[param3];
                if (_loc_5 !== null)
                {
                }
                if (typeof(_loc_5) == "undefined")
                {
                    return "";
                }
                return _loc_5.toString();
            }// end function
            );
        }// end function

        static function stringQuote(param1:String) : String
        {
            var subst:Object;
            var value:* = param1;
            subst;
            return _quoteRE.test(value) ? ("\"" + value.replace(_quoteRE, function (param1:String) : String
            {
                var _loc_2:* = subst[param1];
                if (_loc_2)
                {
                    return _loc_2;
                }
                _loc_2 = param1.charCodeAt();
                return "\\u00" + Math.floor(_loc_2 / 16).toString(16) + (_loc_2 % 16).toString(16);
            }// end function
            ) + "\"") : ("\"" + value + "\"");
        }// end function

        static function arrayIndexOf(param1:Array, param2) : int
        {
            var _loc_4:int = 0;
            var _loc_3:* = param1.length;
            if (_loc_3)
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    if (param1[_loc_4] === param2)
                    {
                        return _loc_4;
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            return -1;
        }// end function

        static function arrayMerge(param1:Array, param2:Array) : Array
        {
            var _loc_3:int = 0;
            while (_loc_3 < param2.length)
            {
                
                if (arrayIndexOf(param1, param2[_loc_3]) < 0)
                {
                    param1.push(param2[_loc_3]);
                }
                _loc_3 = _loc_3 + 1;
            }
            return param1;
        }// end function

        static function arrayMap(param1:Array, param2:Function) : Array
        {
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_3.push(FB.param2(param1[_loc_4]));
                _loc_4 = _loc_4 + 1;
            }
            return _loc_3;
        }// end function

        static function arrayFilter(param1:Array, param2:Function) : Array
        {
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < param1.length)
            {
                
                if (FB.param2(param1[_loc_4]))
                {
                    _loc_3.push(param1[_loc_4]);
                }
                _loc_4 = _loc_4 + 1;
            }
            return _loc_3;
        }// end function

        static function objCopy(param1:Object, param2:Object, param3:Boolean, param4:Function) : Object
        {
            var _loc_5:String = null;
            for (_loc_5 in param2)
            {
                
                if (!param3)
                {
                }
                if (typeof(param1[_loc_5]) == "undefined")
                {
                    param1[_loc_5] = typeof(param4) == "function" ? (FB.param4(param2[_loc_5])) : (param2[_loc_5]);
                }
            }
            return param1;
        }// end function

        static function forEach(param1, param2:Function) : void
        {
            var _loc_3:uint = 0;
            var _loc_4:* = undefined;
            if (!param1)
            {
                return;
            }
            if (param1 is Array)
            {
                _loc_3 = 0;
                while (_loc_3 != param1.length)
                {
                    
                    FB.param2(param1[_loc_3], _loc_3, param1);
                    _loc_3 = _loc_3 + 1;
                }
            }
            else if (param1 is Object)
            {
                for (_loc_4 in param1)
                {
                    
                    FB.param2(param1[_loc_4], _loc_4, param1);
                }
            }
            return;
        }// end function

    }
}
