module Pubid::Iso
  module Identifier
    class PubliclyAvailableSpecification < Base
      def_delegators 'Pubid::Iso::Identifier::PubliclyAvailableSpecification', :type

      TYPED_STAGES = {
        dpas: {
          abbr: "DPAS",
          type: :pas,
          name: "Publicly Available Specification Draft",
          harmonized_stages: %w[40.00 40.20 40.60 40.92 40.93 50.00 50.20 50.60 50.92],
        },
      }.freeze

      def self.type
        :pas
      end

      def self.get_renderer_class
        Renderer::PubliclyAvailableSpecification
      end
    end
  end
end
