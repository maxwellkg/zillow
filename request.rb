module ZillowApi
  class Request

    BASE = "http://www.zillow.com/webservice"

    CREDENTIALS = {
      :zwsid => 'X1-ZWz19emx3ram17_4ye7m'
      }.freeze

    attr_accessor :path, :options
    attr_reader :response

    def initialize(path: nil, options: {})
      @path, @options = path, options
    end

    # Generate the url for the request

    def uri
      opts = URI.encode_www_form(options)
      URI("#{BASE}/#{@path}.htm?zws-id=#{CREDENTIALS[:zwsid]}&#{opts}")
    end

    # Executes the request

    def execute
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        @response = Hash.from_xml(res.body)
      else
        raise "#{res.code}: #{JSON.parse(res.body)}"
      end
    end

    private

      def lower_camelize(opts)
        lower_camelized = {}
        opts.each do |k,v|
          lower_camelized[k.to_s.camelize(:lower)]
        end

        lower_camelized
      end

  end
end
