$(document).ready(function(){

  $('.slider').slider({
    full_width: true,
    height: 500,
    //indicators: false
  });
  $(".product_status").each(function() {
    if ($(this).data("status") === "available") {
      $(this).prop("checked", true);
    } else {
      $(this).prop("checked", false);
    }
  });

  $(".parallax").parallax();

  $(".select_field").change(function() {
      var url = $(".select_field").val();
      document.location.href = url;
  });

  $(".show-material-message").each(function(){
    Materialize.toast($(this).data("message"), 5000, "rounded");
  });

  var calcTotal = function() {
    var _total = 0;
    $(".line-total").each(function(){
      _total += parseFloat($(this).text());
    });
    return _total;
  }
  var calcPrepTotal = function() {
    var _preptotal = 0;
    $(".product-prep").each(function(){
      _preptotal += parseFloat($(this).text());
    });
    return _preptotal;
  }

  var calcTotalItemsInCart = function() {
    var _totalItemsInCart = 0;
    $(".qty").each(function(){
      _totalItemsInCart += parseInt($(this).val());
    });
    $("#cart").html("<i class='material-icons left'>shopping_cart</i>" + _totalItemsInCart);
  }

  var line_prep_total = function(qty, prep_time) {
    var added_time = parseInt(qty/7) * 10;
    var time = added_time + prep_time;
    return time;
  }


  $(".qty-editable-width").change(function(){
    var product_id = $(this).data("message");
    var qty = parseFloat($(this).val());
    var price = parseFloat($('#product_sub_total_' + product_id).data('message'));
    var prep_time = parseFloat($('#product_prep_' + product_id).data('message'));
    var line_total = parseFloat(qty * price).toFixed(2);
    $('#product_sub_total_' + product_id).text(line_total);
    $('#product_prep_' + product_id).text(line_prep_total(qty, prep_time) + "mins");

    var _total = calcTotal();
    var _preptotal = calcPrepTotal();

    var params = {
        cart_items: {
          product_id: product_id,
          quantity: qty
        },
        order_details: {
          sub_total: line_total,
          total: _total,
          prep_time: line_prep_total,
          pickup_time: _preptotal
        }
      };
    var url = "/cart_items/1";
    ajax_call($(this), params, url, "PATCH", function(data){

        $("#total").text("EGP" + _total.toFixed(2));
        $("#prep_total").text("Your order will be ready in: " +
                               _preptotal + "mins");
        calcTotalItemsInCart();
        $(this).prop('disabled', false);
      });
  });

  $("#add_comment").click(function(){
    var product_id = parseInt($(this).data("productid"));
    var url = "/products/" + product_id + "/comments";
    params = {
      comment: {
        comment: $("#comment").val(),
        user_id: parseInt($(this).data("userid")),
        product_id: product_id
      }
    }
    ajax_call($(this), params, url, "POST", function(comment) {
      $("div.comments").prepend(
        "<div class='divider'></div>" +
        "  <div class='section'>" +
        "    <h6>" + comment.first_name + " " + comment.last_name + " says </h6>" +
        "    <p>" + comment.comment + "</p>" +
        "  </div>"
      );
        $("#comment").val('');
    })
  });

  $(".product_status").click(function() {
    var product_id = $(this).data("productid");
    var product_status = $(this).prop("checked");
    var url = "/products/" + product_id + "/edit_status";
    params = {
      product: {
        id: product_id,
        status: product_status
      }
    }
    ajax_call($(this), params, url, "PATCH", function(product) {
      if (product.status === "available") {
        $(this).prop("checked", true);
      } else {
        $(this).prop("checked", false);
      }
    });
  })
  
  var ajax_call = function(elem, params, url, method, callback){
    $.ajax({
      method: method,
      url: url,
      data: params,
      beforeSend: function(){

        elem.prop("disabled", true);
      },
      success: function(data){
        elem.prop("disabled", false);
        callback(data);
      },
      error: function(){
        Materialize.toast(elem.data("An error occured. Please try again"), 5000, "rounded");
      },
      complete: function(){
      }
    });
  };

  $(".cloudinary-fileupload").bind("fileuploadprogress", function(e, data) {
  $(".product_upload_progress_bar").css("width", Math.round((data.loaded * 100.0) / data.total) + "%");
});
});//end document ready
