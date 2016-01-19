$(document).ready(function () {
  var $artists = $('.artist');
  var $categories = $('.category');
  var $orders = $('.order');

  $('#artist_filter_name').on('keypress', function () {
    var currentName = this.value.toLowerCase();

    $artists.each(function (index, artist) {
      var $artist = $(artist);
      var $artistName = $artist.find('h2 span').text().toLowerCase();

      if ($artistName.startsWith(currentName)) {
        $artist.show();
      } else {
        $artist.hide();
      }
    });
  });

  $('#category_filter_name').on('keypress', function () {
    var currentName = this.value.toLowerCase();

    $categories.each(function (index, category) {
      var $category = $(category);
      var $categoryName = $category.find('h2').text().toLowerCase();

      if ($categoryName.startsWith(currentName)) {
        $category.show();
      } else {
        $category.hide();
      }
    });
  });

  $('#order_status').on('change', function () {
    var currentStatus = $('#order_status :selected').text();

    $orders.each(function (index, order) {
      var $order = $(order);
      var $orderStatus = $order.find('.order_status').text();

      if ($orderStatus === currentStatus || currentStatus === 'all') {
        $order.show();
      } else {
        $order.hide();
      }
    });
  });
});
