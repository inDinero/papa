module Papa
  class Larga
    RELEASE_OR_HOTFIX_LIFESPAN = '3d'
    DEFAULT_LIFESPAN = '4h'
    RELEASE_OR_HOTFIX_PROTECTION = 'off'
    DEFAULT_PROTECTION = 'on'

    def self.deploy(branch:, lifespan: DEFAULT_LIFESPAN, protection: DEFAULT_PROTECTION, hostname: nil)
      options = []
      options << '-action deploy',
      options << "-branch #{branch}",
      options << "-lifespan #{lifespan}",
      options << "-protection #{protection}",
      if hostname
        options << "-hostname #{hostname}"
      end
      Command.new "larga #{options.join(' ')}"
    end
  end
end
