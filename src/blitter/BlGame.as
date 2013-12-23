package blitter
{
    import flash.display.*;
    import flash.events.*;

    public class BlGame extends MovieClip
    {
        protected var screen:BitmapData;
        protected var screenContainer:Bitmap;
        protected var _state:BlState;

        public function BlGame(param1:int, param2:int, param3:int)
        {
            this.screen = new BitmapData(param1, param2, false, 0);
            this.screenContainer = new Bitmap(this.screen);
            this.screenContainer.width = param1 * param3;
            this.screenContainer.height = param2 * param3;
            addChild(this.screenContainer);
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            Bl.init(stage, width, height);
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.frameRate = 50;
            addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        public function get state() : BlState
        {
            return this._state;
        }// end function

        public function set state(param1:BlState) : void
        {
            this._state = param1;
            Bl.update();
            return;
        }// end function

        protected function handleEnterFrame(event:Event = null) : void
        {
            if (this.state != null)
            {
                this.screen.lock();
                this.screen.fillRect(this.screen.rect, 0);
                Bl.update();
                if (this.state != null)
                {
                    this.state.tick();
                }
                if (this.state != null)
                {
                    this.state.enterFrame();
                }
                Bl.exitFrame();
                if (this.state != null)
                {
                    this.state.exitFrame();
                }
                if (this.state != null)
                {
                    this.state.draw(this.screen, 0, 0);
                }
                this.screen.unlock();
            }
            return;
        }// end function

    }
}
