// 画像プレビュー
$(document).on('change', 'input[type=file]', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $('.preview-course-image').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
});