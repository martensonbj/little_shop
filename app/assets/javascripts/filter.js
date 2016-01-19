$(document).ready(function () {
  var $artists = $('.artist');

  $('#artist_filter_name').on('keypress', function () {
    var currentName = this.value;
    $artists.each(function (index, artist) {
      var $artist = $(artist)
      var $artist_name = $artist.find('h2').text();

      if ($artist_name.startsWith(currentName)) {
        $artist.show();
      } else {
        $artist.hide();
      }
    });
  });
});
