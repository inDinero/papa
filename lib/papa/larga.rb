module Papa
  class Larga
    RELEASE_OR_HOTFIX_LIFESPAN = '3d'
    DEFAULT_LIFESPAN = '4h'
    RELEASE_OR_HOTFIX_PROTECTION = 'off'
    DEFAULT_PROTECTION = 'on'

    def self.type
      Larga::Type.new
    end

    def self.deploy(branch:, lifespan: DEFAULT_LIFESPAN, protection: DEFAULT_PROTECTION, hostname: nil)
      require 'papa/larga/deploy'

      Larga::Deploy.new(branch, lifespan, protection, hostname)
    end
  end
end
