unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV["AWS_ID"],
      aws_secret_access_key: ENV["AWS_ACCESS"],
      region: ENV["AWS_REGION"]
    }

    config.fog_directory  = ENV["AWS_PACKET"]
    config.cache_storage = :fog
  end
end 