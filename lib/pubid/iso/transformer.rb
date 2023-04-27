require_relative "identifier/base"
require_relative "renderer/base"

module Pubid::Iso
  class Transformer < Parslet::Transform
    rule(edition: "Ed") do
      { edition: "1" }
    end

    rule(stage: subtree(:stage)) do |context|
      stage_and_type = convert_stage(context[:stage])
      context[:stage] = stage_and_type[:stage]
      context[:type] = stage_and_type[:type] if stage_and_type[:type]
      context
    end

    rule(supplements: subtree(:supplements)) do |context|
      context[:supplements] =
        context[:supplements].map do |supplement|
          if supplement[:typed_stage]
            supplement.merge(
              case supplement[:typed_stage]
              when "PDAM"
                { typed_stage: "CD", type: "Amd" }
              when "pDCOR"
                { typed_stage: "CD", type: "Cor" }
              else
                {}
              end
            )
          else
            case supplement[:type]
            when "Addendum"
              supplement.merge({ type: "Add" })
            else
              supplement
            end
          end
        end
      context
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
      russian_type = Pubid::Iso::Renderer::Base::TRANSLATION[:russian][:type].key(type.to_s)
      { type: russian_type&.downcase&.to_sym ||
                        case type
                        # XXX: can't put 2 alternative Russian translations to dictionary, temporary hack
                        when "GUIDE", "Guide", "Руководство"
                          :guide
                        when "ТС", "TS"
                          :ts
                        when "ТО", "TR"
                          :tr
                        when "Directives Part", "Directives, Part", "Directives,", "DIR"
                          :dir
                        when "PAS"
                          :pas
                        when "DPAS"
                          :dpas
                        when "R"
                          :r
                        else
                          type
                        end }
    end

    rule(tctype: subtree(:tctype))  do |context|
      context[:type] = :tc
      context
    end

    rule(copublisher: simple(:copublisher)) do
      russian_copublisher = Pubid::Iso::Renderer::Base::TRANSLATION[:russian][:publisher].key(copublisher.to_s)
      { copublisher: russian_copublisher&.to_s ||
        case copublisher
        when "CEI"
          "IEC"
        else
          copublisher.to_s
        end
      }
    end

    rule(publisher: simple(:publisher)) do
      russian_publisher = Pubid::Iso::Renderer::Base::TRANSLATION[:russian][:publisher].key(publisher.to_s)
      { publisher: russian_publisher&.to_s || publisher }
    end

    rule(joint_document: subtree(:joint_document)) do |context|
      context[:joint_document] =
        Identifier.create(**context[:joint_document])
      context
    end

    rule(dir_joint_document: subtree(:dir_joint_document)) do |context|
      context[:joint_document] =
        Identifier::Base.transform(**(context[:dir_joint_document].merge(type: :dir)))
      context.select { |k, v| k != :dir_joint_document }
    end


    rule(roman_numerals: simple(:roman_numerals)) do |context|
      roman_to_int(context[:roman_numerals])
      # case roman_numerals
      # when "III"
      #   3
      # else
      #   nil
      # end
    end

    ROMAN_TO_INT = {
      "I" => 1,
      "V" => 5,
      "X" => 10,
      "L" => 50,
      "C" => 100,
      "D" => 500,
      "M" => 1000,
    }

    def self.roman_to_int(roman)
      sum = ROMAN_TO_INT[roman.to_s[0]]
      roman.to_s.chars.each_cons(2) do |c1, c2|
        sum += ROMAN_TO_INT[c2]
        sum -= ROMAN_TO_INT[c1] * 2 if ROMAN_TO_INT[c1] < ROMAN_TO_INT[c2]
      end
      sum
    end

    def self.convert_stage(code)
      russian_code = Pubid::Iso::Renderer::Base::TRANSLATION[:russian][:stage].key(code.to_s)
      return { stage: russian_code } if russian_code

      case code
      when "NWIP"
        { stage: "NP" }
      when "D", "FPD"
        { stage: "DIS" }
      when "FD", "F"
        { stage: "FDIS" }
      when "Fpr"
        { stage: "PRF" }
      when "PDTR"
        { stage: "CD", type: "TR" }
      when "PDTS"
        { stage: "CD", type: "TS" }
      else
        { stage: code }
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
