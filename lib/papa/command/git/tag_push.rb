require 'papa/command/base'

module Papa
  module Command
    module Git
      class TagPush < Command::Base
        def initialize(remote, tag_name)
          command = "git push #{remote} #{tag_name}"
          super(command)
        end
      end
    end
  end
end
