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

          @user_whoami = `whoami`.chomp
          @user_hostname = `hostname`.chomp

          command = "curl -X POST --data-urlencode 'payload=#{payload.to_json}' #{webhook_url}"
          super(command)
        end

        private

        def payload
          { 'text' => message }
        end

        def webhook_url
          Helper::Config.read["slack_webhook"]
        end

        def message
          url = "https://#{@hostname}.indinerocorp.com"
          message = "<!channel> Deployment to <#{url}|#{@hostname}> #{@action}"
          message << " by #{@user_whoami} at #{@user_hostname}" if @action == 'started'
          message << '.'
          message
        end
      end
    end
  end
end
