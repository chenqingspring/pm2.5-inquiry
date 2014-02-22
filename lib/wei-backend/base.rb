module WeiBackend
  class MessageDispatcher
    attr_accessor :params

    def on message_type, params
      @params = params
      results = send(:"handle_#{message_type.downcase}_message")
      create_model results
    end

    def handle_event_message
      send(:"handle_#{params[:Event].downcase}_message")
    end

    def create_model data
      case data
        when Hash, Array
          image_text_message(data)
        else
          text_message(data)
      end
    end

    def text_message(data)
      {
          :format => 'text',
          :model => {:content => data}.merge(account_info)
      }
    end

    def image_text_message model
      {
          :format => 'image_text',
          :model => {
              :article_count => model.is_a?(Array) ? model.length : 1,
              :articles => model.is_a?(Array) ? model : [model]
          }.merge(account_info)
      }
    end

    def account_info
      {
          :myAccount => params[:ToUserName],
          :userAccount => params[:FromUserName],
      }
    end

    class << self
      %w(text event voice location subscribe unsubscribe).each do |type|
        define_method(:"on_#{type}") do |&block|
          define_method(:"handle_#{type}_message", &block)
        end
      end

      def token str=nil
        return @token if str.nil?
        @token = str
      end
    end

  end

  module Delegator
    def self.delegate(*methods)
      methods.each do |method_name|
        define_method(method_name) do |*args, &block|
          Delegator.target.send(method_name, *args, &block)
        end
        private method_name
      end
    end

    delegate :on_text, :on_event, :on_voice, :on_location, :on_subscribe, :on_unsubscribe, :token

    class << self
      attr_accessor :target
    end

    self.target = MessageDispatcher
  end
end
