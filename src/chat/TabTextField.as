package chat
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class TabTextField extends Sprite
    {
        public var field:TextField;
        private var matches:Array;
        private var before:String = "";
        private var after:String = "";
        private var resetText:Boolean = false;
        private var componentHeight:Number;
        private var gw:Function = null;

        public function TabTextField()
        {
            this.field = new TextField();
            this.addChild(this.field);
            this.field.useRichTextClipboard = false;
            this.field.type = TextFieldType.INPUT;
            this.field.multiline = false;
            this.field.maxChars = 80;
            var _loc_1:* = new TextFormat();
            _loc_1.font = "Arial";
            _loc_1.color = 0;
            _loc_1.size = 12;
            this.field.defaultTextFormat = _loc_1;
            this.componentHeight = this.field.height;
            this.realign();
            this.field.width = 20;
            this.field.height = this.field.textHeight + 5;
            this.field.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.handleTabRequest);
            this.field.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
            this.field.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
            this.field.text = "";
            this.matches = null;
            return;
        }// end function

        private function get checkWords() : Object
        {
            return this.gw != null ? (this.gw()) : ({});
        }// end function

        public function SetWordFunction(param1:Function) : void
        {
            this.gw = param1;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.field.width = param1;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this.componentHeight = param1;
            this.realign();
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this.field.text = param1;
            return;
        }// end function

        public function get text() : String
        {
            return this.field.text;
        }// end function

        private function realign() : void
        {
            this.field.y = (this.componentHeight - this.field.height) / 2;
            return;
        }// end function

        private function handleTabRequest(event:Event) : void
        {
            var _loc_2:String = null;
            var _loc_3:Object = null;
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            event.preventDefault();
            if (!this.matches)
            {
                _loc_2 = this.field.text;
                _loc_3 = this.getCaretWord();
                if (_loc_3.text != "")
                {
                    this.matches = this.getWordlist(_loc_3.text);
                    this.matches.sortOn("weight", Array.NUMERIC | Array.DESCENDING);
                    this.before = _loc_2.substring(0, _loc_3.start);
                    this.after = _loc_2.substring(_loc_3.end);
                }
            }
            if (this.matches)
            {
            }
            if (this.matches.length > 0)
            {
                _loc_4 = this.after.replace(/\W""\W/g, "");
                _loc_5 = _loc_4 == "" ? (this.before == "" ? (": " + this.after) : (" " + this.after)) : (this.after);
                this.field.text = this.before + this.matches[0].word + _loc_5;
                _loc_6 = this.matches[0].word.length + this.before.length + _loc_5.length;
                if (this.matches.length > 1)
                {
                    this.field.setSelection(this.field.selectionBeginIndex, _loc_6);
                }
                else
                {
                    _loc_7 = _loc_6;
                    this.field.setSelection(_loc_7, _loc_7);
                }
                this.matches.push(this.matches.shift());
            }
            return;
        }// end function

        private function handleKeyDown(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case 9:
                {
                    break;
                }
                case 32:
                {
                    this.doMatch();
                    break;
                }
                default:
                {
                    this.matches = null;
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function doMatch() : void
        {
            var _loc_1:String = null;
            if (this.matches != null)
            {
            }
            if (this.matches.length > 0)
            {
            }
            if (this.field.selectionBeginIndex != this.field.selectionEndIndex)
            {
                _loc_1 = this.field.text;
                this.field.type = TextFieldType.DYNAMIC;
                this.resetText = true;
            }
            this.matches = null;
            return;
        }// end function

        private function handleKeyUp(event:KeyboardEvent) : void
        {
            if (this.resetText)
            {
                this.field.type = TextFieldType.INPUT;
                this.field.setSelection((this.field.selectionEndIndex + 1), (this.field.selectionEndIndex + 1));
            }
            this.resetText = false;
            return;
        }// end function

        private function getWordlist(param1:String) : Array
        {
            var _loc_3:String = null;
            var _loc_2:Array = [];
            for (_loc_3 in this.checkWords)
            {
                
                if (_loc_3.toLowerCase().indexOf(param1.toLowerCase()) == 0)
                {
                    _loc_2.push({word:_loc_3, weight:this.checkWords[_loc_3]});
                }
            }
            return _loc_2;
        }// end function

        private function getCaretWord() : Object
        {
            var _loc_1:* = this.field.text;
            var _loc_2:* = this.field.caretIndex;
            var _loc_3:* = this.field.caretIndex;
            var _loc_4:Object = {};
            _loc_4[" "] = true;
            _loc_4["\n"] = true;
            _loc_4["\t"] = true;
            _loc_4[String.fromCharCode(13)] = true;
            do
            {
                
                _loc_2 = _loc_2 - 1;
                if ((_loc_2 - 1) >= 0)
                {
                }
            }while (!_loc_4[_loc_1.charAt((_loc_2 - 1))])
            do
            {
                
                _loc_3 = _loc_3 + 1;
                if (_loc_3 < _loc_1.length)
                {
                }
            }while (!_loc_4[_loc_1.charAt(_loc_3)])
            return {end:_loc_3, start:_loc_2, text:_loc_1.substring(_loc_2, _loc_3)};
        }// end function

    }
}
