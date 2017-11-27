require 'papa/helper/path'

module Papa
  module Helper
    class Vi
      attr_accessor :path, :branches

      def initialize
        @path = Helper::Path.generate_vi_file_path
        @branches = []
      end

      def run
        initialize_file
        prompt_vi
        read_from_file
        delete_file
        validate_branches
        branches
      end

      private

      def initialize_file
        content = <<-CONTENT
# Add your branches here. One branch name per line.
# Lines starting in pound (#) will be ignored
# Sample:
# feature/1-add-butterfree-gem
# feature/2-add-beedrill-gem
        CONTENT
        File.open(path, 'w') { |file| file.write(content) }
      end

      def prompt_vi
        system('vi', path)
      end

      def read_from_file
        @branches = File.read(path).chomp.split("\n").map do |branch|
          branch.strip!
          if branch.empty? || branch[0] == '#'
            nil
          else
            branch
          end
        end.compact
      end

      def delete_file
        Command.new("rm #{path}", silent: true).run
      end

      def validate_branches
        if @branches.empty?
          Helper::Output.failure 'No branches specified.'
          exit 1
        end
      end
    end
  end
end
