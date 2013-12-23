package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class loader extends MovieClip
    {

        public function loader()
        {
            var loader:preloader;
            loader = new preloader();
            loader.masker.scaleX = 0;
            loader.x = 17;
            loader.y = 180;
            addChild(loader);
            addEventListener(Event.ENTER_FRAME, function fish(event:Event) : void
            {
                arguments = null;
                if (stage.loaderInfo.bytesTotal != 0)
                {
                    loader.masker.scaleX = stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal;
                    if (stage.loaderInfo.bytesLoaded == stage.loaderInfo.bytesTotal)
                    {
                        removeChild(loader);
                        nextFrame();
                        //arguments = Class(getDefinitionByName("EverybodyEditsBeta"));
						var noob:EverybodyEditsBeta = new EverybodyEditsBeta();
                        //arguments = noob as Class;
						addChild(noob);
                        removeEventListener(Event.ENTER_FRAME, fish);
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

    }
}
