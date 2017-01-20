module Zillow
  module Api
    class GetDeepComps < Base

      # Documentation for the GetDeepComps API can be found here:
      # http://www.zillow.com/howto/api/GetDeepComps.htm

      # Parameters:
      # +zpid+:: The Zillow Property ID for the property for which to obtain information; the parameter type is an integer. REQUIRED
      # +count+:: The number of comparable recent sales to obtain (integer between 1 and 25). REQUIRED
      # +rentzestimate+:: Return Rent Zestimate information if available (boolean true/false, default: false). Not requried
      #
      #
      # Example call:
      # Zillow::Api::GetDeepComps.new({zpid: 48749425, count: 10}).execute
      #

      PATH = 'GetDeepComps'.freeze
      VALID_PARAMS = {
        :zpid => {:required => true},
        :count => {:requried => true},
        :rentzestimate => {:required => false}
      }

      protected

        def validate_parameters(params)
          super

          validate_count(params[:count]) if params[:count]
          validate_rentzestimate(params[:rentzestimate]) if params[:rentzestimate]
        end

        def validate_count(count)
          raise ArgumentError, "#{count} is not an acceptable count. Counts should be between 1 and 25" unless (1..25).cover?(count)
        end

        def validate_rentzestimate(rentzestimate)
          raise ArgumentError, "#{rentzesimate} is not an acceptable value for rentzestimate. Rentzestimate should be a boolean" if ![true, false].include?(rentzestimate)
        end

    end
  end
end
