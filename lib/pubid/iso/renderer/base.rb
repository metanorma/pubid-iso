module Pubid::Iso::Renderer
  class Base < Pubid::Core::Renderer::Base
    # Render identifier
    # @param with_edition [Boolean] include edition in output
    # @see Pubid::Core::Renderer::Base for another options
    def render(with_edition: true, **args)
      params = prerender_params(@params,
                                { with_edition: with_edition }.merge(args))
      # render empty string when the key is not exist
      params.default = ""

      render_identifier(params)
    end


    def render_identifier(params)
      render_base(params, "%{type}%{stage}" % params) +
        "%{part}%{iteration}%{year}%{edition}%{amendments}%{corrigendums}%{language}" % params
    end

    def render_type(type, opts, params)
      if params[:copublisher]
        " #{type}"
      else
        "/#{type}"
      end
    end

    def render_stage(stage, opts, params)
      if params[:copublisher]
        " #{stage.abbr}"
      else
        "/#{stage.abbr}"
      end
    end

    def render_edition(edition, opts, _params)
      " ED#{edition}" if opts[:with_edition]
    end

    def render_iteration(iteration, _opts, _params)
      ".#{iteration}"
    end

  end
end
