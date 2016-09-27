package com.groupware.www.Vo;

public class PageVO {
    private Integer displayRowCount = 10;           // Ï∂úÎ†•?ï† ?ç∞?ù¥?Ñ∞ Í∞úÏàò
    private Integer rowStart;                       // ?ãú?ûë?ñâÎ≤àÌò∏
    private Integer rowEnd;                         // Ï¢ÖÎ£å?ñâ Î≤àÌò∏
    private Integer totPage;                        // ?†ÑÏ≤? ?éò?ù¥?àò
    private Integer totRow = 0;                     // ?†ÑÏ≤? ?ç∞?ù¥?Ñ∞ ?àò
    private Integer page;                           // ?òÑ?û¨ ?éò?ù¥Ïß?
    private Integer pageStart;                      // ?ãú?ûë?éò?ù¥Ïß?
    private Integer pageEnd;                        // Ï¢ÖÎ£å?éò?ù¥Ïß?

    /**
     * ?†ÑÏ≤? ?ç∞?ù¥?Ñ∞ Í∞úÏàò(total)Î•? ?ù¥?ö©?ïò?ó¨ ?éò?ù¥Ïß??àò Í≥ÑÏÇ∞. 
     */
    public void pageCalculate(Integer total) {
        getPage();
        totRow  = total;
        totPage    = (int) ( total / displayRowCount );
        
        if ( total % displayRowCount > 0 ) {
            totPage++;
        }

        pageStart = (page - (page - 1) % 10) ;
        pageEnd = pageStart + 9;
        if (pageEnd > totPage) {
            pageEnd = totPage;
        }
        
        rowStart = ((page - 1) * displayRowCount) + 1 ;
        rowEnd   = rowStart + displayRowCount - 1;
    } 
    

    /**
     * ?òÑ?û¨ ?éò?ù¥Ïß? Î≤àÌò∏. 
     */
    public Integer getPage() {
        if (page == null || page == 0) {
            page = 1;
        }
        
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getRowStart() {
        return rowStart;
    }

    public void setRowStart(Integer rowStart) {
        this.rowStart = rowStart;
    }

    public Integer getRowEnd() {
        return rowEnd;
    }

    public void setRowEnd(Integer rowEnd) {
        this.rowEnd = rowEnd;
    }

    public Integer getDisplayRowCount() {
        return displayRowCount;
    }

    public void setDisplayRowCount(Integer displayRowCount) {
        this.displayRowCount = displayRowCount;
    }

    public Integer getTotPage() {
        return totPage;
    }

    public void setTotPage(Integer totPage) {
        this.totPage = totPage;
    }

    public Integer getTotRow() {
        return totRow;
    }

    public void setTotRow(Integer totRow) {
        this.totRow = totRow;
    }

    public Integer getPageStart() {
        return pageStart;
    }

    public void setPageStart(Integer pageStart) {
        this.pageStart = pageStart;
    }

    public Integer getPageEnd() {
        return pageEnd;
    }

    public void setPageEnd(Integer pageEnd) {
        this.pageEnd = pageEnd;
    }


    
}


