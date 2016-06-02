//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.validate


$(function(){

  $.validator.addMethod("recaptcha", function(value, element) {
    return grecaptcha.getResponse().length > 0;
  }, '');
  $form = $('#new_comment');
  $form.validate({
    ignore: ".ignore",
    rules: {
      "hiddenRecaptcha": {
        recaptcha: true
      }
    },
    messages: {
      "hiddenRecaptcha": {
        recaptcha: "로봇이 아닌지 확인해 주세요."
      }
    },
    errorPlacement: function(error, element) {
      if($(element).attr('id') == 'hiddenRecaptcha') {
        error.prependTo($('.recaptcha'));
      } else {
        return true;
      }
    }
  });
});

