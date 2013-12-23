package ui2 
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    
    [Embed(source="ui2smileyselector.swf", symbol = "ui2.ui2smileyselector")]
    public class ui2smileyselector extends flash.display.MovieClip
    {
        public function ui2smileyselector()
        {
            this.smilies = [];
            this.masker = new flash.display.Sprite();
            this.bg = new flash.display.Sprite();
            this.selected = new flash.display.Bitmap(new ui2.ui2selector());
            super();
            addEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleAttach);
            addChild(this.bg);
            addChild(this.masker);
            this.mask = this.masker;
            this.bg.filters = [new flash.filters.DropShadowFilter(0, 45, 0, 1, 4, 4, 1, 3)];
            return;
        }

        public function addSmiley(arg1:ui2.ui2smileyinstance, arg2:int):void
        {
            this.smilies[arg2] = arg1;
            addChild(arg1);
            addChild(this.selected);
            this.redraw();
            return;
        }

        public override function get width():Number
        {
            return this.basiswidth;
        }

        public function setSelectedSmiley(arg1:int):void
        {
			if(this.smilies[arg1])
			{
            this.selected.x = this.smilies[arg1].x;
            this.selected.y = this.smilies[arg1].y;
			
			}
            return;
        }

        private function redraw():void
        {
            var loc1:*=5;
            var loc2:*=5;
            var loc3:*=0;
            while (loc3 < this.smilies.length) 
            {
                if (this.smilies[loc3]) 
                {
                    if (loc1 + this.smilies[loc3].width + 5 >= this.basiswidth) 
                    {
                        loc1 = 5;
                        loc2 = loc2 + 18;
                    }
                    this.smilies[loc3].x = loc1;
                    this.smilies[loc3].y = loc2;
                    loc1 = loc1 + (this.smilies[loc3].width + 2);
                }
                ++loc3;
            }
            loc2 = loc2 + 18;
            var loc4:*=this.bg.graphics;
            loc4.clear();
            loc4.lineStyle(1, 8092539, 1);
            loc4.beginFill(3289649, 0.85);
            loc4.drawRect(0, 0, this.basiswidth, loc2 + 5);
            this.y = -loc2 - 35;
            var loc5:*=this.masker.graphics;
            loc5.clear();
            loc5.beginFill(16777215, 1);
            loc5.drawRect(-5, -5, this.basiswidth + 1 + 10, loc2 + 10);
            return;
        }

        private function handleAttach(arg1:flash.events.Event):void
        {
            this.redraw();
            return;
        }

        private var smilies:Array;

        private var basiswidth:int=117;

        private var masker:flash.display.Sprite;

        private var bg:flash.display.Sprite;

        private var selected:flash.display.Bitmap;
    }
}
