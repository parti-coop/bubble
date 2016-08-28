//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.validate
//= require messages_ko
//= require kakao
//= require jssocials
//= require lightslider
//= require unobtrusive_flash
//= require unobtrusive_flash_bootstrap
//= require imageMapResizer
//= require autoresize

UnobtrusiveFlash.flashOptions['timeout'] = 2000;

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

  $('[data-action="video-show"]').on('click', function(e) {
    $elm = $(this);
    $video_player_group = $($elm.data('video-group'));
    $video_navigator_group = $($elm.data('navigator-group'));
    $video_player = $($elm.data('target'));

    $.each(global_video_players, function(id, video) {
      if(typeof video.stopVideo == 'function') {
        video.stopVideo();
      }
    });

    $video_player_group.hide();
    $video_navigator_group.removeClass('active');
    $video_player.show();
    $elm.addClass('active');
  });
}

var prepare_posts_list = function($base) {
  $base.find('[data-action="clickable-row"]').on('click', function(e) {
    window.document.location = $(this).data("href");
  });
}

var prepare_social_share = function($base) {
  $base.find('[data-action="bubble-share"]').each(function(i, elm) {
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
        showCount: false,
        showLabel: false,
        shares: [share],
        text: text,
        url: url
      });
    }
  });
}

$(function(){

  $('map').imageMapResize();

  $.validator.addMethod("recaptcha", function(value, element) {
    if(typeof grecaptcha != 'undefined') {
      var recaptcha_id = $(element).data('recaptcha-id');
      return grecaptcha.getResponse(recaptcha_id).length > 0;
    }

    return true;
  }, '');

  $('form#new_comment, form.edit_comment').validate({
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
      if($(element).attr('name') == 'hiddenRecaptcha') {
        error.prependTo(element.closest('form').find('.recaptcha'));
      } else {
        return true;
      }
    }
  });

  $('form#new_post, form.edit_post').validate({
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
      if($(element).attr('name') == 'hiddenRecaptcha') {
        error.prependTo(element.closest('form').find('.recaptcha'));
      } else {
        return true;
      }
    }
  });

  // 쟁점토론 유효성검사
  $('form.new_opinion').each(function() {
    $(this).validate({
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
        if($(element).attr('name') == 'hiddenRecaptcha') {
          error.prependTo(element.closest('form').find('.recaptcha'));
        } else {
          return true;
        }
      }
    });
  });

  $('[data-action="bubble-naming-option"]').change(function() {
    $($(this).data('sibling')).removeClass("selected")
    $(this).closest("label").toggleClass("selected", this.checked);
  });

  prepare_posts_list($('html'));
  prepare_social_share($('html'));

  autosize($('[data-action="parti-autoresize"]'));

  $('[data-action="bubble-show"]').click(function() {
    $($(this).data('target')).fadeIn("slow");
    if($(this).data('self-hide')) {
      $(this).parent().hide();
    }
    $(this).parents('#video-summary').css({'background-color': '#f29a76'});
  });

  $('#post-writing-form').hide();
  $('[data-action="call-post-writing-form"]').click(function() {
    $('#post-list').hide();
    $(this).hide();
    $('#post-writing-form').show();
  });

  $('[data-action="bubble-channel"]').hover(function(e){
    $('.receive-news__off').hide();
    $('.receive-news__on').show();
  }, function() {
    $('.receive-news__off').show();
    $('.receive-news__on').hide();
  });
});

