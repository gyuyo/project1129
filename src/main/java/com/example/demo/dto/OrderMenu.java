package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderMenu {
	private int id;
	private int orderId;
	private int menuId;
	private String menuName;
	private int orderNum;
	private int quantity;
	private int price;
	
	private int totalPrice;
}
