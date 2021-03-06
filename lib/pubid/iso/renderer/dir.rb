module Pubid::Iso::Renderer
  class Dir < Pubid::Core::Renderer::Base

    def render_identifier(params)
      res = ("%{publisher}%{copublisher} DIR%{dirtype}%{number}%{year}%{supplement}" % params)

      if params.key?(:joint_document)
        joint_params = prerender_params(params[:joint_document], {})
        joint_params.default = ""
        res += (" + %{publisher}%{copublisher}%{dirtype}%{number}%{year}%{supplement}" % joint_params)
      end

      res
    end

    def render_number(number, _opts, _params)
      " #{number}"
    end

    def render_dirtype(dirtype, _opts, _params)
      " #{dirtype}"
    end

    def render_supplement(supplement, _opts, _params)
      if supplement.publisher && supplement.publisher != ""
        " #{supplement.publisher} SUP"
      else
        " SUP"
      end + (supplement.number && ":#{supplement.number}" || "") +
        (supplement.edition && " Edition #{supplement.edition}" || "")
    end
  end
end
