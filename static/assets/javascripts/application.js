$(function() {
  // Mailchimp newsletter
  $('.newsletter form').ajaxChimp({
    callback: kongAjaxChimpCallback
  });
  function kongAjaxChimpCallback() {
    if (resp.result === 'success') {
      mixpanel.track(
      "Subscribed to newsletter",
        { "Name": social_link }
      );
    }
  }

  // Scroll the title like it's 1999!
  // Credits: http://stackoverflow.com/a/16354191
  var original_title = document.title;
  $(".no-touch .products__product, .no-touch .product__add-to-cart button").hover(
    function() {
      (function titleScroller(text) {
        document.title = text;
        titleScroll = setTimeout(function () {
            titleScroller(text.substr(1) + text.substr(0, 1));
        }, 100);
      }(" BUY NOW BUY NOW BUY NOW BUY NOW"));
    }, function() {
      document.title = original_title;
      clearTimeout(titleScroll);
    }
  );

  // Open social links and blog posts in new window
  $('.social-links a, .about-page__tumblr-posts a').attr('target', '_blank');

  // Mixpanel tracking
  $('.social-links a').on('click', function() {
    var social_link = $(this).attr('data-name');
    mixpanel.track(
      "Clicked social link",
      { "Name": social_link }
    );
  });
  $('.about-page__tumblr-posts a').on('click', function() {
    var tumblr_link = $(this).attr('href');
    mixpanel.track(
      "Clicked blog post",
      { "URL": tumblr_link }
    );
  });
});
