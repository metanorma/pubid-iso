require_relative "base"

module Pubid::Iso::Renderer
  class Supplement < Base
    TYPE = "SUP".freeze

    # Render identifier
    # @param with_edition [Boolean] include edition in output
    # @see Pubid::Core::Renderer::Base for another options
    def render(with_edition: true, with_language_code: :iso, with_date: true, **args)
      @params[:base].to_s(lang: args[:language], with_edition: with_edition) + super +
        if @params[:base].language
          render_language(@params[:base].language,
                          { with_language_code: with_language_code }, nil).to_s
        else
          ""
        end
    end

    def render_identifier(params, opts)
      space = opts[:language] == :french ? "." : " "
      type_prefix = params[:typed_stage].nil? || params[:typed_stage].empty? ? self.class::TYPE : ""

      if params[:stage].is_a?(Pubid::Iso::Stage) && !params[:stage].empty_abbr?
        type_prefix = " #{type_prefix}"
      end

      if self.class == Supplement
        "%{typed_stage}%{stage}%{publisher} #{type_prefix}%{number}%{part}%{iteration}%{year}%{edition}" % params
      else
        "/%{typed_stage}%{stage}#{type_prefix}#{space}%{number}%{part}%{iteration}%{year}%{edition}" % params
      end
    end

    def render_stage(stage, opts, params)
      # do not render stage when already has typed stage
      stage unless params[:typed_stage]
    end

    def render_publisher(publisher, opts, params)
      " #{publisher}" unless publisher.empty?
    end

    def render_edition(edition, opts, _params)
      " Edition #{edition}" if opts[:with_edition]
    end
  end
end
