$(document).ready(function() {
  var height = d3.select("#display_area").node().getBoundingClientRect().height,
    width = d3.select("#display_area").node().getBoundingClientRect().width,
    x = d3.select("#spade").node().getBBox().x,
    y = d3.select("#spade").node().getBBox().y,
    w = d3.select("#spade").node().getBBox().width,
    h = d3.select("#spade").node().getBBox().height;

  d3.select("#svg")
    .attr("height", height)
    .attr("width", width)
    .attr("viewBox", x +" " + y +" "+ w + " "+ h);
});

// function highlightOnLoad(array) {
//   if (array.length > 0) {
//     array.forEach(function (e) {
//       var elem = $("#" + e),
//         table = elem.children(".spade-cms-table");

//       table.attr('is_clicked', "yes");
//       table.attr('fill', "red");
//       table.addClass("spade-cms-restricted-table");
//     });
//   }
// }

function autoExpanTextAreas() {
  $("textarea").each(function(i, e){
    $(e).height($(e).prop("scrollHeight"));
  });
}


function deHighlightAll() {
  $(".connection").css("opacity", 0.2);
  $(".spade-cms-table-no-highlight").css("opacity", 0.1);

  $(".spade-cms-table").each(function (i, e) {
    var elem = $(e),
      og_opacity = elem.attr("data-og-opacity"),
      chair = elem.parent().find(".chair");

    if (!og_opacity) {
      elem.attr("data-og-opacity", elem.attr("opacity"));
    }

    if (elem.attr("data-bypass") !== "true") {
      elem.attr("opacity", 0.1);
      chair.attr("opacity", 0.1);
    }
  });
}

function highlightAll() {
  $(".spade-cms-table-no-highlight").css("opacity", 0.5);
  $(".connection").css("opacity", 1);

  $(".spade-cms-table").each(function (i, e) {
    var elem = $(e),
      chair = elem.parent().find(".chair");

    if (elem.attr("data-bypass") !== "true") {
      elem.attr("opacity", elem.attr("data-og-opacity"));
    }

    if (chair.attr("data-bypass") !== "true") {
      chair.attr("opacity", 1);
    }
  });
}

function markUsedSeats(array) {
  if (array.length > 0) {
    array.forEach(function (e) {
      var elem = $("#" + e),
        table = elem.children(".spade-cms-table"),
        chair = elem.children(".chair");

      table.attr("data-og-opacity", 1);
      chair.attr("data-og-opacity", 1);

      table.attr("opacity", 1);
      chair.attr("opacity", 1);

      table.attr("data-bypass", "true");
      chair.attr("data-bypass", "true");

      table.attr('is_clicked', "yes");
      chair.attr('is_clicked', "yes");
    });
  }
}

function disableOnLoad(array) {
  if (array.length > 0) {
    array.forEach(function(e) {
      var elem = $("#" + e),
        table = elem.children(".spade-cms-table"),
        chair = elem.children(".chair");

      table.attr("data-og-opacity", 0.1);
      chair.attr("data-og-opacity", 0.1);

      table.attr("opacity", 0.1);
      chair.attr("opacity", 0.1);

      table.attr("data-bypass", "true");
      chair.attr("data-bypass", "true");

      table.addClass("spade-cms-used-table");
      table.removeClass("spade-cms-table");
    });
  }
}