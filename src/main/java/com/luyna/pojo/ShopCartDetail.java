package com.luyna.pojo;

import java.util.Date;
/**
 * 用于购物车详情的显示
 * @author luyna
 *
 */
public class ShopCartDetail {	
	private Jewel jewel;
	private ShopCart shopCart;
	
	
	public Jewel getJewel() {
		return jewel;
	}
	public void setJewel(Jewel jewel) {
		this.jewel = jewel;
	}
	public ShopCart getShopCart() {
		return shopCart;
	}
	public void setShopCart(ShopCart shopCart) {
		this.shopCart = shopCart;
	}
	
}