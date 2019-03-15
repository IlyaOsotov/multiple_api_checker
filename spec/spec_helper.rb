require 'bundler/setup'
require 'client'
require 'webmock/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  WebMock.disable_net_connect!(allow_localhost: true)

  config.before do |_config|
    stub_request(:get, /login/)
      .with(query: { 'login' => 'log', 'password' => 'pass' })
      .to_return(body: (0...8).map { rand(65..90).chr }.join, status: 200)

    stub_request(:get, /login/)
      .with(query: hash_excluding('login' => 'log', 'password' => 'pass'))
      .to_return(body: '', status: 401)
  end
end
