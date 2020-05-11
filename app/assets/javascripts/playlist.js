$(function(){

  function  addPlaylist (playlist){
    if (playlist.image.url) {
    var html = `
                <li class="jackets__image">
                  <a href="/playlists/${playlist.id}/adds"">
                    <div class="jackets__image__existing">
                      <img src="${playlist.image.url}">
                    </div>
                  </a>
                  <div class="jackets__image__mood">
                  
                  </div>
                  <div class="jackets__image__place">
                    Situation : ${playlist.name}
                  </div>
                </li>
              `;
              $("#playlist__search-result").append(html);
    } else {
    var html = `
                <li class="jackets__image">
                <a href="/playlists/${playlist.id}/adds"">
                  <div class="jackets__image__existing">
                    <img src="/images/スクリーンショット 2020-04-08 22.33.25.jpeg">
                  </div>
                </a>
                <div class="jackets__image__place">
                  Situation : ${playlist.name}
                </div>
                </li>
              `;
              $("#playlist__search-result").append(html);
    };
  }

  function  addNoPlaylist (){
    var html = `
                <center id="noPlaylist">No results found</center>
                <center id="noPlaylist-explanation">Please make sure your words are spelled correctly or use less<br> or different kyewords.</center>
              `;
              $("#playlist__search-result").append(html);
  };

  $("#playlist__search-field").on('keyup', function(){
    var input = $(this).val();
    $.ajax({
      type: "GET",
      url: "playlists",
      dataType: 'json',
      data: {keyword: input},
    })
    .done(function(playlistsData) {
      $("#playlist__search-result").empty();
      $(".deleteContent").remove();
      if (playlistsData.length !== 0) {   //検索にヒットした情報が1件以上だったら
        //返されたjsonデータの個数分処理を繰り返す
        playlistsData.forEach(function(playlist) {
            //一人一人のユーザー情報(data)をブラウザに表示する任意のメソッド
          addPlaylist (playlist);
          console.log(playlist);
        });
      } else {
          addNoPlaylist ();
      }
    })
    //変換失敗
    .fail(function() {
        alert('通信エラーです。プレイリストが表示できません。');
    })
  });
});