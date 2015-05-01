CarrierWave.configure do |config|
  config.fog_provider = 'AWS'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAICYYWPNDZBPFTOEA',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'us-west-2',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = :file                          # required
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end