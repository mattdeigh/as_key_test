Rails.configuration.to_prepare do
  ActiveStorage::Blob.class_eval do
    before_create :generate_key_with_prefix
    @@modified_key = nil

    def generate_key_with_prefix
      self.key = File.join param_key, self.class.generate_unique_secure_token
    end

    def param_key
      if @@modified_key
        @@modified_key
      else
        'active_storage'
      end
    end
  end
end