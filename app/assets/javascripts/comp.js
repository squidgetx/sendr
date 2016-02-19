$(document).ready(function() {

$('#ccs_login').on('ajax:success', function(event, data, status, xhr) {
  console.log(data)
}).on('ajax:error', function(e, xhr, status, error) {
  console.log(status);
});

});

function signIn() {
  // Show sign-in modal dialog
  $('#signin').toggleClass('active');

}
