package playerio
{

    public interface Connection
    {

        public function Connection();

        function addMessageHandler(param1:String, param2:Function) : void;

        function removeMessageHandler(param1:String, param2:Function) : void;

        function addDisconnectHandler(param1:Function) : void;

        function removeDisconnectHandler(param1:Function) : void;

        function get connected() : Boolean;

        function createMessage(param1:String, ... args) : Message;

        function send(param1:String, ... args) : void;

        function sendMessage(param1:Message) : void;

        function disconnect() : void;

    }
}
