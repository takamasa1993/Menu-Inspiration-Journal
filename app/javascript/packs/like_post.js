document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.like-form').forEach(function(form) {
    form.addEventListener('ajax:success', function(event) {
      var detail = event.detail[0];
      var postId = detail.post_id;
      var likesCountElement = document.querySelector('#likes-count-' + postId);
      likesCountElement.innerText = detail.likes_count;

      var likeButton = form.querySelector('.like-button');
      if (detail.liked) {
        likeButton.value = 'いいねを取り消す';
        likeButton.classList.remove('btn-primary');
        likeButton.classList.add('btn-danger');
        form.setAttribute('action', '/posts/' + postId + '/likes');
        form.setAttribute('method', 'delete');
      } else {
        likeButton.value = 'いいね';
        likeButton.classList.remove('btn-danger');
        likeButton.classList.add('btn-primary');
        form.setAttribute('action', '/posts/' + postId + '/likes');
        form.setAttribute('method', 'post');
      }
    });

    form.addEventListener('ajax:error', function(event) {
      console.error('Ajax error', event);
    });
  });
});