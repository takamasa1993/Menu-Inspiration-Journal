document.addEventListener('turbolinks:load', function() {
  document.addEventListener('ajax:success', function(event) {
    var element = event.target;
    var postId = element.getAttribute('data-post-id');
    var likesCountElement = document.querySelector('#likes-count-' + postId);

    if (likesCountElement) {
      var data = event.detail[0];
      if (data && data.likes_count !== undefined) {
        likesCountElement.innerText = data.likes_count;

        var likeButton = document.querySelector('.like-button[data-post-id="' + postId + '"]');
        if (likeButton) {
          if (likeButton.classList.contains('btn-primary')) {
            likeButton.classList.remove('btn-primary');
            likeButton.classList.add('btn-danger');
            likeButton.innerText = 'いいねを取り消す';
            likeButton.setAttribute('href', '/posts/' + postId + '/likes');
            likeButton.setAttribute('data-method', 'delete');
          } else {
            likeButton.classList.remove('btn-danger');
            likeButton.classList.add('btn-primary');
            likeButton.innerText = 'いいね';
            likeButton.setAttribute('href', '/posts/' + postId + '/likes');
            likeButton.setAttribute('data-method', 'post');
          }
        } else {
          console.error('likeButtonが見つかりませんでした');
        }
      } else {
        console.error('likes_countが取得できませんでした');
      }
    } else {
      console.error('likesCountElementが見つかりませんでした');
    }
  });
});