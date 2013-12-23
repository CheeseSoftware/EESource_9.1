package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    
    [Embed(source="Room.swf", symbol = "Room")]
    public class Room extends flash.display.MovieClip
    {
        public function Room(arg1:String, arg2:String, arg3:int, arg4:int, arg5:Boolean, arg6:Function)
        {
            var key:String;
            var title:String;
            var online:int;
            var plays:int;
            var owned:Boolean;
            var callback:Function;
            var tf:flash.text.TextFormat;

            var loc1:*;
            key = arg1;
            title = arg2;
            online = arg3;
            plays = arg4;
            owned = arg5;
            callback = arg6;
            super();
            this.ltitle.embedFonts = true;
            this.ltitle.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 12);
            this.ltitle.text = title;
            this.ltitle.antiAliasType = flash.text.AntiAliasType.ADVANCED;
            this.lonline.antiAliasType = flash.text.AntiAliasType.ADVANCED;
            this.lonline.embedFonts = true;
            this.lonline.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 9, 10066329);
            this.lonline.text = online + " Online - Played by " + this.toScoreFormat(plays) + (plays != 1 ? " people" : " person");
            tf = new flash.text.TextFormat(new system().fontName, 9, 8607744);
            this.lonline.setTextFormat(tf, (online + " Online ").length, this.lonline.text.length);
            if (online == 0) 
            {
                this.lonline.visible = false;
            }
            if (!owned) 
            {
                this.ownedicon.visible = false;
                this.ltitle.x = 6;
            }
            this.full.gotoAndStop(online >= 45 ? 2 : 1);
            addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function ():void
            {
                callback(key, title);
                return;
            })
            return;
        }

        public override function set width(arg1:Number):void
        {
            return;
        }

        private function toScoreFormat(arg1:int):String
        {
            var loc1:*=arg1.toString().split("");
            var loc2:*=0;
            var loc3:*=loc1.length;
            while (loc3 >= 0) 
            {
                if (loc2 > 0 && loc3 > 0 && loc2 % 3 == 0) 
                {
                    loc1.splice(loc3, 0, ["."]);
                }
                ++loc2;
                --loc3;
            }
            return loc1.join("");
        }

        public var lonline:flash.text.TextField;

        public var ownedicon:flash.display.MovieClip;

        public var full:flash.display.MovieClip;

        public var ltitle:flash.text.TextField;
    }
}
