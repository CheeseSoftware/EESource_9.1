package 
{
    import Shop.*;
    import blitter.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import playerio.*;
    import sample.ui.components.scroll.*;

    public class Shop extends Object
    {
        private static var refreshed:Boolean = false;
        private static var base:EverybodyEditsBeta;
        private static var refreshDate:Number = 0;
        private static var _energy:int = 0;
        private static var _timeToEnergy:int = 0;
        private static var _totalEnergy:int = 0;
        private static var _secoundsBetweenEnergy:int = 0;
        private static var _gems:int = 0;
        private static var shopItems:Array;
        private static var client:Client;
        private static var classes:Object = {brickfactorypack:brickfactorypack, smileycoy:smileycoy, brickblackblock:brickblackblock, world5:world5, brickcoindoor:brickcoindoor, mixednewyear2010:mixednewyear2010, pro:pro, world0:world0, world1:world1, world2:world2, world3:world3, world4:world4, smileysupprice:smileysupprice, smileygirl:smileygirl, brickchristmas2010:brickchristmas2010, smileysupprice:smileysupprice, brickspawn:brickspawn, smileyninja:smileyninja, smileysanta:smileysanta, smileyworker:smileyworker, smileybigspender:smileybigspender};
        private static var target:ShopContainer = new ShopContainer();
        private static var box:ScrollBox = new ScrollBox().margin(1, 1, 1, 1).add(target);
        public static var renderCallback:Function;
        private static var shopRef:GetGemsNow = null;

        public function Shop()
        {
            return;
        }// end function

        public static function setBase(param1:EverybodyEditsBeta, param2:Client) : void
        {
            base = param1;
            client = param2;
            return;
        }// end function

        public static function refresh(param1:Function) : void
        {
            var callback:* = param1;
            if (client.connectUserId == "simpleguest")
            {
                callback();
            }
            else
            {
                base.requestRemoteMethod("getShop", function (param1:Message) : void
            {
                update(param1);
                callback();
                return;
            }// end function
            );
            }
            return;
        }// end function

        private static function update(param1:Message) : void
        {
            refreshed = true;
            refreshDate = new Date().getTime();
            shopItems = [];
            _energy = param1.getInt(0);
            _timeToEnergy = param1.getInt(1);
            _totalEnergy = param1.getInt(2);
            _secoundsBetweenEnergy = param1.getInt(3);
            _gems = param1.getInt(4);
            var _loc_2:int = 5;
            while (_loc_2 < param1.length)
            {
                
                shopItems.push({id:param1.getString(_loc_2), totalEnergyCost:param1.getInt((_loc_2 + 1)), costPerClick:param1.getString(_loc_2 + 2), energyUsed:param1.getString(_loc_2 + 3), totalGemCost:param1.getString(_loc_2 + 4), count:param1.getString(_loc_2 + 5)});
                _loc_2 = _loc_2 + 6;
            }
            return;
        }// end function

        public static function useEnergy(param1:String, param2:Function) : void
        {
            var target:* = param1;
            var callback:* = param2;
            base.requestRemoteMethod("useEnergy", function (param1:Message) : void
            {
                var m:* = param1;
                if (m.getString(0) == "error")
                {
                    base.showInfo("Not enough energy!", "You do not have enough energy to upgrade this item at this time.\n\nBut remember that you always get one free energy every two minute and thirty secounds, even when you are not online!\n\nSo play a few levels or take a quick nap and you should have enough energy again!");
                    callback();
                }
                else
                {
                    update(m);
                    callback();
                }
                return;
            }// end function
            , target);
            return;
        }// end function

        public static function useGems(param1:String, param2:Function) : void
        {
            var target:* = param1;
            var callback:* = param2;
            base.requestRemoteMethod("useGems", function (param1:Message) : void
            {
                var m:* = param1;
                if (m.getString(0) == "error")
                {
                    getMoreGems();
                    callback();
                }
                else
                {
                    refresh(callback);
                    callback();
                }
                return;
            }// end function
            , target);
            return;
        }// end function

        public static function get energy() : int
        {
            if (!refreshed)
            {
                throw new Error("You cannot call the shop without refreshing it first");
            }
            var _loc_1:* = _energy;
            var _loc_2:* = new Date().getTime() - refreshDate;
            var _loc_3:* = _timeToEnergy - _loc_2 / 1000;
            while (_loc_3 < 0)
            {
                
                _loc_3 = _loc_3 + _secoundsBetweenEnergy;
                _loc_1 = _loc_1 + 1;
            }
            return Math.min(_totalEnergy, _loc_1);
        }// end function

        public static function get gems() : int
        {
            if (!refreshed)
            {
                throw new Error("You cannot call the shop without refreshing it first");
            }
            return _gems;
        }// end function

        public static function get totalEnergy() : int
        {
            if (!refreshed)
            {
                throw new Error("You cannot call the shop without refreshing it first");
            }
            return _totalEnergy;
        }// end function

        public static function get prettyTimeToNext() : String
        {
            if (!refreshed)
            {
                throw new Error("You cannot call the shop without refreshing it first");
            }
            var _loc_1:* = new Date().getTime() - refreshDate;
            var _loc_2:* = _timeToEnergy - _loc_1 / 1000;
            while (_loc_2 < 0)
            {
                
                _loc_2 = _loc_2 + _secoundsBetweenEnergy;
            }
            var _loc_3:* = Math.floor(_loc_2 / 60);
            var _loc_4:* = Math.floor(_loc_2 - _loc_3 * 60);
            return _loc_3 + ":" + (_loc_4 < 10 ? ("0" + _loc_4) : (_loc_4));
        }// end function

        public static function renderShopItems(param1:DisplayObjectContainer) : void
        {
            var cc:canchat;
            var item:Object;
            var ne:*;
            var t2:* = param1;
            if (!refreshed)
            {
                throw new Error("You cannot call the shop without refreshing it first");
            }
            var s:* = box.scrollY;
            while (target.numChildren != 0)
            {
                
                target.removeChildAt(0);
            }
            if (renderCallback != null)
            {
                renderCallback();
            }
            box.refresh();
            var top:int;
            if (!Bl.data.canchat)
            {
            }
            if (!Bl.data.chatbanned)
            {
                cc = new canchat();
                target.addChild(cc);
                cc.verifybtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                var conf:VerifyAge;
                conf = new VerifyAge();
                Bl.stage.addChild(conf);
                conf.closebtn.addEventListener(MouseEvent.CLICK, function () : void
                {
                    Bl.stage.removeChild(conf);
                    return;
                }// end function
                );
                conf.verifybtn.addEventListener(MouseEvent.CLICK, function () : void
                {
                    conf.verifybtn.visible = false;
                    var paypalargs:Object;
                    paypalargs["return"] = "http://beta.everybodyedits.com/";
                    return;
                }// end function
                );
                return;
            }// end function
            );
                top = cc.height + 10;
            }
            var a:int;
            while (a < shopItems.length)
            {
                
                item = shopItems[a];
                if (classes[item.id] != null)
                {
                    if (item.id == "pro")
                    {
                    }
                    if (Bl.data.iskongregate)
                    {
                    }
                    else
                    {
                        if (item.id == "pro")
                        {
                        }
                        if (Bl.data.hasbeta)
                        {
                        }
                        else
                        {
                            ne = new classes[item.id];
                            ne.gembuttontext.mouseEnabled = false;
                            ne.y = top;
                            attachShopListeners(item, ne, t2);
                            ne.gembuttontext.text = "Get now for " + item.totalGemCost + " gems";
                            top = top + (ne.height + 10);
                            target.addChild(ne);
                            if (item.count > 0)
                            {
                                if (item.id == "brickcoindoor")
                                {
                                    ne.count.text = "(You have " + item.count * 10 + ")";
                                }
                                else
                                {
                                    ne.count.text = "(You have " + item.count + ")";
                                }
                            }
                            if (item.totalEnergyCost > 0)
                            {
                                ne.buttontext.text = "Add " + item.costPerClick + " energy now";
                                ne.progressbartext.text = item.energyUsed + "/" + item.totalEnergyCost;
                                ne.progressbar.masker.scaleX = item.energyUsed / item.totalEnergyCost;
                                ne.buttontext.mouseEnabled = false;
                            }
                        }
                    }
                }
                a = (a + 1);
            }
            t2.addChild(box);
            box.width = 600;
            box.height = 400;
            box.refresh();
            box.scrollY = s;
            return;
        }// end function

        private static function attachShopListeners(param1:Object, param2, param3) : void
        {
            var item:* = param1;
            var target:* = param2;
            var base:* = param3;
            if (item.totalEnergyCost > 0)
            {
                target.useenergy.addEventListener(MouseEvent.CLICK, function () : void
            {
                target.useenergy.visible = false;
                target.buttontext.visible = false;
                useEnergy(item.id, function () : void
                {
                    renderShopItems(base);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            }
            target.usegems.addEventListener(MouseEvent.CLICK, function () : void
            {
                target.usegems.visible = false;
                target.gembuttontext.visible = false;
                useGems(item.id, function () : void
                {
                    renderShopItems(base);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        public static function getMoreGems() : void
        {
            var gs:GetGemsNow;
            var close:Function;
            var paypalargs:Object;
            close = function (event:MouseEvent = null) : void
            {
                if (gs.parent)
                {
                    gs.parent.removeChild(gs);
                }
                shopRef = null;
                return;
            }// end function
            ;
            gs = new GetGemsNow();
            gs.closebtn.addEventListener(MouseEvent.CLICK, close);
            gs.stop();
            if (Bl.data.iskongregate)
            {
                gs.gotoAndStop(2);
                gs.kreds1.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(5, close);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                gs.kreds5.visible = _loc_1;
                gs.kreds4.visible = _loc_1;
                gs.kreds3.visible = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
                gs.kreds2.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(10, close);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                gs.kreds5.visible = _loc_1;
                gs.kreds4.visible = _loc_1;
                gs.kreds3.visible = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
                gs.kreds3.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(20, close);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                gs.kreds5.visible = _loc_1;
                gs.kreds4.visible = _loc_1;
                gs.kreds3.visible = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
                gs.kreds4.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(50, close);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                gs.kreds5.visible = _loc_1;
                gs.kreds4.visible = _loc_1;
                gs.kreds3.visible = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
                gs.kreds5.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(100, close);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                gs.kreds5.visible = _loc_1;
                gs.kreds4.visible = _loc_1;
                gs.kreds3.visible = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
                gs.kreds6.addEventListener(MouseEvent.CLICK, function () : void
            {
                base.buyGemsWithKongregate(200, close);
                var _loc_1:Boolean = false;
                gs.kreds6.visible = false;
                gs.kreds5.visible = _loc_1;
                gs.kreds4.visible = _loc_1;
                gs.kreds3.visible = _loc_1;
                gs.kreds2.visible = _loc_1;
                gs.kreds1.visible = _loc_1;
                return;
            }// end function
            );
            }
            else
            {
                paypalargs;
                paypalargs["return"] = "http://beta.everybodyedits.com/";
                gs.buybtn1.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "5";
                paypalargs["item_name"] = "5 Everybody Edits Gems";
                gs.buybtn1.visible = false;
                return;
            }// end function
            );
                gs.buybtn2.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "15";
                paypalargs["item_name"] = "15 Everybody Edits Gems";
                gs.buybtn2.visible = false;
                return;
            }// end function
            );
                gs.buybtn3.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "50";
                paypalargs["item_name"] = "50 Everybody Edits Gems";
                gs.buybtn3.visible = false;
                return;
            }// end function
            );
                gs.buybtn4.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "110";
                paypalargs["item_name"] = "110 Everybody Edits Gems";
                gs.buybtn4.visible = false;
                return;
            }// end function
            );
                gs.buybtn5.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "240";
                paypalargs["item_name"] = "240 Everybody Edits Gems";
                gs.buybtn5.visible = false;
                return;
            }// end function
            );
                gs.buybtn6.addEventListener(MouseEvent.CLICK, function () : void
            {
                paypalargs["coinamount"] = "650";
                paypalargs["item_name"] = "650 Everybody Edits Gems";
                gs.buybtn6.visible = false;
                return;
            }// end function
            );
                gs.srbtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                return;
            }// end function
            );
                gs.ggbtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                return;
            }// end function
            );
            }
            shopRef = gs;
            Bl.stage.addChild(gs);
            return;
        }// end function

        public static function doFocus() : void
        {
            if (shopRef)
            {
                Bl.stage.addChild(shopRef);
            }
            return;
        }// end function

        private static function handlePayPalRequestSuccess(param1:Object) : void
        {
            navigateToURL(new URLRequest(param1.paypalurl), "_top");
            return;
        }// end function

        private static function handlePayPalRequestError(param1:PlayerIOError) : void
        {
            trace("Unable to buy coins", param1);
            return;
        }// end function

    }
}
