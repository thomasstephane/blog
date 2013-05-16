$(document).ready(function() {
  $("div.published-status p").append('<a class="radio-select" href="#"></a><a class="radio-deselect" href="#"></a>');

  $('.published-status .radio-select').click(function(event) {
    event.preventDefault();
    var $boxes = $(this).parent().parent().children();
    $boxes.removeClass('selected');
    $(this).parent().addClass('selected');
    $(this).parent().find(':radio').attr('checked','checked');
  });

  $('.published-status .radio-deselect').click(function(event){
    event.preventDefault();
    $(this).parent().removeClass('selected');
    $(this).parent().find(':radio').removeAttr('checked');
  });
});
