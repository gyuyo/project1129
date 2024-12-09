package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
	private int id;
	private int orderMemberId;
	private int restaurantId;
	private String orderStatus;
}