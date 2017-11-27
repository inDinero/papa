require 'papa/command/base'

module Papa
  module Command
    module Git
      class Tag < Command::Base
        def initialize(tag_name)
          command = "git tag #{tag_name}"
          super(command)
        end
      end
    end
  end
end
