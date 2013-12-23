package ui2 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    [Embed(source="ui2smileyinstance.swf", symbol = "ui2.ui2smileyinstance")]
    public class ui2smileyinstance extends flash.display.MovieClip
    {
        public function ui2smileyinstance(arg1:flash.display.BitmapData, arg2:int, arg3:Object)
        {
            var smileybmd:flash.display.BitmapData;
            var offset:int;
            var ui:Object;
            var bmd:flash.display.BitmapData;
            var bm:flash.display.Bitmap;
            var sp:flash.display.Sprite;

            var loc1:*;
            smileybmd = arg1;
            offset = arg2;
            ui = arg3;
            super();
            bmd = new flash.display.BitmapData(16, 16, true, 0);
            bm = new flash.display.Bitmap(bmd);
            sp = new flash.display.Sprite();
            sp.addChild(bm);
            sp.buttonMode = true;
            sp.useHandCursor = true;
            addChild(sp);
            bmd.copyPixels(smileybmd, new flash.geom.Rectangle(16 * offset, 5, 16, 16 + 5), new flash.geom.Point(0, 0));
            sp.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function ():void
            {
                ui.setSelectedSmiley(offset);
                return;
            })
            sp.addEventListener(flash.events.MouseEvent.MOUSE_UP, function ():void
            {
                ui.setSelectedSmiley(offset);
                return;
            })
            return;
        }
    }
}
