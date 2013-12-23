package SWFStats
{
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    final public class Log extends Object
    {
        private static const Random:Number = Math.random();
        private static var Enabled:Boolean = false;
        public static var SWFID:int = 0;
        public static var GUID:String = "";
        public static var SourceUrl:String;
        private static const PingF:Timer = new Timer(60000);
        private static const PingR:Timer = new Timer(30000);
        private static var FirstPing:Boolean = true;
        private static var Pings:int = 0;
        private static var Plays:int = 0;
        private static var HighestGoal:int = 0;

        public function Log()
        {
            return;
        }// end function

        public static function View(param1:int = 0, param2:String = "", param3:String = "") : void
        {
            SWFID = param1;
            GUID = param2;
            Enabled = true;
            if (SWFID != 0)
            {
            }
            if (GUID == "")
            {
                Enabled = false;
                return;
            }
            if (param3.indexOf("http://") != 0)
            {
            }
            if (Security.sandboxType != "localWithNetwork")
            {
            }
            if (Security.sandboxType != "localTrusted")
            {
                Enabled = false;
                return;
            }
            SourceUrl = GetUrl(param3);
            if (SourceUrl != null)
            {
            }
            if (SourceUrl == "")
            {
                Enabled = false;
                return;
            }
            Security.allowDomain("http://tracker.swfstats.com/");
            Security.allowInsecureDomain("http://tracker.swfstats.com/");
            Security.loadPolicyFile("http://tracker.swfstats.com/crossdomain.xml");
            Security.allowDomain("http://utils.swfstats.com/");
            Security.allowInsecureDomain("http://utils.swfstats.com/");
            Security.loadPolicyFile("http://utils.swfstats.com/crossdomain.xml");
            var _loc_4:* = GetCookie("views");
            _loc_4 = _loc_4 + 1;
            SaveCookie("views", _loc_4);
            Send("View", "views=" + _loc_4);
            PingF.addEventListener(TimerEvent.TIMER, PingServer);
            PingF.start();
            return;
        }// end function

        public static function Play() : void
        {
            if (!Enabled)
            {
                return;
            }
            var _loc_2:* = Plays + 1;
            Plays = _loc_2;
            Send("Play", "plays=" + Plays);
            return;
        }// end function

        public static function Goal(param1:int, param2:String) : void
        {
            return;
        }// end function

        private static function PingServer(... args) : void
        {
            if (!Enabled)
            {
                return;
            }
            var _loc_3:* = Pings + 1;
            Pings = _loc_3;
            Send("Ping", (FirstPing ? ("&firstping=yes") : ("")) + "&pings=" + Pings);
            if (FirstPing)
            {
                PingF.stop();
                PingR.addEventListener(TimerEvent.TIMER, PingServer);
                PingR.start();
                FirstPing = false;
            }
            return;
        }// end function

        public static function CustomMetric(param1:String, param2:String = null) : void
        {
            if (!Enabled)
            {
                return;
            }
            if (param2 == null)
            {
                param2 = "";
            }
            Send("CustomMetric", "name=" + escape(param1) + "&group=" + escape(param2));
            return;
        }// end function

        public static function LevelCounterMetric(param1:String, param2) : void
        {
            if (!Enabled)
            {
                return;
            }
            Send("LevelMetric", "name=" + escape(param1) + "&level=" + param2);
            return;
        }// end function

        public static function LevelRangedMetric(param1:String, param2, param3:int) : void
        {
            if (!Enabled)
            {
                return;
            }
            Send("LevelMetricRanged", "name=" + escape(param1) + "&level=" + param2 + "&value=" + param3);
            return;
        }// end function

        public static function LevelAverageMetric(param1:String, param2, param3:int) : void
        {
            if (!Enabled)
            {
                return;
            }
            Send("LevelMetricAverage", "name=" + escape(param1) + "&level=" + param2 + "&value=" + param3);
            return;
        }// end function

        private static function Send(param1:String, param2:String) : void
        {
            var _loc_3:* = new URLLoader();
            _loc_3.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler);
            _loc_3.addEventListener(HTTPStatusEvent.HTTP_STATUS, StatusChange);
            _loc_3.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler);
            _loc_3.load(new URLRequest("http://tracker.swfstats.com/Games/" + param1 + ".html?guid=" + GUID + "&swfid=" + SWFID + "&" + param2 + "&url=" + SourceUrl + "&" + Random));
            return;
        }// end function

        private static function ErrorHandler(... args) : void
        {
            Enabled = false;
            return;
        }// end function

        private static function StatusChange(... args) : void
        {
            return;
        }// end function

        private static function GetCookie(param1:String) : int
        {
            var _loc_2:* = SharedObject.getLocal("swfstats");
            if (_loc_2.data[param1] == undefined)
            {
                return 0;
            }
            return int(_loc_2.data[param1]);
        }// end function

        private static function SaveCookie(param1:String, param2:int) : void
        {
            var _loc_3:* = SharedObject.getLocal("swfstats");
            _loc_3.data[param1] = param2.toString();
            _loc_3.flush();
            return;
        }// end function

        private static function GetUrl(param1:String) : String
        {
            var url:String;
            var defaulturl:* = param1;
            if (ExternalInterface.available)
            {
                try
                {
                    url = String(ExternalInterface.call("window.location.href.toString"));
                }
                catch (s:Error)
                {
                    url = defaulturl;
                }
            }
            else if (defaulturl.indexOf("http://") == 0)
            {
                url = defaulturl;
            }
            if (url != null)
            {
            }
            if (url != "")
            {
            }
            if (url == "null")
            {
                if (Security.sandboxType != "localWithNetwork")
                {
                }
                if (Security.sandboxType == "localTrusted")
                {
                    url;
                }
                else
                {
                    url;
                }
            }
            return url;
        }// end function

    }
}
