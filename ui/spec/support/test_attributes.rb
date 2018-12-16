module UI
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
      {
        uuid:       'ab6e9c30-2b1c-474d-824f-7b8f816ced99',
        name:       '#TopSecretDDDProject',
        estimation: 40,
        deadline:   Time.current.to_date.strftime('%d-%m-%Y')
      }
    end

    def order_dddproject
      {
        uuid:         'ab6e9c30-2b1c-474d-824f-7b8f816ced99',
        project_uuid: 'ab6e9c30-2b1c-474d-824f-7b8f816ced99',
        name:         '#TopSecretDDDProject'
      }
    end
  end
end
