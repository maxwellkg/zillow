module ZillowApi
  module Api
    module Calls
      class GetUpdatedPropertyDetails < Base

        # Documentation for the GetUpdatedPropertyDetails API can be found here:
        # http://www.zillow.com/howto/api/GetUpdatedPropertyDetails.htm

        # Parameters:
        # +zpid+:: The Zillow Property ID for the property for which to obtain information; the parameter type is an integer. REQUIRED
        #
        #
        # Example call:
        # ZillowApi::Api::Calls::GetUpdatedPropertyDetails.new({zpid: 48749425}).execute
        #

        PATH = 'GetUpdatedPropertyDetails'.freeze
        VALID_PARAMS = {
          :zpid => {:required => true}
        }

      end
    end
  end
end
