require 'multiple_api_checker/version'

class Client
  REGISTERED_APIS = %i[bank_api_first bank_api_second].freeze

  def initialize(bank_api)
    @bank_api = bank_api(bank_api)
  end

  def call; end

  private

  def bank_api(bank_api)
    raise "not registered api #{bank_api}" unless REGISTERED_APIS.include? bank_api.to_sym
  end
end
