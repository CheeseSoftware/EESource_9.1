package ui2 
{
    import flash.display.*;
    
    [Embed(source="ui2background.swf", symbol = "ui2.ui2background")]
    public dynamic class ui2background extends flash.display.MovieClip
    {
        public function ui2background()
        {
            super();
            return;
        }

        public var below:flash.display.MovieClip;
    }
}
