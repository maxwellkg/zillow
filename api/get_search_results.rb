module Zillow
  module Api
    class GetSearchResults < Base

      # Documentation for the GetSearchResults API can be found here:
      # http://www.zillow.com/howto/api/GetSearchResults.htm

      # Parameters:
      # +address+:: The address of the property to search. This string should be URL encoded. REQUIRED
      # +citystatezip+:: The city+state combination and/or ZIP code for which to search. This string should be URL encoded. Note that giving both city and state is required. Using just one will not work. REQUIRED
      # +rentzestimate+:: Return Rent Zestimate information if available (boolean true/false, default: false)
      #
      # Example call:
      # Zillow::Api::GetSearchResults.new({address: '2114 Bigelow Ave', citystatezip: 'Seattle, WA'}).execute
      #

      PATH = 'GetSearchResults'.freeze
      VALID_PARAMS = {
        :address => {:required => true},
        :citystatezip => {:required => true},
        :rentzestimate => {:required => false}
      }.freeze

    end
  end
end
