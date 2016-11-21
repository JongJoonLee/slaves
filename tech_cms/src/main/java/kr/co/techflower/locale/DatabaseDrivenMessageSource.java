package kr.co.techflower.locale;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.context.support.AbstractMessageSource;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.ResourceLoader;

import kr.co.techflower.model.MessageResource;
import kr.co.techflower.service.MessageResourceService;

public class DatabaseDrivenMessageSource extends AbstractMessageSource implements ResourceLoaderAware {

	private Logger log = Logger.getLogger(getClass());
	@SuppressWarnings("unused")
	private ResourceLoader resourceLoader;
	
	private final Map<String, Map<String, String>> properties = new HashMap<String, Map<String,String>>();
	
	@Resource(name="messageResourceService")
	private MessageResourceService messageResourceService;
	
	public DatabaseDrivenMessageSource() {
		reload();
	}
	
	public DatabaseDrivenMessageSource(MessageResourceService messageResourceService) {
		this.messageResourceService = messageResourceService;
		reload();
	}

	@Override
	protected MessageFormat resolveCode(String code, Locale locale) {
		// TODO Auto-generated method stub
		String msg = getText(code, locale);
		MessageFormat result = createMessageFormat(msg, locale);
		return result;
	}
	
	@Override
	protected String resolveCodeWithoutArguments(String code, Locale locale){
		return getText(code, locale);
	}
	
	private String getText(String code, Locale locale){
		Map<String, String> localized = properties.get(code);
		String textForCurrentLanguage = null;
		if (localized != null) {
			textForCurrentLanguage = localized.get(locale.getLanguage());
			if (textForCurrentLanguage == null) {
				textForCurrentLanguage = localized.get(Locale.KOREA.getLanguage());
			}
		}
		
		if (textForCurrentLanguage == null) {
			logger.debug("Fallback to properties message");
			try {
				textForCurrentLanguage = getParentMessageSource().getMessage(code, null, locale);
			} catch (Exception e) {
				// TODO: handle exception
				logger.error("Cannot find message with code: " + code);
			}
		}
		return textForCurrentLanguage != null ? textForCurrentLanguage : code;
	}
	
	public void reload(){
		properties.clear();
		properties.putAll(loadTexts());
	}
	
	protected Map<String, Map<String, String>> loadTexts(){
		log.debug("loadTexts");
		Map<String, Map<String, String>> m = new HashMap<String, Map<String,String>>();
		List<MessageResource> texts = messageResourceService.loadAllMessages();
		//다국어 message 생성
		for (MessageResource text : texts) {
			Map<String, String> v;
			if(m.containsKey(text.getMsgCode())){
				//이미 등록된 msgCode가 등록될 경우
				v = m.get(text.getMsgCode());
				v.put(text.getLocale(), text.getMessage());
				m.put(text.getMsgCode(), v);
			}else{
				//신규 msgCode가 등록될 경우 
				v = new HashMap<String, String>();
				v.put(text.getLocale(), text.getMessage());
				m.put(text.getMsgCode(), v);
			}
		}
		//다국어 url 생성
		for (MessageResource text : texts) {
			Map<String, String> v;
			String sUrlCode = text.getMsgCode() + ".url";
			//url이 없을 경우
			if(text.getUrl() != null && text.getUrl().isEmpty()){continue;}
			if(m.containsKey(sUrlCode)){
				//이미 등록된 msgCode가 등록될 경우
				v = m.get(sUrlCode);
				v.put(text.getLocale(), text.getUrl());
				m.put(sUrlCode, v);
			}else{
				//신규 msgCode가 등록될 경우 
				v = new HashMap<String, String>();
				v.put(text.getLocale(), text.getUrl());
				m.put(sUrlCode, v);
			}
		}
		//다국어 description 생성
		for (MessageResource text : texts) {
			Map<String, String> v;
			String sAltCode = text.getMsgCode() + ".alt";
			//url이 없을 경우
			if(text.getDescription() != null && text.getDescription().isEmpty()){continue;}
			if(m.containsKey(sAltCode)){
				//이미 등록된 msgCode가 등록될 경우
				v = m.get(sAltCode);
				v.put(text.getLocale(), text.getDescription());
				m.put(sAltCode, v);
			}else{
				//신규 msgCode가 등록될 경우 
				v = new HashMap<String, String>();
				v.put(text.getLocale(), text.getDescription());
				m.put(sAltCode, v);
			}
		}
		
		return m;
	}
	
	@Override
	public void setResourceLoader(ResourceLoader resourceLoader) {
		// TODO Auto-generated method stub
		this.resourceLoader = (resourceLoader != null ? resourceLoader : new DefaultResourceLoader());
	}
	
//	//Reload Messages
//	private void reloadDatabaseMessages(){
//		if (messageSource instanceof DatabaseDrivenMessageSource) {
//	        ((DatabaseDrivenMessageSource)messageSource).reload();
//	    } else if (messageSource instanceof DelegatingMessageSource) {
//	        DelegatingMessageSource myMessage = ((DelegatingMessageSource)messageSource);
//	        if (myMessage.getParentMessageSource()!=null && myMessage.getParentMessageSource() instanceof DatabaseDrivenMessageSource) {
//	            ((DatabaseDrivenMessageSource) myMessage.getParentMessageSource()).reload();
//	        }
//	    }
//	}
}
