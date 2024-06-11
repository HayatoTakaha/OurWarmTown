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
});
