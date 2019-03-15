require 'faraday'
require 'bank_api_client'

class SecondBankApiClient < BankApiClient
  def call(_service, params, _headers)
    token = login('http://bank_api_first.com/', params['login'], params['password'])
  end
end
