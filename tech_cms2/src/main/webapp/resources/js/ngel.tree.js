$(function() {
	
	$.fn.extend({
		setTree: function(param) {
			var defaults = {
					extensions: ["filter"],
					url: null,
					postData: null,
					key: "key",
					parent: "parent",
					root: true,
					rootkey: null,
					roottext: "/",
					gubunField: null,
					title: "title",
					folderclass: null,
					fileclass: null,
					autoheight: true,
					height: 200,
					heightTarget: null,
					checkbox: false,
					checkboxlevel: 0,
					selectMode: 2,
					expandlevel: 1
			};
			
			var $obj = $(this);
			var treeParams = $.extend({}, defaults, param);

			return this.each(function() {
				makeTree();
				var tree = $obj.fancytree(treeParams);
				
				if(treeParams.autoheight) {
					$(".fancytree-container", $obj).height($(window).height() - $(".fancytree-container", $obj).offset().top - 30);
					$(window).on("resize", function() {
						$(".fancytree-container", $obj).height($(window).height() - $(".fancytree-container", $obj).offset().top - 30);
					});
				}
				else {
					var height = treeParams.height;
					if(treeParams.heightTarget != null) {
						height = $(treeParams.heightTarget).height();
					}
					$(".fancytree-container", $obj).height(height);
				}
			});
			
			function makeTree() {
				if(treeParams.url == null) {
					alertMessage("[setTree] url is required.");
					return;
				}
				
				var nodes = [];
				submitActionSync(treeParams.url, treeParams.postData, function(data) {nodes = data;});
				var $rootNode = $obj;
				if(treeParams.root) {
					var $ul = $("<ul>").appendTo($obj);
					$rootNode = $("<li>").attr("id", treeParams.rootkey || "0").text(treeParams.roottext).addClass("expanded").appendTo($ul);
					$rootNode.addClass("folder");
					if(treeParams.folderclass != null)
						$rootNode.attr("data-iconclass", treeParams.folderclass);
				}

				if(treeParams.rootkey == null)
					treeParams.rootkey = nodes[0][treeParams.parent];

				makeNodes($rootNode, nodes, treeParams.rootkey, 1);
			}
			
			function makeNodes(parentNode, nodes, parentKey, level) {
				var $ul = null;
				$.each(nodes, function(i, node) {
					if(node[treeParams.parent] === parentKey) {
						if($ul == null) {
							if($(parentNode).is("li")) {
								if(treeParams.folderclass != null)
									$(parentNode).attr("data-iconclass", treeParams.folderclass);
								
								$(parentNode).addClass("folder");
								
								if(treeParams.checkbox && level < treeParams.checkboxlevel)
									$(parentNode).addClass("hideCheckbox");
								if(treeParams.expandlevel >= level)
									$(parentNode).addClass("expanded");
							}
							$ul = $("<ul>").appendTo($(parentNode));
						}
						var $li = $("<li>").attr("id", node[treeParams.key]).text(node[treeParams.title]).appendTo($ul);
						node["level"] = level;
						$li.data("json", node);
						
						if(treeParams.gubunField && isEmpty(node[treeParams.gubunField])) {
							$li.addClass("folder");
							if(treeParams.folderclass != null)
								$li.attr("data-iconclass", treeParams.folderclass);
						}
						else {
							if(treeParams.fileclass != null)
								$li.attr("data-iconclass", treeParams.fileclass);
						}
						
						makeNodes($li, nodes, node[treeParams.key], level + 1);
					}
				});
			}
		},
		searchByTitle: function(match) {
			var tree = $(this).fancytree("getTree");
			var root = tree.getFirstChild();
			if(match !== "") {
				var n = tree.filterNodes(function(node) {
					return new RegExp(match, "i").test(node.title);
				});
				
				var data = getDataset(this, "matchData");
				if(data.idx == undefined && (data.match == undefined || data.match == "")) {
					data.match = match;
					data.idx = 0;
				}
				else if(match === data.match) {
					data.idx++;
					if(data.idx === n)
						data.idx = 0;
				}
				else {
					data.match = match;
					data.idx = 0;
				}
				
				var nodes = root.findAll(match);
				nodes[data.idx].setActive(true);
			}
			else {
				tree.clearFilter();
				root.setActive(true);
			}
		},
		searchByKey: function(match) {
			var tree = $(this).fancytree("getTree");
			if(match !== "") {
				tree.filterNodes(function(node) {
					return new RegExp(match, "i").test(node.key);
				});
				tree.activateKey(match);
			}
			else {
				tree.clearFilter();
				var root = tree.getFirstChild();
				root.setActive(true);
			}
		},
		selectNodeByKey: function(key) {
			var tree = $(this).fancytree("getTree");
			if(key !== "") {
				tree.activateKey(key);
			}
		},
		getActiveParentKey: function() {
			var tree = $(this).fancytree("getTree");
			var node = tree.getActiveNode();
			if(node == undefined)
				return "";
			else
				return node.folder ? node.key : node.parent.key;
		},
		getActiveKey: function() {
			var tree = $(this).fancytree("getTree");
			var node = tree.getActiveNode();
			if(node == undefined)
				return "";
			else
				return node.key;
		},
		getActiveParentTitle: function() {
			var tree = $(this).fancytree("getTree");
			var node = tree.getActiveNode();
			if(node == undefined)
				return "";
			else
				return node.folder ? node.title : node.parent.title;
		},
		getActiveTitle: function() {
			var tree = $(this).fancytree("getTree");
			var node = tree.getActiveNode();
			if(node == undefined)
				return "";
			else
				return node.title;
		},
		getActiveNode: function() {
			var tree = $(this).fancytree("getTree");
			return tree.getActiveNode();
		},
		getSelectedNodes: function(stopOnParents) {
			var tree = $(this).fancytree("getTree");
			return tree.getSelectedNodes(stopOnParents || false);
		},
		getActiveNodeData: function(name) {
			var tree = $(this).fancytree("getTree");
			var node = tree.getActiveNode();
			var data = node.data;
			if(name)
				return data[name] || "";
			else
				return data;
		},
		reloadTree: function(key) {
			var tree = $(this).fancytree("getTree");
			var options = tree.options;

			$(this).fancytree("destroy");
			$(this).empty();
			$(this).setTree(options);
		}
	});
});