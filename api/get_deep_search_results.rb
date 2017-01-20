module Zillow
  module Api
    class GetDeepSearchResults < Base

      # Documentation for the GetDeepSearchResults API can be found here:
      # http://www.zillow.com/howto/api/PropertyDetailsAPIOverview.htm

      # Parameters:
      # +address+:: The address of the property to search. This string should be URL encoded. REQUIRED
      # +citystatezip+:: The city+state combination and/or ZIP code for which to search. This string should be URL encoded. Note that giving both city and state is required. Using just one will not work. REQUIRED
      # +rentzestimate+:: Return Rent Zestimate information if available (boolean true/false, default: false). Not required
      #
      #
      # Example call:
      # Zillow::Api::GetDeepSearchResults.new({address: '2114 Bigelow Ave', citystatezip: 'Seattle, WA'}).execute
      #

      PATH = 'GetDeepSearchResults'.freeze
      VALID_PARAMS = {
        :address => {:required => true},
        :citystatezip => {:required => true},
        :rentzestimate => {:required => false}
      }

      protected

        def validate_parameters(params)
          super

          validate_rentzestimate(params[:rentzestimate]) if params[:rentzestimate]
        end

        def validate_rentzestimate(rentzestimate)
          raise ArgumentError, "#{rentzesimate} is not an acceptable value for rentzestimate. Rentzestimate should be a boolean" if ![true, false].include?(rentzestimate)
        end

    end
  end
end
