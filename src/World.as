package 
{
    import World.*;
    
    import blitter.*;
    
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    
    import playerio.*;

    public class World extends BlTilemap
    {
        protected var Rocks:Class;
        protected var Rocks2:Class;
        protected var Coin:Class;
        protected var BonusCoin:Class;
        protected var CoinShadow:Class;
        protected var BonusCoinShadow:Class;
        protected var InvisibleBricks:Class;
        private var coin:BlSprite;
        private var bonuscoin:BlSprite;
        private var coinshadow:BlSprite;
        private var bonuscoinshadow:BlSprite;
        private var invisiblebricks:BlSprite;
        private var rocks2:BlSprite;
        private var coindoors:BlSprite;
        private var player:Player;
        private var coindoorslookup:Object;
        private var offset:Number = 0;
        public var hideRed:Boolean = false;
        public var hideGreen:Boolean = false;
        public var hideBlue:Boolean = false;

		public function World()
		{
			this.Rocks = World_Rocks;
			this.Rocks2 = World_Rocks2;
			this.Coin = World_Coin;
			this.BonusCoin = World_BonusCoin;
			this.CoinShadow = World_CoinShadow;
			this.BonusCoinShadow = World_BonusCoinShadow;
			this.InvisibleBricks = World_InvisibleBricks;
			this.coin = new blitter.BlSprite(new this.Coin().bitmapData);
			this.bonuscoin = new blitter.BlSprite(new this.BonusCoin().bitmapData);
			this.coinshadow = new blitter.BlSprite(new this.CoinShadow().bitmapData);
			this.bonuscoinshadow = new blitter.BlSprite(new this.BonusCoinShadow().bitmapData);
			this.invisiblebricks = new blitter.BlSprite(new this.InvisibleBricks().bitmapData);
			this.rocks2 = new blitter.BlSprite(new this.Rocks2().bitmapData);
			this.coindoorslookup = {};
			var loc1:*=new this.Rocks();
			var loc2:*=loc1.bitmapData;
			super(loc1, 9);
			trace("generating");
			var loc3:*=new flash.display.BitmapData(1600, 16, false, 0);
			var loc4:*=new blitter.BlText(14, 19, 3940096, "right", "visitor");
			loc4.text = "22";
			var loc5:*=0;
			while (loc5 < 100) 
			{
				loc3.copyPixels(loc2, new flash.geom.Rectangle(688, 0, 16, 16), new flash.geom.Point(16 * loc5, 0));
				if (loc5 > 0) 
				{
					loc4.text = loc5.toString();
					if (loc5 % 10 != 1) 
					{
						loc4.draw(loc3, loc5 * 16, 5);
					}
					else 
					{
						loc4.draw(loc3, loc5 * 16 - 1, 5);
					}
				}
				++loc5;
			}
			trace("done");
			this.coindoors = new blitter.BlSprite(loc3);
			return;
		}

        public function setPlayer(param1:Player) : void
        {
            this.player = param1;
            return;
        }// end function

        override public function update() : void
        {
            this.offset = this.offset + 0.03;
            super.update();
            return;
        }// end function

        public function getCoinValue(param1:int, param2:int) : int
        {
            if (!this.coindoorslookup[param1 + "x" + param2])
            {
            }
            return 0;
        }// end function

		public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
		{
			var loc1:*=null;
			var loc2:int = 0;
			var loc3:int = 0;
			var loc4: int =arg2 >> 0;
			var loc5: int =arg3 >> 0;
			var loc6: int =(-arg3) / size;
			var loc7: int =(-arg2) / size;
			var loc8: int =loc6 + Bl.height / size + 1;
			var loc9: int =loc7 + Bl.width / size + 1;
			if (loc6 < 0) 
			{
				loc6 = 0;
			}
			if (loc7 < 0) 
			{
				loc7 = 0;
			}
			if (loc8 > height) 
			{
				loc8 = height;
			}
			if (loc9 > width) 
			{
				loc9 = width;
			}
			var loc10:*=loc6;
			while (loc10 < loc8) 
			{
				loc1 = super.map[loc10] as Array;
				loc2 = loc7;
				while (loc2 < loc9) 
				{
					loc3 = loc1[loc2];
					if (loc3 < 100) 
					{
						if (this.hideRed) 
						{
							if (loc3 != 23) 
							{
								if (loc3 == 26) 
								{
									this.invisiblebricks.frame = 3;
									this.invisiblebricks.draw(arg1, loc2 * size + loc4, loc10 * size + loc5);
								}
							}
							else 
							{
								this.invisiblebricks.frame = 0;
								this.invisiblebricks.draw(arg1, loc2 * size + loc4, loc10 * size + loc5);
							}
						}
						if (this.hideGreen) 
						{
							if (loc3 != 24) 
							{
								if (loc3 == 27) 
								{
									this.invisiblebricks.frame = 4;
									this.invisiblebricks.draw(arg1, loc2 * size + loc4, loc10 * size + loc5);
								}
							}
							else 
							{
								this.invisiblebricks.frame = 1;
								this.invisiblebricks.draw(arg1, loc2 * size + loc4, loc10 * size + loc5);
							}
						}
						if (this.hideBlue) 
						{
							if (loc3 != 25) 
							{
								if (loc3 == 28) 
								{
									this.invisiblebricks.frame = 5;
									this.invisiblebricks.draw(arg1, loc2 * size + loc4, loc10 * size + loc5);
								}
							}
							else 
							{
								this.invisiblebricks.frame = 2;
								this.invisiblebricks.draw(arg1, loc2 * size + loc4, loc10 * size + loc5);
							}
						}
						if (loc3 == 43) 
						{
							if (this.getCoinValue(loc2, loc10) <= this.player.coins) 
							{
								this.invisiblebricks.frame = 6;
								this.invisiblebricks.draw(arg1, loc2 * size + loc4, loc10 * size + loc5);
							}
							else 
							{
								this.coindoors.frame = this.getCoinValue(loc2, loc10) - this.player.coins;
								this.coindoors.draw(arg1, loc2 * size + loc4, loc10 * size + loc5);
							}
						}
						rect.x = loc3 * size;
						arg1.copyPixels(bmd, rect, new Point(loc2 * size + loc4, loc10 * size + loc5));
					}
					else 
					{
						rect.x = 0;
						arg1.copyPixels(bmd, rect, new Point(loc2 * size + loc4, loc10 * size + loc5));
						var loc11:*=loc3;
						switch (loc11) 
						{
							case 100:
							{
								this.coin.frame = ((this.offset >> 0) + loc2 + loc10) % 12;
								this.coin.draw(arg1, loc2 * size + loc4 + 3, loc10 * size + loc5 + 3);
								break;
							}
							case 101:
							{
								this.bonuscoin.frame = ((this.offset >> 0) + loc2 + loc10) % 12;
								this.bonuscoin.draw(arg1, loc2 * size + loc4 + 3, loc10 * size + loc5 + 3);
								break;
							}
							case 255:
							{
								this.rocks2.frame = loc3 - 128;
								this.rocks2.draw(arg1, loc2 * size + loc4, loc10 * size + loc5);
								break;
							}
							default:
							{
								break;
							}
						}
						if (loc3 > 200) 
						{
							this.rocks2.frame = loc3 - 128;
							this.rocks2.draw(arg1, loc2 * size + loc4, loc10 * size + loc5);
						}
						if (Bl.data.canEdit) 
						{
							loc11 = loc3;
							switch (loc11) 
							{
								case 110:
								{
									this.coinshadow.frame = ((this.offset >> 0) + loc2 + loc10) % 12;
									this.coinshadow.draw(arg1, loc2 * size + loc4 + 3, loc10 * size + loc5 + 3);
									break;
								}
								case 111:
								{
									this.bonuscoinshadow.frame = ((this.offset >> 0) + loc2 + loc10) % 12;
									this.bonuscoinshadow.draw(arg1, loc2 * size + loc4 + 3, loc10 * size + loc5 + 3);
									break;
								}
								default:
								{
									break;
								}
							}
						}
					}
					loc2 = loc2 + 1;
				}
				loc10 = loc10 + 1;
			}
			return;
		}

        public function deserializeFromMessage(width:int, height:int, param3:int, message:Message) : Array
        {
			var currentMap:Array = [];
			var tempXArray:Array = [];
			
			var currentHeight:int = 0;
            var currentWidth:int = 0;
			
            var _loc_9:int = 0;
            var _loc_10:ByteArray = null;
            var _loc_11:ByteArray = null;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            var _loc_15:int = 0;
            this.coindoorslookup = {};
			
			//map initialization to 0 begin
            while (currentHeight < height)
            {
                
                tempXArray = [];
                currentWidth = 0;
                while (currentWidth < width)
                {
                    
                    tempXArray.push(0);
                    currentWidth = currentWidth + 1;
                }
                currentMap.push(tempXArray);
                currentHeight = currentHeight + 1;
            }
			//map initialization end
			
			/*var worldHeight:* = currentHeight;
            while (worldHeight < message.length)
            {
                
                _loc_9 = message.getInt(param3++);
                _loc_10 = message.getByteArray(worldHeight++);
                _loc_11 = message.getByteArray(worldHeight++);
                _loc_12 = 0;
                switch(_loc_9)
                {
                    case 43:
                    {
                        _loc_12 = message.getInt(worldHeight++);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_10.position = 0;
                _loc_11.position = 0;
                _loc_13 = 0;
                while (_loc_13 < _loc_10.length / 2)
                {
                    
                    _loc_14 = _loc_10.readUnsignedShort();
                    _loc_15 = _loc_11.readUnsignedShort();
                    currentMap[_loc_15][_loc_14] = _loc_9;
                    switch(_loc_9)
                    {
                        case 43:
                        {
                            this.coindoorslookup[_loc_14 + "x" + _loc_15] = _loc_12;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_13 = _loc_13 + 1;
                }
            }*/
            setMapArray(currentMap);
            return currentMap;
        }// end function

        public function resetCoins() : void
        {
            var _loc_2:int = 0;
            var _loc_1:int = 0;
            while (_loc_1 < width)
            {
                
                _loc_2 = 0;
                while (_loc_2 < height)
                {
                    
                    if (map[_loc_2][_loc_1] == 110)
                    {
                        setTile(_loc_1, _loc_2, 100);
                    }
                    if (map[_loc_2][_loc_1] == 111)
                    {
                        setTile(_loc_1, _loc_2, 101);
                    }
                    _loc_2 = _loc_2 + 1;
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function setTileComplex(param1:int, param2:int, param3:int, param4:Object) : void
        {
            switch(param3)
            {
                case 43:
                {
                    this.coindoorslookup[param1 + "x" + param2] = param4.goal;
                    break;
                }
                default:
                {
                    break;
                }
            }
            setTile(param1, param2, param3);
            return;
        }// end function

		
		override public function overlaps(arg1:BlObject) : Boolean {
			var loc1:* = 0;
			var loc2:* = 0;
			var loc3:* = arg1.x / size;
			var loc4:* = arg1.y / size;
			if(loc3 < 0 || loc4 < 0 || loc3 > this.width-1 || loc4 > this.height-1)
			{
				return true;
			}
			var loc5:* = arg1 as Player;
			if(loc5.isgod || loc5.ismod)
			{
				return false;
			}
			var loc6:* = loc4;
			while(loc6 < loc4 + (arg1.width-1) / size)
			{
				loc1 = loc3;
				while(loc1 < loc3 + (arg1.height-1) / size)
				{
					if(map[loc6 >> 0] != null)
					{
						loc2 = map[loc6 >> 0][loc1 >> 0];
						if(loc2 < hitOffset)
						{
						if(loc2 <= hitEnd)
						{
							if (!(this.hideRed && loc2 == 23)) 
							{
								if (!(this.hideGreen && loc2 == 24)) 
								{
									if (!(this.hideBlue && loc2 == 25)) 
									{
										if (!(this.hideRed && loc2 == 26)) 
										{
											if (!(this.hideGreen && loc2 == 27)) 
											{
												if (!(this.hideBlue && loc2 == 28)) 
												{
													if(loc2 != 43)
													{
														if(this.getCoinValue(loc1,loc6) > loc5.coins)
														{
															return true;
														}
													}
												}
											}
										}
									}
								}
							}
						}
						}
					}
					loc1 = loc1 + 1;
				}
				loc6 = loc6 + 1;
			}
			return false;
		}

    }
}
