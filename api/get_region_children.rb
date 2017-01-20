module Zillow
  module Api
    class GetRegionChildren < Base

      # Documentation for the GetRegionChildren API can be found here
      # http://www.zillow.com/howto/api/GetRegionChildren.htm

      # Params:
      # +regionId+:: The regionId of the region to retrive subregions from. Not required
      # +state+:: The state of the region to retrieve subregions from. Not required
      # +county+:: The county of the region to retrieve subregions from. Not required
      # +city+:: The city of the region to retrieve subregions from. Not required
      # +childtype+:: The type of subregions to retrieve (available types: state, country, city, zipcode, and neighborhood). Not required
      #
      # *At least regionId or state is required
      #
      #
      # Example call:
      # Zillow::Api::GetRegionChildren.new({state: 'WA', city: 'Seattle', childtype: 'neighborhood'}).execute


      PATH = 'GetRegionChildren'.freeze
      VALID_PARAMS = {
        :region_id => {:required => false},
        :state => {:required => false},
        :county => {:required => false},
        :city => {:required => false},
        :childtype => {:required => false}
      }.freeze

      VALID_CHILDTYPES = ['state','county','city','zipcode','neighborhood'].freeze

      protected

        def validate_parameters(params)
          super

          validate_childtype(params[:childtype]) if params[:childtype]
        end

        def validate_childtype(childtype)
          raise ArgumentError, "#{childtype} is not an acceptable childtype. Acceptable childtypes are: #{VALID_CHILDTYPES.join(', ')}" unless VALID_CHILDTYPES.include?(childtype)
        end

    end
  end
end
