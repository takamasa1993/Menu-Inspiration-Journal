// app/javascript/packs/application.js

import 'bootstrap'
import "../stylesheets/application"
import "../stylesheets/user/homes.scss"
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '../packs/image_preview';
import '../packs/like_post';
import '../packs/follow';
import $ from 'jquery';

global.$ = $;
global.jQuery = $;

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll('.add_fields').forEach(button => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      const time = new Date().getTime();
      const container = document.querySelector('.fields-container');
      const regexp = new RegExp(button.dataset.id, 'g');
      if (container) {
        container.insertAdjacentHTML('beforeend', button.dataset.fields.replace(regexp, time));
      } else {
        console.error("fields-containerが見つかりません");
      }
    });
  });

  document.addEventListener('click', function(e) {
    if (e.target && e.target.classList.contains('remove_fields')) {
      e.preventDefault();
      const field = e.target.closest('.nested-fields');
      if (field) {
        field.remove();
      } else {
        console.error("nested-fieldsが見つかりません");
      }
    }
  });
});

