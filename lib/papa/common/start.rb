module Papa
  class Common::Start
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      queue = CommandQueue.new
      queue.add Git.fetch(remote: 'origin')
      queue.add Git.checkout(branch_name: @base_branch)
      queue.add Git.branch(branch_name: @build_branch)
      queue.add Git.checkout(branch_name: @build_branch)
      queue.add Git.push(remote: 'origin', branch_name: @build_branch)
      if queue.run
        success_message
      else
        failure_message
        exit 1
      end
    end

    private

    def success_message
      Output.stdout "Successfully started new #{@build_type} branch #{@build_branch}"
    end

    def failure_message
      Output.stderr "There was a problem starting #{@build_type} branch: #{@build_branch}"
    end
  end
end