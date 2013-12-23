package sample.ui.components.scroll
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import sample.ui.components.*;

    public class ScrollButton extends SampleButton
    {

        public function ScrollButton(param1:int = 0, param2:int = 10, param3:Function = null)
        {
            var direction:* = param1;
            var size:* = param2;
            var clickHandler:* = param3;
            this.upState = new Box().margin(0, 0, 0, 0).fill(0, 1, 3).minSize(size, size).add(new Box().add(this.drawArrow(16777215, size / 3, direction)));
            this.downState = new Box().margin(0, 0, 0, 0).fill(16777215, 1, 3).minSize(size, size).add(new Box().add(this.drawArrow(8947848, size / 3, direction)));
            this.overState = new Box().margin(0, 0, 0, 0).fill(16777215, 1, 3).minSize(size, size).add(new Box().add(this.drawArrow(0, size / 3, direction)));
            this.hitTestState = new Box().margin(0, 0, 0, 0).fill(0, 1, 3).minSize(size, size).add(new Box().add(this.drawArrow(16777215, size / 3, direction)));
            if (clickHandler != null)
            {
                this.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                var i:Number;
                var e:* = event;
                clickHandler();
                var n:int;
                i = setInterval(function () : void
                {
                    if (e.target.upState.parent)
                    {
                        clearInterval(i);
                        return;
                    }
                    if (e.target.downState.parent)
                    {
                    }
                    if (n++ > 5)
                    {
                        clickHandler();
                    }
                    return;
                }// end function
                , 50);
                e.target.addEventListener(MouseEvent.MOUSE_UP, function (event:MouseEvent) : void
                {
                    clearInterval(i);
                    event.target.removeEventListener(MouseEvent.MOUSE_UP, arguments.callee);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function drawArrow(param1:int, param2:int, param3:int = 0) : Sprite
        {
            var _loc_4:* = new Sprite();
            var _loc_5:* = _loc_4.graphics;
            var _loc_6:* = Math.PI / 2 * param3;
            _loc_5.beginFill(param1, 1);
            _loc_5.moveTo(Math.cos(2.0943 - _loc_6) * param2 + param2, Math.sin(2.0943 - _loc_6) * param2 + param2);
            _loc_5.lineTo(Math.cos(4.18879 - _loc_6) * param2 + param2, Math.sin(4.18879 - _loc_6) * param2 + param2);
            _loc_5.lineTo(Math.cos(-_loc_6) * param2 + param2, Math.sin(-_loc_6) * param2 + param2);
            return _loc_4;
        }// end function

    }
}
