$(function() {
	$.fn.extend({
		paging: function(option) {
			var defaults = {
					pageIndex: 1,
					rowPerPage: 10,
					pageSize: 10,
					totalPage: 0,
					action:null
				};
			
			var $obj = $(this);
			var curOption = $.extend(defaults, option);
			curOption.totalPage = curOption.totalPage < 1 ? 1 : curOption.totalPage;
//			var curOption = updateCurOption(opt);

			return this.each(function() {
				var $ul = $("<ul>").addClass("pagination").appendTo($obj);
				
				makeBackwordBtn($ul);
				makeNumBtn($ul);
				makeForwordBtn($ul);
				setActiveBtn($ul);
			});
			
			function updateCurOption(opt) {
				var curOpt = $obj.data("option");
				if(curOpt == undefined) {
					return makeDataset($obj, "option", opt);
				} else {
					var pageIndex = curOpt.pageIndex;
					curOpt = $.extend(curOpt, opt);
					curOpt.pageIndex = pageIndex;
					return curOpt;
				}
			}
			
			function makeNumBtn(obj) {
				var pageIndex = curOption.pageIndex;
				var rowPerPage = curOption.rowPerPage;
				var firstPageIndex = parseInt((pageIndex - 1) / rowPerPage) * rowPerPage + 1;
				var lastPageIndex = (parseInt((pageIndex - 1) / rowPerPage) + 1) * rowPerPage;
				lastPageIndex = lastPageIndex > curOption.totalPage ? curOption.totalPage : lastPageIndex;
				
				for(var i = firstPageIndex ; i <= lastPageIndex ; i++) {
					var $li = $("<li>").addClass("num_" + i).appendTo(obj);
					$("<span>")
						.addClass("pointer")
						.prop("title", i + "페이지")
						.text(i)
						.on("click", paginationNumBtn_click_event)
						.appendTo($li);
				}
			}
			
			function makeBackwordBtn(obj) {
				
				var $firstLi = $("<li>").addClass("first").appendTo(obj);
				$("<span>")
					.addClass("pointer")
					.prop("title", "처음")
//					.html("<i class='fa fa-fast-backward'></i>")
//					.text("<<")
					.text("[" + 1 + "]")
					.on("click", paginationBackwardBtn_click_event)
					.appendTo($firstLi);
				
				var $prevLi = $("<li>").addClass("prev").appendTo(obj);
				$("<span>")
					.addClass("pointer")
					.prop("title", "이전")
//					.html("<i class='fa fa-step-backward'></i>")
					.text("◀")
//					.text("[" +prevIndex + "]")
					.on("click", paginationBackwardBtn_click_event)
					.appendTo($prevLi);
			}
			
			function makeForwordBtn(obj) {
				
				var $nextLi = $("<li>").addClass("next").appendTo(obj);
				$("<span>")
					.addClass("pointer")
					.prop("title", "다음")
//					.html("<i class='fa fa-step-forward'></i>")
					.text("▶")
//					.text("[" +nextIndex + "]")
					.on("click", paginationForwardBtn_click_event)
					.appendTo($nextLi);
				
				var $lastLi = $("<li>").addClass("last").appendTo(obj);
				$("<span>")
					.addClass("pointer")
					.prop("title", "마지막")
//					.html("<i class='fa fa-fast-forward'></i>")
//					.text(">>")
					.text("[" + curOption.totalPage + "]")
					.on("click", paginationForwardBtn_click_event)
					.appendTo($lastLi);
			}
			
			function setActiveBtn(obj) {
				var pageIndex = curOption.pageIndex;
				var totalPage = curOption.totalPage;
				
				if(pageIndex == 1)
					$("li.first, li.prev", obj).addClass("disabled").children().off("click");
				if(pageIndex == totalPage || totalPage == 0)
					$("li.next, li.last", obj).addClass("disabled").children().off("click");
				
				$("li.num_" + pageIndex, obj).addClass("active");
				$("li.num_" + pageIndex, obj).children().off("click");
				if($("#pageIndex").is("input"))
					$("#pageIndex").val(pageIndex);
			}
			
			function paginationNumBtn_click_event() {
				curOption.pageIndex = parseInt($(this).text());
				curOption.action(curOption.pageIndex);
			}
			
			function paginationBackwardBtn_click_event() {
				if($(this).parent().prop("class").indexOf("first") > -1) {
					curOption.pageIndex = 1;
				} else {
					var curIndex = curOption.pageIndex;
					var rowPerPage = curOption.rowPerPage;
					var prevIndex = (parseInt((curIndex - 1) / rowPerPage) - 1) * rowPerPage + 10;
					curOption.pageIndex = prevIndex < 1 ? 1 : prevIndex;
				}
				
				curOption.action(curOption.pageIndex);
			}
			
			function paginationForwardBtn_click_event() {
				if($(this).parent().prop("class").indexOf("last") > -1) {
					curOption.pageIndex = curOption.totalPage;
				} else {
					var curIndex = curOption.pageIndex;
					var rowPerPage = curOption.rowPerPage;
					var nextIndex = (parseInt((curIndex - 1) / rowPerPage) + 1) * rowPerPage + 1;
					curOption.pageIndex = nextIndex > curOption.totalPage ? curOption.totalPage : nextIndex;
				}

				curOption.action(curOption.pageIndex);
			}
		}
	});
});