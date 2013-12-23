package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    
    [Embed(source="Prompt.swf", symbol = "Prompt")]
    public class Prompt extends flash.display.MovieClip
    {
        public function Prompt(arg1:String, arg2:String, arg3:Function)
        {
            var title:String;
            var dtext:String;
            var callback:Function;

            var loc1:*;
            title = arg1;
            dtext = arg2;
            callback = arg3;
            super();
            this.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
                arg1.stopPropagation();
                return;
            })
            this.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, function (arg1:flash.events.KeyboardEvent):void
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
                arg1.stopPropagation();
                return;
            })
            this.closebtn.addEventListener(flash.events.MouseEvent.CLICK, this.close);
            this.headline.text = title;
            this.inputvar.text = dtext;
            this.inputvar.restrict = "0-9 A-Za-z";
            this.inputvar.maxChars = 20;
            this.savebtn.addEventListener(flash.events.MouseEvent.CLICK, function ():void
            {
                if (inputvar.length >= 4) 
                {
                    callback(inputvar.text);
                    close();
                }
                return;
            })
            return;
        }

        private function close(arg1:flash.events.Event=null):void
        {
            this.parent.removeChild(this);
            return;
        }

        public var inputvar:flash.text.TextField;

        public var headline:flash.text.TextField;

        public var savebtn:flash.display.SimpleButton;

        public var closebtn:flash.display.SimpleButton;
    }
}
