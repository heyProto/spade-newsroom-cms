function autoExpanTextAreas(){$("textarea").each(function(t,a){$(a).height($(a).prop("scrollHeight"))})}function deHighlightAll(){$(".connection").css("opacity",.2),$(".spade-cms-table-no-highlight").css("opacity",.1),$(".spade-cms-table").each(function(t,a){var e=$(a),c=e.attr("data-og-opacity"),i=e.parent().find(".chair");c||e.attr("data-og-opacity",e.attr("opacity")),"true"!==e.attr("data-bypass")&&(e.attr("opacity",.1),i.attr("opacity",.1))})}function highlightAll(){$(".spade-cms-table-no-highlight").css("opacity",.5),$(".connection").css("opacity",1),$(".spade-cms-table").each(function(t,a){var e=$(a),c=e.parent().find(".chair");"true"!==e.attr("data-bypass")&&e.attr("opacity",e.attr("data-og-opacity")),"true"!==c.attr("data-bypass")&&c.attr("opacity",1)})}function markUsedSeats(t){t.length>0&&t.forEach(function(t){var a=$("#"+t),e=a.children(".spade-cms-table"),c=a.children(".chair");e.attr("data-og-opacity",1),c.attr("data-og-opacity",1),e.attr("opacity",1),c.attr("opacity",1),e.attr("data-bypass","true"),c.attr("data-bypass","true"),e.attr("is_clicked","yes"),c.attr("is_clicked","yes")})}function disableOnLoad(t){t.length>0&&t.forEach(function(t){var a=$("#"+t),e=a.children(".spade-cms-table"),c=a.children(".chair");e.attr("data-og-opacity",.1),c.attr("data-og-opacity",.1),e.attr("opacity",.1),c.attr("opacity",.1),e.attr("data-bypass","true"),c.attr("data-bypass","true"),e.addClass("spade-cms-used-table"),e.removeClass("spade-cms-table")})}$(document).ready(function(){var t=d3.select("#display_area").node().getBoundingClientRect().height,a=d3.select("#display_area").node().getBoundingClientRect().width,e=d3.select("#spade").node().getBBox().x,c=d3.select("#spade").node().getBBox().y,i=d3.select("#spade").node().getBBox().width,s=d3.select("#spade").node().getBBox().height;d3.select("#svg").attr("height",t).attr("width",a).attr("viewBox",e+" "+c+" "+i+" "+s)});