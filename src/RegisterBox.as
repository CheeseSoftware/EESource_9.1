package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="RegisterBox.swf", symbol = "RegisterBox")]
    public dynamic class RegisterBox extends flash.display.MovieClip
    {
        public function RegisterBox()
        {
            super();
            return;
        }

        public var inppassword:flash.text.TextField;

        public var registerbtn:flash.display.SimpleButton;

        public var labelpassword:flash.text.TextField;

        public var labelpassword2:flash.text.TextField;

        public var labelemail:flash.text.TextField;

        public var errors:flash.text.TextField;

        public var inppassword2:flash.text.TextField;

        public var close:flash.display.SimpleButton;

        public var inpemail:flash.text.TextField;
    }
}
