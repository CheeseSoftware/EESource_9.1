package ui2 
{
    import flash.display.*;
    
    [Embed(source="ui2mylevelbtn.swf", symbol = "ui2.ui2mylevelbtn")]
    public dynamic class ui2mylevelbtn extends flash.display.MovieClip
    {
        public function ui2mylevelbtn()
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

        public var clearlevel:flash.display.SimpleButton;

        public var editkey:flash.display.SimpleButton;

        public var editname:flash.display.SimpleButton;

        public var save:flash.display.SimpleButton;

        public var togglemodify:flash.display.SimpleButton;
    }
}
