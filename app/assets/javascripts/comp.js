$(document).ready(function() {
  console.log('loaded');

$('#ccs_login').on('ajax:success', function(event, data, status, xhr) {
  console.log(data)
}).on('ajax:error', function(e, xhr, status, error) {
  console.log(status);
});

  


});
