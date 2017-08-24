module IndFlow
  class Common::Merge
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      queue = CommandQueue.new

      @base_branches.each do |branch|
        queue.add Git.checkout(branch_name: branch)
        queue.add Git.merge(branch_name: @build_branch)
        queue.add Git.push(remote: 'origin', branch_name: branch)

        if @tag_name && branch == 'master'
          queue.add Git.tag(tag_name: @version)
          queue.add Git.push_tag(remote: 'origin', tag_name: @version)
        end
      end

      queue.list_queue
    end
  end
end
