$(document).ready(function () {
  var $artists = $('.artist');
  var $categories = $('.category');

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
});
