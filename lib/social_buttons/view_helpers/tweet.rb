module SocialButtons
  module Tweet
    include SocialButtons::Assistant

    TWITTER_SHARE_URL = "//twitter.com/share"
    CLASS = "twitter-share-button"

    def tweet_button(options = {})
      clazz = SocialButtons::Tweet

      # JUNK Code! Refactor!!!!
      params = {}

      params.merge!(url: request.url)
      opt_params = clazz.default_options.merge(options)

      params = clazz.options_to_data_params(opt_params)
      params.merge!(:class => CLASS)

      html = "".html_safe
      html << clazz::Scripter.new(self).script
      html << link_to("Tweet", TWITTER_SHARE_URL, params)
      html
    end

    class << self
      def default_options
        @default_options ||= {
          via:    "tweetbutton",
          text:   "",
          count:  "vertical",
          lang:   "en",
          related: ""
        }
      end
    end

    class Scripter < SocialButtons::Scripter
      def script
        return empty_content if widgetized? :tweet
        widgetized! :tweet
        "<script src=#{twitter_wjs} type='text/javascript'></script>".html_safe
      end

      def twitter_wjs
        "//platform.twitter.com/widgets.js"
      end
    end # class
  end
end
