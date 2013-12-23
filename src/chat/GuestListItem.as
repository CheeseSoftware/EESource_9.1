package chat
{
    import blitter.*;
    import flash.display.*;
    import sample.ui.components.*;

    public class GuestListItem extends Box
    {
        private var tf:BlText;
        private var bm:Bitmap;

        public function GuestListItem()
        {
            this.tf = new BlText(14, 180, 8947848, "left", "visitor");
            margin(NaN, NaN, NaN, 2);
            minSize(200, 10);
            return;
        }// end function

        public function set online(param1:int) : void
        {
            if (this.bm)
            {
                removeChild(this.bm);
                this.bm.bitmapData.dispose();
                this.bm = null;
            }
            this.tf.text = param1 + (param1 == 1 ? (" Guest online") : (" Guests online"));
            this.bm = new Bitmap(this.tf.clone());
            addChild(this.bm);
            minSize(180, 10);
            return;
        }// end function

    }
}
