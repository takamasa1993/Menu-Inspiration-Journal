/* global $ */
document.addEventListener('turbolinks:load', function() {
  $(document).on('ajax:success', function(event) {
    var detail = event.detail[0];
    if (detail && (detail.action === 'followed' || detail.action === 'unfollowed')) {
      var followButtonContainer = $('#follow-button-container');
      if (followButtonContainer.length) {
        followButtonContainer.html(detail.button_html);
      }
    }
  });
});