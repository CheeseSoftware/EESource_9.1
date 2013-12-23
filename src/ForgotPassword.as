package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="ForgotPassword.swf", symbol = "ForgotPassword")]
    public dynamic class ForgotPassword extends flash.display.MovieClip
    {
        public function ForgotPassword()
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

        public var recoverbtn:flash.display.SimpleButton;

        public var labelemail:flash.text.TextField;

        public var errors:flash.text.TextField;

        public var close:flash.display.SimpleButton;

        public var inpemail:flash.text.TextField;
    }
}
