require 'securerandom'

module Papa
  class Helpers::Path
    VI_FILE_PATH = '/tmp/papa-vi-RAND.txt'

    def self.generate_vi_file_path
      VI_FILE_PATH.sub('RAND', uuid_gen)
    end

    def self.uuid_gen
      SecureRandom.uuid
    end
  end
end
