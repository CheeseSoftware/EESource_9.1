package playerio
{

    public interface RoomInfo
    {

        public function RoomInfo();

        function get id() : String;

        function get serverType() : String;

        function get onlineUsers() : int;

        function get data() : Object;

        function toString() : String;

    }
}
