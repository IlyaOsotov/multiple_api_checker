require 'bank_api_client'

class FirstBankApiClient < BankApiClient
  def call(service, login, params)
    token = login('http://bank_api_first.com/', login[:login], login[:password])
    call_service("http://bank_api_first.com/corp/#{service}", params, token)
  end
end
