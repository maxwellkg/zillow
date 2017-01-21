module Zillow
  module Api
    class ZillowApiError < StandardError

      def initialize(msg = "An error has occurred ")
        super
      end

    end
  end
end
