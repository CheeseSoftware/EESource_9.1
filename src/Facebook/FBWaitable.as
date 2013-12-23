package Facebook
{

    public class FBWaitable extends Object
    {
        private var subscribers:Object;
        private var _value:Object = null;

        public function FBWaitable()
        {
            this.subscribers = {};
            return;
        }// end function

        public function set value(param1:Object) : void
        {
            if (JSON.serialize(param1) != JSON.serialize(this._value))
            {
                this._value = param1;
                this.fire("value", param1);
            }
            return;
        }// end function

        public function get value() : Object
        {
            return this._value;
        }// end function

        public function error(param1:Error) : void
        {
            this.fire("error", param1);
            return;
        }// end function

        public function wait(param1:Function, ... args) : void
        {
            args = new activation;
            var t:*;
            var callback:* = param1;
            var args:* = args;
            if (length == 1)
            {
            }
            var errorHandler:* = [0] is Function ? ([0]) : (null);
            if (errorHandler != null)
            {
                this.subscribe("error", errorHandler);
            }
            t;
            this.monitor("value", function () : Boolean
            {
                if (t.value != null)
                {
                    callback(t.value);
                    return true;
                }
                return false;
            }// end function
            );
            return;
        }// end function

        public function subscribe(param1:String, param2:Function) : void
        {
            if (!this.subscribers[param1])
            {
                this.subscribers[param1] = [param2];
            }
            else
            {
                this.subscribers[param1].push(param2);
            }
            return;
        }// end function

        public function unsubscribe(param1:String, param2:Function) : void
        {
            var _loc_4:int = 0;
            var _loc_3:* = this.subscribers[param1];
            if (_loc_3)
            {
                _loc_4 = 0;
                while (_loc_4 != _loc_3.length)
                {
                    
                    if (_loc_3[_loc_4] == param2)
                    {
                        _loc_3[_loc_4] = null;
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            return;
        }// end function

        public function monitor(param1:String, param2:Function) : void
        {
            var ctx:FBWaitable;
            var fn:Function;
            var name:* = param1;
            var callback:* = param2;
            if (!this.callback())
            {
                ctx;
                fn = function (... args) : void
            {
                if (callback.apply(callback, args))
                {
                    ctx.unsubscribe(name, fn);
                }
                return;
            }// end function
            ;
                this.subscribe(name, fn);
            }
            return;
        }// end function

        public function clear(param1:String) : void
        {
            delete this.subscribers[param1];
            return;
        }// end function

        public function fire(param1:String, ... args) : void
        {
            var _loc_4:int = 0;
            args = this.subscribers[param1];
            if (args)
            {
                _loc_4 = 0;
                while (_loc_4 != args.length)
                {
                    
                    if (args[_loc_4] != null)
                    {
                        args[_loc_4].apply(this, args);
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            return;
        }// end function

    }
}
