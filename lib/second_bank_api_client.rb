require 'faraday'
require 'bank_api_client'

class SecondBankApiClient < BankApiClient
  def call(service, login, params)
    token = login('http://bank_api_first.com/', login[:login], login[:password])
    call_service("http://bank_api_second.com/services/#{service}", params, token)
  end
end
