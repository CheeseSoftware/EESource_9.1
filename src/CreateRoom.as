package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    
    [Embed(source="CreateRoom.swf", symbol = "CreateRoom")]
    public class CreateRoom extends flash.display.MovieClip
    {
        public function CreateRoom(arg1:Function, arg2:Function, arg3:Boolean, arg4:Boolean=false)
        {
            var callback:Function;
            var myroom:Function;
            var haveMyRoom:Boolean;
            var isBeta:Boolean=false;

            var loc1:*;
            callback = arg1;
            myroom = arg2;
            haveMyRoom = arg3;
            isBeta = arg4;
            super();
            this.roomname.embedFonts = true;
            this.roomname.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 14);
            this.roomname.restrict = "0-9 A-Za-z";
            this.roomname.maxChars = 25;
            this.roomname.text = ["The", "My", "Our"][Math.random() * 3 >> 0] + [" Awesome", " Cool", " Spectacular", " Pretty", " Wild", " Great", " Fun", ""][Math.random() * 8 >> 0] + [" World", " Creation", " Room", " Area"][Math.random() * 4 >> 0];
            this.editkey.embedFonts = true;
            this.editkey.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 14);
            this.editkey.restrict = "0-9 A-Za-z";
            this.editkey.maxChars = 25;
            this.start.addEventListener(flash.events.MouseEvent.CLICK, function ():void
            {
                if (roomname.text.replace(new RegExp(" ", "gi"), "") != "") 
                {
                    callback(roomname.text, editkey.text, true);
                }
                return;
            })
            this.myworldbtn.visible = haveMyRoom;
            this.mybetaworldbtn.visible = haveMyRoom && isBeta;
            this.myworldbtn.addEventListener(flash.events.MouseEvent.CLICK, function ():void
            {
                myroom(false);
                return;
            })
            this.mybetaworldbtn.addEventListener(flash.events.MouseEvent.CLICK, function ():void
            {
                myroom(true);
                return;
            })
            return;
        }

        public var start:flash.display.SimpleButton;

        public var mybetaworldbtn:flash.display.SimpleButton;

        public var myworldbtn:flash.display.SimpleButton;

        public var editkey:flash.text.TextField;

        public var roomname:flash.text.TextField;
    }
}
