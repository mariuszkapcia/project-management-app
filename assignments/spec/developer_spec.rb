require_dependency 'assignments'

module Assignments
  RSpec.describe 'Developer aggregate' do
    specify 'register a new developer' do
      developer = Assignments::Developer.new(developer_uuid)
      developer.register(developer_fullname)

      expect(developer).to(have_applied(developer_registered))
    end

    private

    def developer_registered
      an_event(Assignments::DeveloperRegistered).with_data(developer_data)
    end

    def developer_data
      {
        uuid:     developer_uuid,
        fullname: developer_fullname
      }
    end

    def developer_uuid
      '62147dcd-d315-4120-b7ec-f6b00d10c223'
    end

    def developer_fullname
      'Ignacy Ignacy'
    end
  end
end
