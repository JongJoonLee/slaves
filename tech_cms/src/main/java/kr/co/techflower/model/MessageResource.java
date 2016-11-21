package kr.co.techflower.model;

import java.io.Serializable;

import org.springframework.stereotype.Repository;

@Repository
@SuppressWarnings("serial")
public class MessageResource implements Serializable {
	
	private String msgCode;
	private String locale;
	private String message;
	private String description;
	private String url;
	private String useYn;
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getMsgCode() {
		return msgCode;
	}
	public void setMsgCode(String msgCode) {
		this.msgCode = msgCode;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	@Override
	public String toString() {
		return "MessageResource [msgCode=" + msgCode + ", locale=" + locale
				+ ", message=" + message + ", url=" + url + ", useYn=" + useYn
				+ "]";
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((locale == null) ? 0 : locale.hashCode());
		result = prime * result + ((message == null) ? 0 : message.hashCode());
		result = prime * result + ((msgCode == null) ? 0 : msgCode.hashCode());
		result = prime * result + ((url == null) ? 0 : url.hashCode());
		result = prime * result + ((useYn == null) ? 0 : useYn.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MessageResource other = (MessageResource) obj;
		if (locale == null) {
			if (other.locale != null)
				return false;
		} else if (!locale.equals(other.locale))
			return false;
		if (message == null) {
			if (other.message != null)
				return false;
		} else if (!message.equals(other.message))
			return false;
		if (msgCode == null) {
			if (other.msgCode != null)
				return false;
		} else if (!msgCode.equals(other.msgCode))
			return false;
		if (url == null) {
			if (other.url != null)
				return false;
		} else if (!url.equals(other.url))
			return false;
		if (useYn == null) {
			if (other.useYn != null)
				return false;
		} else if (!useYn.equals(other.useYn))
			return false;
		return true;
	}
	
}
