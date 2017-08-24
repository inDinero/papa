module IndFlow
  class Common::Merge
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      @base_branches.each do |branch|
        queue = CommandQueue.new
        queue.add Git.checkout(branch_name: @build_branch)
        queue.add Git.checkout(branch_name: branch)
        queue.add Git.merge(branch_name: @build_branch)
        queue.add Git.push(remote: 'origin', branch_name: branch)
        if @tag_name && branch == 'master'
          queue.add Git.tag(tag_name: @tag_name)
          queue.add Git.push_tag(remote: 'origin', tag_name: @tag_name)
        end
        if !queue.run
          break
        end
      end
    end
  end
end
