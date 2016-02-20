var form_error = function(element, message) {
  element.addClass("error");
  element.append(message);
}

$(document).ready(function() {
  $('.datepicker').pickadate();


  $('#ccs_login').on('ajax:success', function(event, data, status, xhr) {
    if (data.error) {
      if (data.message === "form_error") {
        form_error($('#ccs_login'),"Please enter a valid CCS number");
      } else {
        // redirect to new user page
        $('#new_climber').removeClass("hidden");
        $('#sign-in').addClass("hidden");
        $('#climber_ccs_id').val(data.data);
      }
    } else {
      window.location.href = data.data;
    }
  }).on('ajax:error', function(e, xhr, status, error) {
  });

});

