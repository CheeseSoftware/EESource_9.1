package sample.ui.components
{
    import flash.display.*;
    import flash.events.*;

    public class SampleButton extends SimpleButton
    {
        protected var _width:Number;
        protected var _height:Number;
        protected var _clickHandler:Function;

        public function SampleButton(param1:Function = null)
        {
            var clickHandler:* = param1;
            this._clickHandler = function () : void
            {
                if (clickHandler != null)
                {
                    clickHandler();
                }
                return;
            }// end function
            ;
            if (this._clickHandler != null)
            {
                addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
                addEventListener(Event.REMOVED_FROM_STAGE, this.handleDetatch);
            }
            this.redraw();
            return;
        }// end function

        public function handleAttach(event:Event) : void
        {
            addEventListener(MouseEvent.CLICK, this._clickHandler);
            return;
        }// end function

        public function handleDetatch(event:Event) : void
        {
            removeEventListener(MouseEvent.CLICK, this._clickHandler);
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._width = param1;
            this.redraw();
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._height = param1;
            this.redraw();
            return;
        }// end function

        protected function redraw() : void
        {
            if (this.upState)
            {
                this.upState.width = this._width;
                this.upState.height = this._height;
            }
            if (this.downState)
            {
                this.downState.width = this._width;
                this.downState.height = this._height;
            }
            if (this.overState)
            {
                this.overState.width = this._width;
                this.overState.height = this._height;
            }
            if (this.hitTestState)
            {
                this.hitTestState.width = this._width;
                this.hitTestState.height = this._height;
            }
            return;
        }// end function

    }
}
