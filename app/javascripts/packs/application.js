import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import 'bootstrap';
import '../stylesheets/application';
import $ from 'jquery';

document.addEventListener("turbolinks:load", function() {
  Rails.start();
  $(document).on('click', '[data-confirm]', function(e) {
    var message = $(this).data('confirm');
    if (!confirm(message)) {
      e.preventDefault();
      e.stopImmediatePropagation();
    }
  });

  $(document).on('ajax:success', 'a[data-method="delete"]', function(e) {
    console.log('DELETE request sent successfully');
  }).on('ajax:error', 'a[data-method="delete"]', function(e) {
    console.log('Error sending DELETE request');
  });
});
