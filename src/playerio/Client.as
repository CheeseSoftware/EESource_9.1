package playerio
{
    import flash.display.*;

    public interface Client
    {

        public function Client();

        function get connectUserId() : String;

        function get payVault() : PayVault;

        function get gameFS() : GameFS;

        function get bigDB() : BigDB;

        function get errorLog() : ErrorLog;

        function get multiplayer() : Multiplayer;

        function get stage() : Stage;

    }
}
