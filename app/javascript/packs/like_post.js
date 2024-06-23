document.addEventListener('DOMContentLoaded', function() {
  document.addEventListener('ajax:success', function(event) {
    var element = event.target;
    var postId = element.getAttribute('data-post-id');
    var likesCountElement = document.querySelector('#likes-count-' + postId);
    likesCountElement.innerText = event.detail[0].likes_count;
  });
});