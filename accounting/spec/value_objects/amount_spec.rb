require_dependency 'accounting'

module Accounting
  RSpec.describe 'Amount value object' do
    it { expect(Amount.new(1250, 'PLN').to_f).to                    eq(12.50) }
    it { expect(Amount.new(-250, 'GBP').to_f).to                    eq(-2.50) }

    it { expect(Amount.new(2400, 'GBP')).to                         eq Amount.new(2400, 'GBP') }
    it { expect(Amount.new(0, 'EUR')).not_to                        eq Amount.new(0, 'PLN') }

    it { expect(Amount.new(300, 'PLN') + Amount.new(200, 'PLN')).to eq Amount.new(500, 'PLN') }
    it { expect(Amount.new(300, 'PLN') - Amount.new(200, 'PLN')).to eq Amount.new(100, 'PLN') }

    it { expect{Amount.new(300, 'PLN') + Amount.new(200, 'EUR')}.to raise_error(ArgumentError) }
    it { expect{Amount.new(300, 'PLN') - Amount.new(200, 'EUR')}.to raise_error(ArgumentError) }

    it { expect(Amount.new(300, 'PLN') * 2.0).to                    eq Amount.new(600, 'PLN') }

    it { expect(Amount.new(1550, 'EUR').to_s).to                    eq('15.50 EUR') }

    it { expect(Amount.new(-250, 'GBP').negative?).to               eq(true) }
    it { expect(Amount.new(250, 'GBP').negative?).to                eq(false) }
  end
end
