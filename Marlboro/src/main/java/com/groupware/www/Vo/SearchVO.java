package com.groupware.www.Vo;


public class SearchVO extends PageVO  {

    private String bgno;                       // ê²Œì‹œ?Œ ê·¸ë£¹
    private String searchKeyword = "";         // ê²??ƒ‰ ?‚¤?›Œ?“œ
    private String searchType = "";            // ê²??ƒ‰ ?•„?“œ: ? œëª?, ?‚´?š©  
    private String[] searchTypeArr;            // ê²??ƒ‰ ?•„?“œë¥? ë°°ì—´ë¡? ë³??™˜
    
    public String getBgno() {
        return bgno;
    }

    public void setBgno(String bgno) {
        this.bgno = bgno;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }
    
    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }
    
    public String getSearchType() {
        return searchType;
    }
    
    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }
    
    public String[] getSearchTypeArr() {
        return searchType.split(",");
    }
    
}
 