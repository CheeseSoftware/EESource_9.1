package blitter
{
    import flash.display.*;
    import flash.events.*;

    public class Bl extends Object
    {
        private static var last:Number = 0;
        private static var offset:Number = 0;
        private static var keys:Object = {};
        private static var justPressedKeys:Object = {};
        private static var mouseDown:Boolean = false;
        private static var mouseJustPressed:Boolean = false;
        public static var stage:Stage;
        public static var data:Object = {};
        public static var width:Number;
        public static var height:Number;
        public static var now:Number = new Date().getTime();

        public function Bl()
        {
            return;
        }// end function

        public static function init(param1:Stage, param2:Number, param3:Number) : void
        {
            width = param2;
            height = param3;
            stage = param1;
            stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
            stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
            last = new Date().getTime();
            return;
        }// end function

        public static function update() : void
        {
            now = new Date().getTime();
            offset = now - last;
            last = now;
            return;
        }// end function

        public static function get elapsed() : Number
        {
            return offset < 100 ? (offset) : (100);
        }// end function

        public static function get mouseX() : Number
        {
            return stage.mouseX;
        }// end function

        public static function get mouseY() : Number
        {
            return stage.mouseY;
        }// end function

        public static function get isMouseDown() : Boolean
        {
            return mouseDown;
        }// end function

        public static function get isMouseJustPressed() : Boolean
        {
            return mouseJustPressed;
        }// end function

        public static function isKeyDown(param1:int) : Boolean
        {
            return keys[param1] ? (true) : (false);
        }// end function

        public static function isKeyJustPressed(param1:int) : Boolean
        {
            return justPressedKeys[param1] ? (true) : (false);
        }// end function

        public static function exitFrame() : void
        {
            resetJustPressed();
            return;
        }// end function

        public static function resetJustPressed() : void
        {
            justPressedKeys = {};
            mouseJustPressed = false;
            return;
        }// end function

        static function handleMouseDown(event:MouseEvent) : void
        {
            mouseDown = true;
            mouseJustPressed = true;
            return;
        }// end function

        static function handleMouseUp(event:MouseEvent) : void
        {
            mouseDown = false;
            return;
        }// end function

        static function handleKeyDown(event:KeyboardEvent) : void
        {
            if (!keys[event.keyCode])
            {
                justPressedKeys[event.keyCode] = true;
                keys[event.keyCode] = true;
            }
            return;
        }// end function

        static function handleKeyUp(event:KeyboardEvent) : void
        {
            delete keys[event.keyCode];
            return;
        }// end function

    }
}
