package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Menu {
	private int id;
	private int menuId;
	private int restaurantId;
	private String name;
	private String description;
	private int quantity;
	private int price;
	private int readyTime;
	
	private int totalPrice;
}
