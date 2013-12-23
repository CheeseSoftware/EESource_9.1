package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    
    [Embed(source="Share.swf", symbol = "Share")]
    public class Share extends flash.display.MovieClip
    {
        public function Share(arg1:String, arg2:String)
        {
            var title:String;
            var dtext:String;

            var loc1:*;
            title = arg1;
            dtext = arg2;
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
            return;
        }

        private function close(arg1:flash.events.Event=null):void
        {
            this.parent.removeChild(this);
            return;
        }

        public var inputvar:flash.text.TextField;

        public var headline:flash.text.TextField;

        public var closebtn:flash.display.SimpleButton;
    }
}
