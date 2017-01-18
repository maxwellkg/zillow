module ZillowApi
  class Property
    @path = 'GetUpdatedPropertyDetails'

    # Retrieve details for a specified property

    # Documentation for the Property Details API can be found here
    # http://www.zillow.com/howto/api/PropertyDetailsAPIOverview.htm

    # @example
    #
    # prop = ZillowApi::Property.where(address: '2114 Bigelow Ave', city: 'Seattle', state: 'WA')
    # 

    def self.find(zpid)
      opts = {:zpid => zpid}
      Request.new(path: @path, options: opts)
    end

    def self.where(address:, citystatezip:, rentzestimate: false)
      self.find(DeepSearch.new(address: address, citystatezip: citystatezip, rentzestimate: rentzestimate).execute.zpid)
    end

  end
end
