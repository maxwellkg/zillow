module Zillow
  module Api
    class Base
      extend Zillow::Inflector

      attr_accessor :params
      attr_reader :result

      PATH = ''.freeze
      VALID_PARAMS = {}.freeze

      def initialize(params)
        # validate the parameters to avoid unnecessary API calls
        self.validate_parameters(params)

        @params = params
        @loaded = false
      end

      def loaded?
        @loaded == true
      end

      def load
        execute unless loaded?
      end

      def execute
        @result = Request.new(path: self.class.const_get(:PATH), options: @params).execute
        @loaded = true

        check_result_for_errors
        @result
      end

      def attributes
        atts = {}
        self.instance_variables.each { |v| atts[v.to_s.gsub('@','')] = self.instance_variable_get(v) }
        atts
      end

      protected

        def validate_parameters(params)
          valid_params = self.class.const_get(:VALID_PARAMS)
          required_params = valid_params.select { |k,v| k if v[:required] == true }.keys

          # ensure all the required parameters are present
          if required_params.any? { |p| !params.include?(p) }
            raise "Please specify the required params: #{required_params.join(', ')}"
          end

          # ensure there are no invalid parameters
          if params.keys.any? { |param| !valid_params.keys.include?(param) }
            raise "Parameters (#{params}) include invalid parameters"
          end
        end

        def response_message
        end

        def check_result_for_errors
          msg = self.response_message
          raise ZillowApiError.new(msg.gsub('Error: ','')) if msg.include?('Error')
        end

    end
  end
end
