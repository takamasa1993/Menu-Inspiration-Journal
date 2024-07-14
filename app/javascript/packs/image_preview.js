document.addEventListener('DOMContentLoaded', () => {
  const imageInput = document.getElementById('post_image');
  const imagePreview = document.getElementById('image_preview');

  if (imageInput && imagePreview) {
    imageInput.addEventListener('change', event => {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = e => {
          imagePreview.src = e.target.result;
        };
        reader.readAsDataURL(file);
      }
    });
  }
});