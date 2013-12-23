package ui2 
{
    import flash.display.*;
    
    [Embed(source="ui2godmodebtn.swf", symbol = "ui2.ui2godmodebtn")]
    public dynamic class ui2godmodebtn extends flash.display.MovieClip
    {
        public function ui2godmodebtn()
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
    }
}
