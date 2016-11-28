package kr.co.techflower.web;

public class PageTool {
	public int[] makePagination(int item_total, int page_now, int list_view_size, int section) {
		/**	
		 * If You Want to use This, You should make sure your DAO class
		 * that includes Multiplication of Page.
		 * 
		 * For example,
		 * 		int page = getList.getPage();
		 * 		if(page == 0) { page = 1; }
		 * 		int list_size = getList.getSize();
		 * 		int boo_page = (page-1)*list_size;
		 * 		getList.setBoo_page(boo_page);
		 * 
		 * So, you should send values "page" and "list_view_size" to DAO.
		 * Of course, values' name can be changed. 
		**/
		System.out.println("Making Pagination ========");
		System.out.println("Item Total: "+item_total+", Page Now: "+page_now+", List View Size: "+list_view_size+", Section: "+section);
		
		//Apart Articles by List Size
		int page_count = (item_total)/list_view_size+1;
		if(item_total%list_view_size == 0) { page_count = page_count-1; }
		System.out.println("Page Count: "+page_count);
		System.out.println("="+item_total+"/"+list_view_size+"+1");
		if(item_total%list_view_size == 0) { System.out.println("Page Count = "+page_count+"-1"); }
	
		//Make a Block
		int page_block = (page_now/(section+1))+1;
		int page_start = (page_block-1)*section+1;
		int page_end = (page_start+section)-1;
			if(page_end > page_count) { page_end = page_count; }
		System.out.println("Page Block: "+page_block);
		System.out.println("Page Starts with "+page_start+", and Page Ends with "+page_end);
			
		//Get Next and Previous Page
		int page_next = page_end+1;
			if(page_next > page_count) { page_next = page_count; }
		int page_prev = page_start-1;
			if(page_prev < 1) { page_prev = 1; }
		System.out.println("Next Page is "+page_next+", and Previous Page is "+page_prev);
		
		//Set the First Page and the Last Page
		int page_first = 1;
		int page_last = page_count;
		System.out.println("First Page is "+page_first+", Last Page is "+page_last);
		
		//Set int[] pagination for send to Controller
		int[] pagination = new int[6];
		pagination[0] = page_first;
		pagination[1] = page_prev;
		pagination[2] = page_start;
		pagination[3] = page_end;
		pagination[4] = page_next;
		pagination[5] = page_last;
		
		//Return int[]
		return pagination;
	}
}
