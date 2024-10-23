package com.example.demo.dto;

import lombok.Data;

@Data
public class ResultData {
	private String resultCode;
	private String resultMsg;
	private Object data;

	public static ResultData from(String resultCode, String resultMsg) {

		return from(resultCode, resultMsg, null);
	}

	public static ResultData from(String resultCode, String resultMsg, Object data) {

		ResultData rd = new ResultData();
		rd.resultCode = resultCode;
		rd.resultMsg = resultMsg;
		rd.data = data;

		return rd;
	}

	public boolean isSuccess() {
		return this.resultCode.startsWith("S-");
	}

	public boolean isFail() {
		return this.resultCode.startsWith("F-");
	}

}
