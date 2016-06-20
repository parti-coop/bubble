//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.validate
//= require kakao
//= require jssocials
//= require lightslider

$.is_blank = function (obj) {
  if (!obj || $.trim(obj) === "") return true;
  if (obj.length && obj.length > 0) return false;

  for (var prop in obj) if (obj[prop]) return false;
  return true;
}


Kakao.init('6cd2725534444560cb5fe8c77b020bd6');

// youtube

var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var global_video_players = {};

function onYouTubeIframeAPIReady() {
  var videos = $('.player iframe');
  for (var i = 0; i < videos.length; i++) {
    var current_id = videos[i].id;
    global_video_players[current_id] = new YT.Player(current_id);
  }

  $('#image-gallery').lightSlider({
    gallery: true,
    item: 1,
    thumbItem: 9,
    slideMargin: 0,
    speed: 500,
    pause: 10000,
    auto: true,
    loop: true,
    thumbItem: 6,
    onSliderLoad: function() {
      $('#image-gallery').removeClass('cS-hidden');
    },
    onBeforeSlide: function() {
      $.each(global_video_players, function(id, video) {
        video.stopVideo();
      });
    }
  });
}

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
  $('[data-action="bubble-share"]').each(function(i, elm) {
    var $elm = $(elm);

    var url = $elm.data('share-url');
    var text = $elm.data('share-text');
    var share = $elm.data('share-provider');
    if ($.is_blank(share)) return;
    var image_url = $elm.data('share-image');
    var image_width = $elm.data('share-image-width');
    var image_height = $elm.data('share-image-height');

    switch(share) {
    case 'kakao-link':
      Kakao.Link.createTalkLinkButton({
        container: elm,
        label: text,
        image: {
          src: image_url,
          width: image_width,
          height: image_height
        },
        webLink: {
          text: '바글시민 와글입법에서 보기',
          url: url
        }
      });
    break
    case 'kakao-story':
      $elm.on('click', function(e) {
        Kakao.Story.share({
          url: url,
          text: text
        });
      });
    break
    default:
      $elm.jsSocials({
        showCount: true,
        showLabel: false,
        shares: [share],
        text: text,
        url: url
      });
    }
  });
});
