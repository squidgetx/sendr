var form_error = function(element, message) {
  element.addClass("error");
  element.append(message);
}

$(document).ready(function() {

  $('#ccs_login').on('ajax:success', function(event, data, status, xhr) {
    if (data.error) {
      if (data.message === "form_error") {
        form_error($('#ccs_login'),"Please enter a valid CCS number");
      } else {
        // redirect to new user page
        $('#new_climber'.removeClass("hidden"));
      }
    }
  }).on('ajax:error', function(e, xhr, status, error) {
  });

});

