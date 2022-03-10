module Pubid::Iso
  class Transformer < Parslet::Transform
    rule(edition: "Ed") do
      { edition: "1" }
    end

    rule(stage: simple(:stage)) do |context|
      { stage: convert_stage(context[:stage]) }
    end

    rule(amendment_stage: simple(:amendment_stage)) do |context|
      { amendment_stage: convert_stage(context[:amendment_stage]) }
    end

    rule(corrigendum_stage: simple(:corrigendum_stage)) do |context|
      { corrigendum_stage: convert_stage(context[:corrigendum_stage]) }
    end

    rule(language: simple(:language)) do |context|
      if context[:language].to_s.include?("/")
        { language: context[:language]
          .to_s.split("/")
          .map { |code| convert_language(code) }.join(",") }
      else
        { language: convert_language(context[:language]) }
      end
    end

    rule(type: simple(:type)) do
      russian_type = Russian::TYPE.key(type.to_s)
      { type: russian_type&.to_s ||
        case type
        # XXX: can't put 2 alternative Russian translations to dictionary, temporary hack
        when "GUIDE", "Руководства"
          "Guide"
        when "ТС"
          "TS"
        when "ТО"
          "TR"
        else
          type
        end
      }
    end

    rule(copublisher: simple(:copublisher)) do
      russian_copublisher = Russian::PUBLISHER.key(copublisher.to_s)
      { copublisher: russian_copublisher&.to_s ||
        case copublisher
        when "CEI"
          "IEC"
        else
          copublisher
        end
      }
    end

    rule(publisher: simple(:publisher)) do
      russian_publisher = Russian::PUBLISHER.key(publisher.to_s)
      { publisher: russian_publisher&.to_s || publisher }
    end

    def self.convert_stage(code)
      russian_code = Russian::STAGE.key(code.to_s)
      return russian_code.to_s if russian_code

      case code
      when "D"
        "DIS"
      when "FD"
        "FDIS"
      when "Fpr"
        "PRF"
      when "pD", "PD"
        "CD"
      else
        code
      end
    end

    def self.convert_language(code)
      case code
      when "R"
        "ru"
      when "F"
        "fr"
      when "E"
        "en"
      when "A"
        "ar"
      else
        code
      end
    end
  end
end
