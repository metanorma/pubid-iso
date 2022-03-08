module Pubid::Iso
  class Identifier

    attr_accessor :number, :publisher, :copublisher, :stage, :substage, :part,
                  :type, :year, :edition, :iteration, :supplements, :language,
                  :amendment, :amendment_version, :amendment_number,
                  :corrigendum, :corrigendum_version, :corrigendum_number,
                  :amendment_stage, :corrigendum_stage

    def initialize(**opts)
      opts.each { |key, value| send("#{key}=", value.is_a?(Array) && value || value.to_s) }
    end

    def urn
      params = instance_variables.map { |var| [var.to_s.gsub("@", "").to_sym, instance_variable_get(var)] }.to_h
      URN.new(**params)
    end

    def self.parse(code)
      params = Parser.new.parse(code)
      # Parslet returns an array when match any copublisher
      # otherwise it's hash
      if params.is_a?(Array)
        new(
          **(
            params.inject({}) do |r, i|
              result = r
              i.map {|k, v| Transformer.new.apply(k => v).to_a.first }.each do |k, v|
                result = result.merge(k => r.key?(k) ? [v, r[k]] : v)
              end
              result
            end
          )
        )
      else
        new(**params.map do |k, v|
          Transformer.new.apply(k => v).to_a.first
        end.to_h)
      end
      # merge values repeating keys into array (for copublishers)


      # params.to_h)
    rescue Parslet::ParseFailed => failure
      raise Pubid::Iso::Errors::ParseError, "#{failure.message}\ncause: #{failure.parse_failure_cause.ascii_tree}"
    end

    def to_s
      "#{originator}#{type}#{stage} #{number}#{part}#{iteration}#{year}#{edition}#{supplements}#{language}"
    end

    def originator
      if @copublisher
        @copublisher = [@copublisher] unless @copublisher.is_a?(Array)
        @publisher + @copublisher.map(&:to_s).sort.map do |copublisher|
          "/#{copublisher.gsub('-', '/')}"
        end.join
      else
        @publisher
      end
    end

    def stage
      "#{(@copublisher && ' ') || '/'}#{@stage}" if @stage
    end

    def part
      "-#{@part}" if @part
    end

    def year
      ":#{@year}" if @year
    end

    def type
      "#{(@copublisher && ' ') || '/'}#{@type}" if @type
    end

    def edition
      " ED#{@edition}" if @edition
    end

    def iteration
      ".#{@iteration}" if @iteration
    end

    def supplements
      result = ""
      if @amendment
        result += (@amendment_stage && "/#{@amendment_stage} ") || "/"
        result += if @amendment_number
                    "Amd #{@amendment_version}:#{@amendment_number}"
                  else
                    "Amd #{@amendment_version}"
                  end
      end
      if @corrigendum
        result += (@corrigendum_stage && "/#{@corrigendum_stage} ") || "/"
        result += if @corrigendum_number
                    "Cor #{@corrigendum_version}:#{@corrigendum_number}"
                  else
                    "Cor #{@corrigendum_version}"
                  end
      end

      result
    end

    def language
      if @language
        "(#{@language})"
      end
    end
  end
end
