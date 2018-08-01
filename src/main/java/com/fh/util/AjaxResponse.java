package com.fh.util;

import java.io.Serializable;

import com.fh.entity.Page;

/**
 * 封装ajax返回
 * @author guowei
 *
 */
public class AjaxResponse implements Serializable {
	
	private static final long serialVersionUID = -7145191916102005908L;

	private short errorCode;
	
	private String message;
	
	private Page page;
	
	private Object data;
	
	private Boolean success;

	public Boolean getSuccess() {
		return success;
	}

	public void setSuccess(Boolean success) {
		this.success = success;
	}

	public short getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(short paramError) {
		this.errorCode = paramError;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	@Override
	public String toString() {
		return "AjaxResponse [errorCode=" + errorCode + ", message=" + message
				+ ", data=" + data + ", success=" + success + "]";
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
	
}
