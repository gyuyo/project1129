package com.example.demo.controller;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.example.demo.service.RestaurantService;

@RestController
public class ApiDataAddController {
	
	private final RestaurantService restaurantService;
	
	public ApiDataAddController(RestaurantService restaurantService) {
		this.restaurantService = restaurantService;
	}
	
	@GetMapping("/fetch-restaurants")
    public String fetchRestaurants() {
        RestTemplate restTemplate = new RestTemplate();

        String url = "https://api.odcloud.kr/api/15008957/v1/uddi:77077c20-b487-4a49-aa21-f64f20da2ae4?page=10&perPage=600&serviceKey=CeDs9AdRplTjPZLqTGVWdFSDJzno/QtQsVd9F0ySOvf/qBZnengCaHd2AAremCSSX9k0DUGL5MWtP2x/KzNSPA==";

        String response = restTemplate.getForObject(url, String.class);

        JSONObject jsonObject = new JSONObject(response);
        JSONArray data = jsonObject.getJSONArray("data");

        for (int i = 0; i < data.length(); i++) {
            JSONObject restaurant = data.getJSONObject(i);
            String name = restaurant.getString("업소명");
            String latitude = restaurant.getString("위도");
            String longitude = restaurant.getString("경도");
            
            restaurantService.doregister(name, latitude, longitude);
        }

        return "Restaurants data processed and saved.";
    }
}
