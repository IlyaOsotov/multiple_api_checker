RSpec.describe Client do
  it 'has a version number' do
    expect(MultipleApiChecker::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end

  subject { described_class }

  context 'when bank api does not registered' do
    let(:bank_api) { (0...8).map { rand(65..90).chr }.join }

    it { expect { subject.new(bank_api) }.to raise_error(RuntimeError) }
  end

  context 'when bank api registered' do
    described_class::REGISTERED_APIS.each do |bank_api|
      context 'when service does not registered' do
        let(:service) { (0...8).map { rand(65..90).chr }.join }
        it { expect { subject.new(bank_api).call(service) }.to raise_error(RuntimeError) }
      end

      context 'when service registered' do
        described_class::REGISTERED_SERVICES.each do |service|
          context 'when incorrect login/password' do
            let(:incorrect_text) { (0...8).map { rand(65..90).chr }.join }
            let(:incorrect_login) { { login: incorrect_text, password: incorrect_text } }
            it { expect(subject.new(bank_api).call(service)).to eq('401') }
            it { expect(subject.new(bank_api).call(service, incorrect_login)).to eq('401') }
          end
        end
      end
    end
  end
end
