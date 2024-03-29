package 
{
    import flash.display.*;
    import sample.ui.components.scroll.*;
    
    [Embed(source="RoomList.swf", symbol = "RoomList")]
    public class RoomList extends flash.display.MovieClip
    {
        public function RoomList(arg1:Array, arg2:int, arg3:Function)
        {
            var rooms:Array;
            var h:int;
            var callback:Function;

            var loc1:*;
            rooms = arg1;
            h = arg2;
            callback = arg3;
            this.container = new flash.display.Sprite();
            this.rooms = [];
            super();
            this.base = new sample.ui.components.scroll.ScrollBox().margin(1, 1, 1, 1).add(this.container);
            addChild(this.base);
            this.rooms = rooms;
            this.callback = callback;
            rooms.sort(function (arg1:Object, arg2:Object):*
            {
                var loc3:*=null;
                var loc4:*=null;
                var loc1:*=arg1.onlineUsers >= 40 ? 0 : arg1.onlineUsers;
                var loc2:*=arg2.onlineUsers >= 40 ? 0 : arg2.onlineUsers;
                if (loc1 == loc2) 
                {
                    loc3 = arg1.data.name || arg1.id;
                    loc4 = arg2.data.name || arg2.id;
                    return loc3 > loc4 ? -1 : 1;
                }
                return loc1 > loc2 ? -1 : 1;
            })
            this.render();
            this.base.width = 301 - 3;
            this.base.height = h - 3;
            this.base.y = 2;
            this.bg.height = h + 1;
            return;
        }

        public function render(arg1:String=""):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (this.history == arg1) 
            {
                return;
            }
            this.history = arg1;
            while (this.container.numChildren) 
            {
                this.container.removeChild(this.container.getChildAt(0));
            }
            var loc1:*=0;
            var loc2:*=0;
            while (loc2 < this.rooms.length) 
            {
                loc3 = this.rooms[loc2];
                loc4 = loc3.data.name || loc3.id;
                if ((arg1 == "" || !(loc4.toLocaleLowerCase().indexOf(arg1.toLocaleLowerCase()) == -1)) && !this.containsBadwords(loc4)) 
                {
                    loc5 = new Room(loc3.id, this.makePrettyName(loc4), loc3.onlineUsers, parseInt(loc3.data.plays) || 1, loc3.data.owned, this.callback);
                    loc5.y = loc1 * (loc5.height + 2);
                    ++loc1;
                    this.container.addChild(loc5);
                }
                ++loc2;
            }
            if (loc1 == 0) 
            {
                this.container.addChild(new norooms());
            }
            this.base.scrollY = 1;
            return;
        }

        private function containsBadwords(arg1:String):Boolean
        {
            arg1 = arg1.split(" ").join("").toLocaleLowerCase();
            var loc1:*=["hitler", "sex", "dick", "fuck", "nazi", "gay", "nigger", "bitch", "homo"];
            var loc2:*=0;
            while (loc2 < loc1.length) 
            {
                if (arg1.indexOf(loc1[loc2]) != -1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        private function makePrettyName(arg1:String):String
        {
            return arg1.replace(new RegExp("[ |\\t]{2,}", "gi"), " ");
        }

        public var bg:flash.display.MovieClip;

        private var container:flash.display.Sprite;

        private var rooms:Array;

        private var callback:Function;

        private var base:sample.ui.components.scroll.ScrollBox;

        private var history:String="notsettosomething";
    }
}
