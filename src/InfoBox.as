package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="InfoBox.swf", symbol = "InfoBox")]
    public dynamic class InfoBox extends flash.display.MovieClip
    {
        public function InfoBox()
        {
            super();
            return;
        }

        public var tbody:flash.text.TextField;

        public var ttitle:flash.text.TextField;

        public var closebtn:flash.display.SimpleButton;
    }
}
