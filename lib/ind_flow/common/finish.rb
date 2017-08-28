module IndFlow
  class Common::Finish
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      exit_status = 0

      @base_branches.each do |branch|
        queue = CommandQueue.new
        queue.add Git.fetch(remote: 'origin')
        queue.add Git.checkout(branch_name: @build_branch)
        queue.add Git.checkout(branch_name: branch)
        queue.add Git.merge(branch_name: @build_branch)
        queue.add Git.push(remote: 'origin', branch_name: branch)
        if @tag_name && branch == 'master'
          queue.add Git.tag(tag_name: @tag_name)
          queue.add Git.push_tag(remote: 'origin', tag_name: @tag_name)
        end
        if !queue.run
          exit_status = 1
        end
        
        exit exit_status
      end
    end
  end
end
