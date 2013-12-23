package chat
{
    import flash.display.*;
    
    import playerio.*;
    
    import sample.ui.components.*;
    import sample.ui.components.scroll.*;

    public class SideChat extends Sprite
    {
        protected var CHATBG:Class;
        private var ucontainer:Rows;
        private var userlist:ScrollBox;
        private var ccontainer:Rows;
        private var chatbox:ScrollBox;
        private var guestItem:GuestListItem;
        private var myname:String = "";
        private var chats:Array;
        private var users:Object;
        private var names:Object;
        private var guests:Object;

        public function SideChat(param1:Connection)
        {
            var c:* = param1;
            this.CHATBG = SideChat_CHATBG;
            this.ucontainer = new Rows().spacing(0);
            this.ccontainer = new Rows().spacing(0);
            this.guestItem = new GuestListItem();
            this.chats = [];
            this.users = {};
            this.names = {};
            this.guests = {};
            c.addMessageHandler("add", function (param1:Message, param2:int, param3:String, param4:int, param5:Number, param6:Number, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false) : void
            {
                if (param3.indexOf(" ") == -1)
                {
                    addUser(param2.toString(), param3, param9);
                }
                else
                {
                    addGuest(param2.toString());
                }
                return;
            }// end function
            );
            c.addMessageHandler("left", function (param1:Message, param2:int) : void
            {
                removeUser(param2.toString());
                removeGuest(param2.toString());
                return;
            }// end function
            );
            c.addMessageHandler("say", function (param1:Message, param2:int, param3:String) : void
            {
                addChat(param2.toString(), param3);
                return;
            }// end function
            );
            c.addMessageHandler("write", function (param1:Message, param2:String, param3:String) : void
            {
                addLine(param2, param3);
                return;
            }// end function
            );
            addChild(DisplayObject(new Bitmap(new this.CHATBG())));
            this.userlist = new ScrollBox().margin(1, 1, 1, 1).add(this.ucontainer);
            this.userlist.border(1, 1118481, 1);
            this.userlist.width = 205;
            this.userlist.height = 150;
            this.userlist.x = 3;
            addChild(this.userlist);
            this.chatbox = new ScrollBox().margin(1, 1, 1, 1).add(this.ccontainer);
            this.chatbox.border(1, 1118481, 1);
            this.chatbox.width = 205;
            this.chatbox.height = 347;
            this.chatbox.x = 3;
            this.chatbox.y = 152;
            addChild(this.chatbox);
            this.ucontainer.addChild(this.guestItem);
            this.guestItem.online = 0;
            return;
        }// end function

        public function setMe(param1:String, param2:String, param3:Boolean) : void
        {
            this.myname = param2;
            this.addUser(param1, param2, param3);
            this.redrawUserlist();
            return;
        }// end function

        public function addChat(param1:String, param2:String) : void
        {
            if (this.users[param1])
            {
                this.addLine(this.users[param1].username, param2);
            }
            return;
        }// end function

        public function addLine(param1:String, param2:String) : void
        {
            var _loc_5:Number = NaN;
            param2 = Chat.filter(param2);
            var _loc_3:* = (" " + param2 + " ").replace(/[^a-z0-9 ]""[^a-z0-9 ]/gi, "").toLowerCase().indexOf(" " + this.myname.toLowerCase() + " ") != -1;
            var _loc_4:* = this.chatbox.scrollHeight - this.chatbox.scrollY < 50;
            this.ccontainer.addChild(new ChatEntry(param1, param2, _loc_3 ? (2236962) : (0)));
            if (this.ccontainer.numChildren > 50)
            {
                _loc_5 = this.chatbox.scrollHeight;
                this.ccontainer.removeChild(this.ccontainer.getChildAt(0));
                if (!_loc_4)
                {
                    this.chatbox.refresh();
                    this.chatbox.scrollY = this.chatbox.scrollY + (this.chatbox.scrollHeight - _loc_5);
                }
            }
            this.chatbox.refresh();
            if (_loc_4)
            {
                this.chatbox.scrollY = 100000;
            }
            return;
        }// end function

        public function addUser(param1:String, param2:String, param3:Boolean) : void
        {
            var _loc_4:UserlistItem = null;
            if (this.names[param2] == null)
            {
                _loc_4 = new UserlistItem(param2, param3);
                this.names[param2] = _loc_4;
                this.ucontainer.addChild(_loc_4);
            }
            this.users[param1] = this.names[param2];
            var _loc_5:* = this.names[param2];
            var _loc_6:* = this.names[param2].count + 1;
            _loc_5.count = _loc_6;
            this.redrawUserlist();
            return;
        }// end function

        public function getUsers() : Object
        {
            var _loc_2:String = null;
            var _loc_1:Object = {};
            for (_loc_2 in this.names)
            {
                
                _loc_1[_loc_2.toUpperCase()] = true;
            }
            return _loc_1;
        }// end function

        public function removeUser(param1:String) : void
        {
            if (this.users[param1])
            {
                var _loc_2:* = this.users[param1];
                _loc_2.count = this.users[param1].count - 1;
                if (--this.users[param1].count == 0)
                {
                    delete this.names[this.users[param1].username];
                    this.ucontainer.removeChild(this.users[param1]);
                }
                delete this.users[param1];
                this.redrawUserlist();
            }
            return;
        }// end function

        private function redrawUserlist() : void
        {
            var x:String;
            var a:int;
            var tusers:Array = new Array();
            var _loc_2:int = 0;
            var _loc_3:* = this.users;
            while (_loc_3 in _loc_2)
            {
                
                x = _loc_3[_loc_2];
                tusers.push(this.users[x]);
				
            }
            tusers.sort(function (param1:UserlistItem, param2:UserlistItem) : Number
            {
                if (param1.canchat)
                {
                }
                if (!param2.canchat)
                {
                    return -1;
                }
                if (!param1.canchat)
                {
                }
                if (param2.canchat)
                {
                    return 1;
                }
                if (param1.canchat == param2.canchat)
                {
                    return param1.time < param2.time ? (1) : (-1);
                }
                return 0;
            }// end function
            );
            a;
            while (a < tusers.length)
            {
                
                this.ucontainer.addChild(tusers[a]);
                a = (a + 1);
            }
            this.ucontainer.addChild(this.guestItem);
            this.userlist.scrollY = this.userlist.scrollY;
            return;
        }// end function

        public function addGuest(param1:String) : void
        {
            if (!this.guests[param1])
            {
                this.guests[param1] = true;
            }
            this.refreshGuest();
            return;
        }// end function

        public function removeGuest(param1:String) : void
        {
            if (this.guests[param1])
            {
                delete this.guests[param1];
            }
            this.refreshGuest();
            return;
        }// end function

        private function refreshGuest() : void
        {
            var _loc_2:Boolean = false;
            var _loc_1:int = 0;
            for each (_loc_2 in this.guests)
            {
                
                _loc_1 = _loc_1 + 1;
            }
            this.guestItem.online = _loc_1;
            return;
        }// end function

    }
}
