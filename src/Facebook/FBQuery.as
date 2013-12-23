package Facebook
{

    public class FBQuery extends FBWaitable
    {
        public var name:String = "";
        public var hasDependency:Boolean = false;
        public var fields:Array;
        public var table:String = null;
        public var where:Object = null;
        private static var counter:int = 0;

        public function FBQuery()
        {
            this.fields = [];
            this.name = "v_" + counter++;
            return;
        }// end function

        function parse(param1:String, param2:Array) : FBQuery
        {
            var _loc_3:* = FB.stringFormat(param1, param2);
            var _loc_4:* = /^select (.*?) from (\w+)\s+where (.*)$""^select (.*?) from (\w+)\s+where (.*)$/i.exec(_loc_3);
            this.fields = this._toFields(_loc_4[1]);
            this.table = _loc_4[2];
            this.where = this._parseWhere(_loc_4[3]);
            var _loc_5:uint = 0;
            while (_loc_5 < param2.length)
            {
                
                if (param2[_loc_5] is FBQuery)
                {
                    param2[_loc_5].hasDependency = true;
                }
                _loc_5 = _loc_5 + 1;
            }
            return this;
        }// end function

        public function toFql() : String
        {
            var _loc_1:* = "select " + this.fields.join(",") + " from " + this.table + " where ";
            switch(this.where.type)
            {
                case "unknown":
                {
                    _loc_1 = _loc_1 + this.where.value;
                    break;
                }
                case "index":
                {
                    _loc_1 = _loc_1 + (this.where.key + "=" + this._encode(this.where.value));
                    break;
                }
                case "in":
                {
                    if (this.where.value.length == 1)
                    {
                        _loc_1 = _loc_1 + (this.where.key + "=" + this._encode(this.where.value[0]));
                    }
                    else
                    {
                        _loc_1 = _loc_1 + (this.where.key + " in (" + FB.arrayMap(this.where.value, this._encode).join(",") + ")");
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function _encode(param1:Object) : String
        {
            return typeof(param1) == "string" ? (FB.stringQuote(param1 + "")) : (param1 + "");
        }// end function

        public function toString() : String
        {
            return "#" + this.name;
        }// end function

        private function _toFields(param1:String) : Array
        {
            return FB.arrayMap(param1.split(","), FB.stringTrim);
        }// end function

        private function _parseWhere(param1:String) : Object
        {
            var _loc_2:* = /^\s*(\w+)\s*=\s*(.*)\s*$""^\s*(\w+)\s*=\s*(.*)\s*$/i.exec(param1);
            var _loc_3:Object = null;
            var _loc_4:* = null;
            var _loc_5:String = "unknown";
            if (_loc_2)
            {
                _loc_4 = _loc_2[2];
                if (/^([""''])(?:\\\?.)*?\1$""^(["'])(?:\\?.)*?\1$/.test(_loc_4))
                {
                    _loc_4 = JSON.deserialize(_loc_4);
                    _loc_5 = "index";
                }
                else if (/^\d+\.?\d*$""^\d+\.?\d*$/.test(_loc_4))
                {
                    _loc_5 = "index";
                }
            }
            if (_loc_5 == "index")
            {
                _loc_3 = {type:"index", key:_loc_2[1], value:_loc_4};
            }
            else
            {
                _loc_3 = {type:"unknown", value:param1};
            }
            return _loc_3;
        }// end function

    }
}
