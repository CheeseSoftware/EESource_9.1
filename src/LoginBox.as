package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="LoginBox.swf", symbol = "LoginBox")]
    public dynamic class LoginBox extends flash.display.MovieClip
    {
        public function LoginBox()
        {
            super();
            addFrameScript(0, this.frame1);
            return;
        }

        internal function frame1():*
        {
            stop();
            return;
        }

        public var inppassword:flash.text.TextField;

        public var registerbtn:flash.display.SimpleButton;

        public var labelepassword:flash.text.TextField;

        public var keeplogin:flash.display.MovieClip;

        public var fbbtn:flash.display.SimpleButton;

        public var inpusername:flash.text.TextField;

        public var labelemail:flash.text.TextField;

        public var recoverpass:flash.display.SimpleButton;

        public var guestbtn:flash.display.SimpleButton;

        public var kongloginbtn:flash.display.SimpleButton;

        public var loginbtn:flash.display.SimpleButton;
    }
}
