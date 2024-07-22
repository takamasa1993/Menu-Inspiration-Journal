document.addEventListener("DOMContentLoaded", () => {
  const imageInput = document.getElementById('post_image');
  const imagePreview = document.getElementById('image_preview');

  if (imageInput) {
    imageInput.addEventListener('change', function() {
      const file = this.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(event) {
          imagePreview.src = event.target.result;
        }
        reader.readAsDataURL(file);
      }
    });
  }
});

// Turbolinksを無効化する処理を追加
document.addEventListener("turbolinks:before-visit", function(event) {
  const form = document.querySelector('form');
  if (form) {
    form.setAttribute('data-turbolinks', 'false');
  }
});