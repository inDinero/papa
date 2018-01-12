require 'papa/command/base'
require 'papa/helper/config'
require 'json'

module Papa
  module Command
    module Slack
      class SendMessage < Command::Base
        def initialize(build_type, hostname, action)
          @build_type = build_type
          @hostname = hostname
          @action = action

          command = "curl -X POST --data-urlencode 'payload=#{payload.to_json}' #{webhook_url}"
          super(command)
        end

        private

        def payload
          url = "https://#{@hostname}.indinerocorp.com"
          {
            'text' => "<!channel> Deployment to <#{url}|#{@hostname}> #{@action}."
          }
        end

        def webhook_url
          Helper::Config.read["slack_webhook"]
        end
      end
    end
  end
end
