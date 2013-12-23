package ui2 
{
    import flash.display.*;
    
    [Embed(source="ui2chatbtn.swf", symbol = "ui2.ui2chatbtn")]
    public dynamic class ui2chatbtn extends flash.display.MovieClip
    {
        public function ui2chatbtn()
        {
            super();
            addFrameScript(0, this.frame1);
            return;
        }

        function frame1():*
        {
            stop();
            return;
        }

        public var btn:flash.display.SimpleButton;
    }
}
