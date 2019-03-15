RSpec.describe Client do
  it 'has a version number' do
    expect(MultipleApiChecker::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end

  subject { described_class.new(bank_api) }

  context 'when bank api does not registered' do
    let(:bank_api) { (0...8).map { rand(65..90).chr }.join }

    it { expect { subject }.to raise_error(RuntimeError) }
  end

  context 'when bank api registered' do
    let(:bank_api) { (0...8).map { rand(65..90).chr }.join }

    context 'when service does not registered' do
      let(:service) { (0...8).map { rand(65..90).chr }.join }
      it { expect { subject.call(service) }.to raise_error(RuntimeError) }
    end
  end
end
