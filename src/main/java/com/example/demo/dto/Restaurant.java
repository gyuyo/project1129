package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Restaurant {
	private int id;
	private String regDate;
	private String updateDate;
	private int cgId;
	private String name;
	private String memberId;
	private int like;
	private int orderCount;
	
	private String loginId;
}
