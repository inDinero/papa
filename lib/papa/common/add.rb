module Papa
  class Common::Add
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      success = true
      @success_branches = []
      @failed_branches = []

      Output.stdout "Started adding branches to #{@build_branch.bold}."

      @branches.each_with_index do |branch, index|
        Output.stdout "Adding branch #{branch.bold} (#{index + 1} of #{@branches.count})..."
        queue = CommandQueue.new
        queue.add Git.fetch(remote: 'origin')
        queue.add Git.checkout(branch_name: @build_branch)
        queue.add Git.checkout(branch_name: branch)
        queue.add Git.hard_reset(remote: 'origin', branch_name: branch)
        queue.add Git.rebase(base_branch_name: @build_branch)
        queue.add Git.force_push(remote: 'origin', branch_name: branch)
        queue.add Git.checkout(branch_name: @build_branch)
        queue.add Git.merge(branch_name: branch)
        queue.add Git.push(remote: 'origin', branch_name: @build_branch)

        resp = queue.run
        if resp[:success]
          @success_branches << branch
        else
          failed_branch = {
            branch: branch,
            message: resp[:message]
          }
          @failed_branches << failed_branch
          success = false
        end
      end

      success_message
      failure_message

      if success
        success_cleanup
      else
        failure_cleanup
        exit 1
      end
    end

    private

    def success_cleanup
      queue = CommandQueue.new
      @branches.each { |branch| queue.add Git.delete_branch(branch_name: branch) }
      queue.run
    end

    def success_message
      return if @success_branches.empty?
      output = ''
      output << "Successfully added these branches to #{@build_branch}:\n"
      @success_branches.each_with_index do |branch, index|
        output << "  #{index + 1}.) #{branch}\n"
      end
      Output.success output
    end

    def failure_cleanup
    end

    def failure_message
      return if @failed_branches.empty?

      output = ''

      output << "Failed to add these branches to #{@build_branch}:\n"
      @failed_branches.each_with_index do |failed_branch, index|
        branch = failed_branch[:branch]
        message = failed_branch[:message]
        output << "  #{index + 1}.) #{branch}\n"
        output << "      - #{message}\n"
      end

      output << "\n"

      branch_names = @failed_branches.map { |f| f[:branch] }

      output << "When the above problems are resolved, you can re-run this with:\n"
      output << "  papa #{@build_type} add -v #{@version} -b #{branch_names.join(' ')}"

      Output.failure output
    end
  end
end
