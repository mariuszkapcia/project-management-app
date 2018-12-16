module Accounting
  module TestAttributes
    def order_dddproject
      {
        uuid:            '40b86f75-6079-465f-8e22-cc1014716546',
        project_uuid:    'ab6e9c30-2b1c-474d-824f-7b8f816ced99',
        name:            '#TopSecretDDDProject',
        amount_cents:    900_000,
        amount_currency: 'USD'
      }
    end

    def project_topsecretdddproject
      {
        uuid: 'ab6e9c30-2b1c-474d-824f-7b8f816ced99',
        name: '#TopSecretDDDProject'
      }
    end
  end
end
