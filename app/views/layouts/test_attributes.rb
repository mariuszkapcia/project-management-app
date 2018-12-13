module ProjectManagement
  module TestAttributes
    def developer_ignacy
      {
        uuid:           '62147dcd-d315-4120-b7ec-f6b00d10c223',
        fullname:       'Ignacy Ignacy',
        email:          'ignacy@gmail.com',
        hours_per_week: 20
      }
    end

    def project_topsecretdddproject
      @deadline ||= 1.hour.from_now.utc.to_datetime

      {
        uuid:       'ab6e9c30-2b1c-474d-824f-7b8f816ced99',
        name:       '#TopSecretDDDProject',
        estimation: 40,
        deadline:   @deadline
      }
    end
  end
end
