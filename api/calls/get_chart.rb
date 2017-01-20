module ZillowApi
  module Api
    module Calls
      class GetChart < Base

        # Documentation for the GetChart API can be found here:
        # http://www.zillow.com/howto/api/GetChart.htm

        # Parameters:
        # +zpid+:: The Zillow Property ID for the property; the parameter type is an integer. Required
        # +unit-type+:: A string value that specifies whether to show the percent change, parameter value of "percent," or dollar change, parameter value of "dollar". Required
        # +width+:: An integer value that specifies the width of the generated image; the value must be between 200 and 600, inclusive. Not required
        # +height+:: An integer value that specifies the height of the generated image; the value must be between 100 and 300, inclusive. Not required
        # +chartDuration+:: The duration of past data that needs to be shown in the chart. Valid values are "1year", "5years", and "10years". If unspecified, the value defaults to "1year". Not required
        #
        #
        # Example call:
        # ZillowApi::Api::Calls::GetChart.new({'unit-type' => 'percent', zpid: 48749425, height: 150, width: 300}).execute
        #

        PATH = 'GetChart'.freeze
        VALID_PARAMS = {
          :zpid => {:required => true},
          'unit-type' => {:required => true},
          :width => {:required => false},
          :height => {:required => false},
          :chart_duration => {:required => false}
        }.freeze

        protected

          # Validate the parameters to avoid unncessary API calls

          def validate_parameters(params)
            super

            validate_unit_type(params['unit-type']) if params['unit-type']
            validate_width(params[:width]) if params[:width]
            validate_height(params[:height]) if params[:height]
          end

          def validate_unit_type(unit_type)
            raise ArgumentError, "#{unit_type} is not an acceptable unit-type. Acceptable types are: 'percent', 'dollar'" unless ['percent', 'dollar'].include?(unit_type)
          end

          def validate_width(width)
            raise ArgumentError, "#{width} is not an acceptable width. Acceptable widths are between 200 and 600, inclusive" unless (200..600).cover?(width)
          end

          def validate_height(height)
            raise ArgumentError, "#{height} is not an acceptable height. Acceptable heights are between 100 and 300" unless (100..300).cover?(height)
          end

      end
    end
  end
end
