// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//

$(document).ready(function() {
  $('.c-edit').on('click', function() {
    var id = $(this).data('id');
    console.log(id);
    var div = $('#display'+id).toggleClass('hidden');
    var input = $('#form' + id).toggleClass('hidden');
  });

  $('.new-college').on('click', function() {
    $('.cnew').toggleClass('hidden');
  });
    




});
