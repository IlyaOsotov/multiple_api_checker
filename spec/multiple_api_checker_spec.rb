# rubocop:disable Metrics/BlockLength
RSpec.describe Client do
  subject { described_class }

  context 'when bank api does not registered' do
    let(:bank_api) { Array.new(8) { ('a'..'z').to_a.sample }.join }

    it { expect { subject.new(bank_api) }.to raise_error(RuntimeError) }
  end

  described_class::REGISTERED_APIS.each do |bank_api|
    context "when bank api registered #{bank_api}" do
      context 'when service does not registered' do
        let(:service) { Array.new(8) { ('a'..'z').to_a.sample }.join }
        it { expect { subject.new(bank_api).call(service) }.to raise_error(RuntimeError) }
      end

      described_class::REGISTERED_SERVICES.each do |service|
        context "when service registered #{service}" do
          context 'when incorrect login/password' do
            let(:incorrect_text) { Array.new(8) { ('a'..'z').to_a.sample }.join }
            let(:incorrect_login) { { login: incorrect_text, password: incorrect_text } }
            it {
              expect do
                subject.new(bank_api).call(service)
              end.to raise_error('401 unauthorized')
            }
            it {
              expect do
                subject.new(bank_api).call(service, incorrect_login)
              end.to raise_error('401 unauthorized')
            }
          end
        end
      end
    end
  end

  context "movement_list service when correct login/password" do
    let(:correct_login) { { login: 'log', password: 'pass' } }

    before do
      stub_request(:post, /.+/)
        .with(
          headers: {
            'Auth-Token' => /.+/,
            'Content-Type' => 'application/json'
          }
        ).to_return(status: 200, body: result)
    end

    context "in bank_api_first" do
      let(:bank_api) { :bank_api_first }
      let(:data) { { ean: '40000000000000000000', dateGte: '2018-09-01' } }
      let(:result) { [{ ean: '40000000000000000000', amount: 10_003 }] }

      subject do
        described_class.new(bank_api).call(described_class::REGISTERED_SERVICES.first,
                                           correct_login,
                                           data)
      end

      it { expect(subject).to eq(result) }      
    end
    
    context "in bank_api_second" do      
      let(:bank_api) { :bank_api_second }
      let(:data) { { ean: '40000000000000000000', date_gte: '2018-09-01' } }
      let(:result) { [{ cean: '40000000000000000000', r320: 10_003 }] }
    
      subject do
        described_class.new(bank_api).call(described_class::REGISTERED_SERVICES.first,
                                           correct_login,
                                           data)
      end
    
      it { expect(subject).to eq(result) }
    end
  end
end
# rubocop:enable Metrics/BlockLength
