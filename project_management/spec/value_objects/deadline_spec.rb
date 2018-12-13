module ProjectManagement
  RSpec.describe 'Deadline value object' do
    it { expect{ Deadline.new(DateTime.current.to_i) }.not_to raise_error }
    it { expect{ Deadline.new(DateTime.current) }.to          raise_error(Deadline::InvalidValue) }
    it { expect{ Deadline.new('01-01-2018') }.to              raise_error(Deadline::InvalidValue) }
    it { expect{ Deadline.new('qwe') }.to                     raise_error(Deadline::InvalidValue) }

    it do
      deadline = DateTime.current
      expect(Deadline.new(deadline.to_i).to_datetime).to      eq(deadline.strftime('%FT%T%:z'))
    end
  end
end
