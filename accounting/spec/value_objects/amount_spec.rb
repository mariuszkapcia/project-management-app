module Accounting
  RSpec.describe 'Amount value object' do
    it { expect(Amount.new(12.50, 'PLN').to_f).to                 eq(12.50) }
    it { expect(Amount.new(-2.50, 'GBP').to_f).to                 eq(-2.50) }

    it { expect(Amount.new(24, 'GBP')).to                         eq Amount.new(24, 'GBP') }
    it { expect(Amount.new(0, 'EUR')).not_to                      eq Amount.new(0, 'PLN') }

    it { expect(Amount.new(3, 'PLN') + Amount.new(2, 'PLN')).to   eq Amount.new(5, 'PLN') }
    it { expect(Amount.new(3, 'PLN') - Amount.new(2, 'PLN')).to   eq Amount.new(1, 'PLN') }

    it { expect{Amount.new(3, 'PLN') + Amount.new(2, 'EUR')}.to   raise_error(ArgumentError) }
    it { expect{Amount.new(3, 'PLN') - Amount.new(2, 'EUR')}.to   raise_error(ArgumentError) }

    it { expect(Amount.new(3, 'PLN') * 2.0).to                    eq Amount.new(6, 'PLN') }

    it { expect(Amount.new(15.5, 'EUR').to_s).to                  eq('15.50 EUR') }
  end
end
