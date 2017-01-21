module Zillow
  module Models
    class Property
      extend Zillow::Inflector

      # Retrieve details for a specified property
      # Combines information from the Property Details API and the Deep Search API

      def initialize(attrs)
        attrs.each do |k,v|
          if k == 'editedFacts'
            # set each data point contained in the Edited Facts section as its own
            # instance variable
            v.each do |characteristic, value|
              self.set_readers(characteristic, value)
            end
          elsif k == 'zestimate'
            # attach a corresponding Zillow::Models::Zestimate
            self.class_eval { attr_reader :zestimate }
            self.instance_variable_set("@zestimate", Zestimate.new(v.merge({:property => self})))
          elsif k == 'rentzestimate'
            # attach a corresponding Zillow::Models::RentZestimate
            self.class_eval { attr_reader :rent_zestimate }
            self.instance_variable_set("@rentzestimate", RentZestimate.new(v.merge({:property => self})))
          else
            self.set_readers(k, v)
          end
        end
      end

      # Params:
      # +zpid+:: The Zillow Property ID for the property for which to obtain information; the parameter type is an integer
      #
      # @example
      # prop = Zillow::Models::Property.find('48749425')

      def self.find(zpid)
        # first, get the information given by the Property Details API
        # in the case that there are no details for this zpid, we will be unable to 
        # instantiate an object of this class
        property_details =  Zillow::Api::GetUpdatedPropertyDetails.new({zpid: zpid}).execute['updatedPropertyDetails']['response']

        # then, get the information given by the Deep Search Results API
        address = property_details['address']
        ds_opts = {
          :address => address['street'],
          :citystatezip => "#{address['city']}, #{address['state']}",
          :rentzestimate => true
        }
        deep_search_details = Zillow::Api::GetDeepSearchResults.new(ds_opts).execute['searchresults']['response']['results']['result']

        # some of the data from the two APIs overlap, in which case we'll give precedence
        # to results from the Property Details API
        attrs = deep_search_details.merge(property_details)

        self.new(attrs)
      end


      # finds information on a property specified by its address
      # combines information from the Property Details API and the Deep Search API
      #
      # Params:
      # +address+:: The address of the property to search. This string should be URL encoded.
      # +citystatezip+:: The city+state combination and/or ZIP code for which to search. This string should be URL encoded. Note that giving both city and state is required. Using just one will not work.
      # +rentzestimage+:: Return Rent Zestimate information if available (boolean true/false, default: false)
      #
      # @example
      # prop = Zillow::Models::Property.where(address: '2114 Bigelow Ave', citystatezip: 'Seattle, WA')
      # 

      def self.where(address:, citystatezip:)
        # first, get the information given by the Deep Search Results API
        deep_search_details = Zillow::Api::GetDeepSearchResults.new(address: address, citystatezip: citystatezip, rentzestimate: true).execute['searchresults']['response']['results']['result']

        # then, get the information given by the Property Details API
        # in some cases, there may be no details, in which case we will instantiate
        # the object using only the results of the deep search
        zpid = deep_search_details['zpid']
        property_details =  begin
                              Zillow::Api::GetUpdatedPropertyDetails.new({zpid: zpid}).execute['updatedPropertyDetails']['response']
                            rescue ZillowApiError
                              {}
                            end

        # some of the data from the two APIs overlap, in which case we'll give precedence
        # to results from the Property Data API
        attrs = deep_search_details.merge(property_details)

        self.new(attrs)
      end

      def attributes
        atts = {}
        self.instance_variables.each { |v| atts[v.to_s.gsub('@','')] = self.instance_variable_get(v) }
        atts
      end

      protected

        def set_readers(att, value)
          self.class_eval { attr_reader att.rubify }
          self.instance_variable_set("@#{att.rubify}", value)
        end

        def self.find_one(zpid)

        end

        def self.find_many(zpids)

        end

    end
  end
end
