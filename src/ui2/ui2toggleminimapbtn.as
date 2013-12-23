package ui2 
{
    import flash.display.*;
    
    [Embed(source="ui2toggleminimapbtn.swf", symbol = "ui2.ui2toggleminimapbtn")]
    public dynamic class ui2toggleminimapbtn extends flash.display.MovieClip
    {
        public function ui2toggleminimapbtn()
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
