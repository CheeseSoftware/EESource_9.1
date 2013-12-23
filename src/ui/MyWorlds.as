package ui
{
    import flash.display.*;
    import playerio.*;

    public class MyWorlds extends Sprite
    {
        private var hasbeta:Boolean = false;
        private var isbeta:Boolean = false;
        private var client:Client;
        private var callback:Function;
        private var list:RoomList;

        public function MyWorlds(param1:Client, param2:Boolean, param3:Boolean, param4:Function)
        {
            this.hasbeta = param2;
            this.isbeta = param3;
            this.client = param1;
            this.callback = param4;
            this.render();
            Shop.renderCallback = this.render;
            return;
        }// end function

        private function render() : void
        {
            if (this.list)
            {
            }
            if (this.list.parent)
            {
                removeChild(this.list);
            }
            var rooms:Array;
            if (this.hasbeta)
            {
                rooms.push({id:"savedworld", data:{name:"My Saved Beta World", owned:true}});
                if (this.isbeta)
                {
                    rooms.push({id:"savedbetaworld", data:{name:"My Saved Beta Only world", owned:true}});
                }
            }
            var a:int;
            a;
            while (a < 4)
            {
                
                rooms.push({id:"0x" + a, data:{name:"My small world " + (a + 1), owned:true}});
                a = (a + 1);
            }
            a;
            while (a < 4)
            {
                
                rooms.push({id:"1x" + a, data:{name:"My Medium World " + (a + 1), owned:true}});
                a = (a + 1);
            }
            a;
            while (a < 4)
            {
                
                rooms.push({id:"2x" + a, data:{name:"My Large World " + (a + 1), owned:true}});
                a = (a + 1);
            }
            a;
            while (a < 4)
            {
                
                rooms.push({id:"3x" + a, data:{name:"My Massive World " + (a + 1), owned:true}});
                a = (a + 1);
            }
            a;
            while (a < 4)
            {
                
                rooms.push({id:"4x" + a, data:{name:"My Wide World " + (a + 1), owned:true}});
                a = (a + 1);
            }
            a;
            while (a < 4)
            {
                
                rooms.push({id:"5x" + a, data:{name:"My Great World " + (a + 1), owned:true}});
                a = (a + 1);
            }
            this.list = new RoomList(rooms, 105, function (param1:String, param2:String) : void
            {
                callback(param1);
                return;
            }// end function
            );
            addChild(this.list);
            return;
        }// end function

    }
}
