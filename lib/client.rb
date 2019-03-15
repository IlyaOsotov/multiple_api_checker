require 'multiple_api_checker/version'
require 'first_bank_api_client'
require 'second_bank_api_client'

class Client
  REGISTERED_APIS = %i[bank_api_first bank_api_second].freeze
  REGISTERED_SERVICES = %i[movement_list].freeze

  def initialize(bank_api)
    @bank_api = bank_api(bank_api)
  end

  def call(service, params = {}, headers = {})
    raise "not registered service #{service}" unless REGISTERED_SERVICES.include? service

    @bank_api.call(service, params, headers)
  end

  private

  def bank_api(bank_api)
    case bank_api
    when :bank_api_first
      FirstBankApiClient.new
    when :bank_api_second
      SecondBankApiClient.new
    else
      raise "not registered api #{bank_api}"
    end
  end
end
