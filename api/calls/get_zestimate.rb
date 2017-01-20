module ZillowApi
  module Api
    module Calls
      class GetZestimate < Base

        # Documentation for the GetZestimate API can be found here:
        # http://www.zillow.com/howto/api/GetZestimate.htm

        # Parameters:
        # +zpid+:: The Zillow Property ID for the property for which to obtain information. The parameter type is an integer. Required
        # +rentzestimate+:: Return Rent Zestimate information if available (boolean true/false, default: false). Not required
        #
        #
        # Example call:
        # ZillowApi::Api::Calls::GetZestimate.new({zpid: 48749425}).execute

        PATH = 'GetZestimate'.freeze
        VALID_PARAMS = {
          :zpid => {:required => true},
          :rentzestimate => {:required => false}
        }.freeze

      end
    end
  end
end
