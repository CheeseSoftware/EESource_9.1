package playerio
{

    class SimpleGameFS extends Object implements GameFS
    {
        private var gameId:String;
        private var wo:Object;

        function SimpleGameFS(param1:String, param2:Object)
        {
            this.gameId = param1;
            this.wo = param2;
            return;
        }// end function

        public function getURL(param1:String) : String
        {
            if (param1.substring(0, 1) != "/")
            {
                throw new Error("GameFS paths must be absolute and start with a slash (/). IE PlayerIO.gameFS(\"[gameid]\").getURL(\"/folder/file.extention\")", 0);
            }
            if (this.wo.wrapper)
            {
            }
            if (this.wo.wrapper.content)
            {
            }
            if (this.wo.wrapper.content.hasOwnProperty("getURL"))
            {
                return this.wo.wrapper.content.getURL(this.gameId, param1);
            }
            return "http://r.playerio.com/r/" + this.gameId + param1;
        }// end function

    }
}
