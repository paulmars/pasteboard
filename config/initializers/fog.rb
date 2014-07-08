CarrierWave.configure do |config|
  if ENV["AWSKEY"] && ENV["AWSSECRET"]
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV["AWSKEY"],                        # required
      :aws_secret_access_key  => ENV["AWSSECRET"],                        # required
      # :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
      # :host                   => 's3.example.com',             # optional, defaults to nil
      # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
  end

  if Rails.env.production?
    config.fog_directory  = "pasteboardfiles"
  else
    config.fog_directory  = "pasteboardfilesdev"
  end

  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
