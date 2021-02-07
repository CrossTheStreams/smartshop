class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  connects_to shards: {
    primary: { writing: :primary, reading: :primary },
    remote: { writing: :remote, reading: :remote }
  }
end
