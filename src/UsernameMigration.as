package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="UsernameMigration.swf", symbol = "UsernameMigration")]
    public dynamic class UsernameMigration extends flash.display.MovieClip
    {
        public function UsernameMigration()
        {
            super();
            return;
        }

        public var inputvar:flash.text.TextField;

        public var sendbtn:flash.display.SimpleButton;

        public var headline:flash.text.TextField;

        public var errortext:flash.text.TextField;
    }
}
