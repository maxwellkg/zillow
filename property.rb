module ZillowApi
  class Property
    extend ZillowApi::Inflector

    @path = 'GetUpdatedPropertyDetails'

    # Retrieve details for a specified property

    # Documentation for the Property Details API can be found here
    # http://www.zillow.com/howto/api/PropertyDetailsAPIOverview.htm

    def initialize(attrs)
      attrs.each do |k,v|
        if k == 'editedFacts'
          # set each data point contained in the Edited Facts section as its own
          # instance variable
          v.each do |characteristic, value|
            self.set_readers(characteristic, value)
          end
        elsif k == 'zestimate'
          # attach a corresponding ZillowApi::Zestimate
          self.class_eval { attr_reader :zestimate }
          self.instance_variable_set("@zestimate", Zestimate.new(v.merge({:property => self})))
        elsif k == 'rentzestimate'
          # attach a corresponding ZillowApi::RentZestimate
          self.class_eval { attr_reader :rent_zestimate }
          self.instance_variable_set("@rentzestimate", RentZestimate.new(v.merge({:property => self})))
        else
          self.set_readers(k, v)
        end
      end
    end

    # finds information on a property specified by its zpid
    # combines information from the Property Details API and the Deep Search API
    #
    # Params:
    # +zpid+:: The Zillow Property ID for the property for which to obtain information; the parameter type is an integer
    #
    # @example
    # prop = ZillowApi::Property.find('48749425')

    def self.find(zpid)
      opts = {:zpid => zpid}

      prop_req = Request.new(path: @path, options: opts)
      property_results = prop_req.execute['updatedPropertyDetails']['response']

      ds = DeepSearch.new(address: property_results['address']['street'], citystatezip: "#{property_results['address']['city']}, #{property_results['address']['state']}")
      ds_results = ds.execute


      # some of the data from the two APIs overlaps, in which case we'll
      # give precedence to results from the Property Data API
      atts = ds_results.merge(property_results)

      self.new(atts)
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
    # prop = ZillowApi::Property.where(address: '2114 Bigelow Ave', citystatezip: 'Seattle, WA')
    # 

    def self.where(address:, citystatezip:, rentzestimate: false)
      ds = DeepSearch.new(address: address, citystatezip: citystatezip, rentzestimate: rentzestimate)
      ds_results = ds.execute

      opts = {:zpid => ds_results['zpid']}
      prop_req = Request.new(path: @path, options: opts)
      property_results = prop_req.execute['updatedPropertyDetails']['response']

      # some of the data from the two APIs overlaps, in which case we'll
      # give precedence to results from the Property Data API
      atts = ds_results.merge(property_results)

      self.new(atts)
    end

    def set_readers(att, value)
      self.class_eval { attr_reader att.rubify }
      self.instance_variable_set("@#{att.rubify}", value)
    end

  end
end
