$(document).ready(function () {
  var $artists = $('.artist');
  var $categories = $('.category');
  var $orders = $('.order');

  $('#artist_filter_name').on('keypress', function () {
    var currentName = this.value.toLowerCase();

    $artists.each(function (index, artist) {
      var $artist = $(artist)
      var $artist_name = $artist.find('h2').text().toLowerCase();

      if ($artist_name.startsWith(currentName)) {
        $artist.show();
      } else {
        $artist.hide();
      }
    });
  });

  $('#category_filter_name').on('keypress', function () {
    var currentName = this.value.toLowerCase();

    $categories.each(function (index, category) {
      var $category = $(category)
      var $category_name = $category.find('h2').text().toLowerCase();

      if ($category_name.startsWith(currentName)) {
        $category.show();
      } else {
        $category.hide();
      }
    });
  });

  $('#order_status').on('change', function () {
    var currentStatus = $('#order_status :selected').text()

    $orders.each(function (index, order) {
      var $order = $(order);
      var $order_status = $order.find('.order_status').text();

      if ($order_status === currentStatus || currentStatus === 'all') {
        $order.show();
      } else {
        $order.hide();
      }
    });
  });
});
