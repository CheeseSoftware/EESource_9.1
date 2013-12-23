package playerio
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
	Security.LOCAL_TRUSTED;
    final public class PlayerIO extends Object
    {
        private static var wrapper:Loader;
        private static var queue:Array = [];
        private static var apiError:PlayerIOError;
        private static var wo:Object = {};

        public function PlayerIO()
        {
            throw new Error("You cannot create an instance of the PlayerIO class!");
        }// end function

        public static function connect(param1:Stage, param2:String, param3:String, param4:String, param5:String, param6:Function, param7:Function = null) : void
        {
            proxy("connect", arguments);
            return;
        }// end function

        public static function get quickConnect() : QuickConnect
        {
            return new QuickConnect(proxy);
        }// end function

        public static function gameFS(param1:String) : GameFS
        {
            return new SimpleGameFS(param1, wo);
        }// end function

        public static function showLogo(param1:Stage, param2:String) : void
        {
            proxy("showLogo", arguments);
            return;
        }// end function

        private static function proxy(param1:String, param2:Object) : void
        {
            var api:*;
            var path:Array;
            var target:* = param1;
            var args:* = param2;
            if (apiError)
            {
                throwError(apiError, args[(args.callee.length - 1)]);
            }
            else
            {
                if (wrapper)
                {
                if (wrapper.content)
                {
                    try
                    {
                        api = wrapper.content;
                        path = target.split(".");
                        while (path.length > 1)
                        {
                            
                            api = api[path.shift()];
                        }
                        api[path[0]].apply(null, args);
                    }
                    catch (e:Error)
                    {
                        throwError(new PlayerIOError(e.message, e.errorID), args[(args.callee.length - 1)]);
                    }
                }
                else
                {
                    queue.push(function () : void
            {
                args.callee.apply(null, args);
                return;
            }// end function
            );
				}
                }
            }
            if (!wrapper)
            {
                loadAPI();
            }
            return;
        }// end function

        private static function loadAPI() : void
        {
            var loader:URLLoader;
            wrapper = new Loader();
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            loader.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                wrapper.contentLoaderInfo.addEventListener(Event.COMPLETE, emptyQueue);
                wrapper.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleLoadError);
                wrapper.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadError);
                wrapper.loadBytes(loader.data, new LoaderContext(false, ApplicationDomain.currentDomain));
                wo.wrapper = wrapper;
                return;
            }// end function
            );
            loader.addEventListener(IOErrorEvent.IO_ERROR, handleLoadError);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadError);
            loader.load(new URLRequest("http://api.playerio.com/flashbridge/1"));
            return;
        }// end function

        private static function handleLoadError(event:Event = null) : void
        {
            apiError = new PlayerIOError("Unable to connect to the API due to " + event.type + ". Please verify that your internet connection is working!", 0);
            emptyQueue();
            return;
        }// end function

        private static function emptyQueue(event:Event = null) : void
        {
            while (queue.length)
            {
                
                PlayerIO.queue.shift()();
            }
            return;
        }// end function

        private static function throwError(param1:PlayerIOError, param2:Function) : void
        {
            if (param2 != null)
            {
                PlayerIO.param2(param1);
            }
            else
            {
                throw PlayerIOError;
            }
            return;
        }// end function

    }
}
