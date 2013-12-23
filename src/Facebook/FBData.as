package Facebook
{
    import flash.utils.*;

    public class FBData extends Object
    {
        private var timer:int = -1;
        private var queue:Array;

        public function FBData()
        {
            this.queue = [];
            return;
        }// end function

        public function query(param1:String, ... args) : FBQuery
        {
            args = new FBQuery().parse(param1, args);
            this.queue.push(args);
            this._waitToProcess();
            return args;
        }// end function

        public function waitOn(param1:Array, param2:Function) : FBWaitable
        {
            var result:FBWaitable;
            var count:int;
            var dependencies:* = param1;
            var callback:* = param2;
            result = new FBWaitable();
            count = dependencies.length;
            FB.forEach(dependencies, function (param1, param2, param3) : void
            {
                var item:* = param1;
                var index:* = param2;
                var original:* = param3;
                item.monitor("value", function () : Boolean
                {
                    var _loc_2:* = undefined;
                    var _loc_1:Boolean = false;
                    if (FB.Data._getValue(item) != null)
                    {
                        var _loc_4:* = count - 1;
                        count = _loc_4;
                        _loc_1 = true;
                    }
                    if (count == 0)
                    {
                        _loc_2 = callback(FB.arrayMap(dependencies, FB.Data._getValue));
                        result.value = _loc_2 != null ? (_loc_2) : (true);
                    }
                    return _loc_1;
                }// end function
                );
                return;
            }// end function
            );
            return result;
        }// end function

        private function _getValue(param1)
        {
            return param1 is FBWaitable ? (param1.value) : (param1);
        }// end function

        private function _waitToProcess() : void
        {
            if (this.timer < 0)
            {
                this.timer = setTimeout(this._process, 10);
            }
            return;
        }// end function

        private function _process() : void
        {
            var mqueries:Object;
            var item:FBQuery;
            this.timer = -1;
            mqueries;
            var q:* = this.queue;
            this.queue = [];
            var i:int;
            while (i < q.length)
            {
                
                item = q[i];
                if (item.where.type == "index")
                {
                }
                if (!item.hasDependency)
                {
                    this._mergeIndexQuery(item, mqueries);
                }
                else
                {
                    mqueries[item.name] = item;
                }
                i = (i + 1);
            }
            var params:Object;
            FB.objCopy(params.queries, mqueries, true, function (param1:FBQuery) : String
            {
                return param1.toFql();
            }// end function
            );
            params.queries = JSON.serialize(params.queries);
            FB.api(params, function (param1) : void
            {
                var _loc_2:String = null;
                var _loc_3:int = 0;
                var _loc_4:* = undefined;
                if (param1.error_msg)
                {
                    for (_loc_2 in mqueries)
                    {
                        
                        mqueries[_loc_2].error(new Error(param1.error_msg));
                    }
                }
                else
                {
                    _loc_3 = 0;
                    while (_loc_3 < param1.length)
                    {
                        
                        _loc_4 = param1[_loc_3];
                        mqueries[_loc_4.name].value = _loc_4.fql_result_set;
                        _loc_3 = _loc_3 + 1;
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function _mergeIndexQuery(param1:FBQuery, param2:Object) : void
        {
            var key:String;
            var value:*;
            var item:* = param1;
            var mqueries:* = param2;
            key = item.where.key;
            value = item.where.value;
            var name:* = "index_" + item.table + "_" + key;
            var master:* = mqueries[name];
            if (!master)
            {
                var _loc_4:* = new FBQuery();
                mqueries[name] = new FBQuery();
                master = _loc_4;
                master.fields = [key];
                master.table = item.table;
                master.where = {type:"in", key:key, value:[]};
            }
            FB.arrayMerge(master.fields, item.fields);
            FB.arrayMerge(master.where.value, [value]);
            master.wait(function (param1:Array) : void
            {
                var r:* = param1;
                item.value = FB.arrayFilter(r, function (param1:Object) : Boolean
                {
                    return param1[key] == value;
                }// end function
                );
                return;
            }// end function
            , function (param1) : void
            {
                item.fire("error", param1);
                return;
            }// end function
            );
            return;
        }// end function

    }
}
