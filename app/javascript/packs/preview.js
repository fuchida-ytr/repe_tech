

$(function() {
    // previewボタンが押されたらイベント発火
    $('#preview-tab').on('click', function() {
      var text = $('.content_field').val();

      $.ajax({  
        url: '/api/preview',
        type: 'GET',
        dataType: 'json',
        data: { body: text }
      })
      .done(function(html) {
        // ajax成功したら、テキストエリアを非表示にする。
        $('.content_field').parent().css('display', 'none');
        $('#preview').append(html.body);
        // markdownボタンとpreviewボタンのdisabledを入れ替える。
        $('#write-tab').removeClass('disabled');
        $('#preview-tab').addClass('disabled');
      })
      .fail(function() {
        $('#preview').append("<p>failed for markdown preview</p>");
      })
    })
  
    // markdownボタンが押されたらイベント発火
    $('#write-tab').on('click', function() {
        $('.content_field').parent().css('display', '');
        $('#preview').empty();
        $('#preview-tab').removeClass('disabled');
    })
  })