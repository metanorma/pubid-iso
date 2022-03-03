module PubidIso
  class URN
    attr_accessor :identifier

    def initialize(identifier)
      @identifier = identifier
    end

    def to_s
      # docidentifier = originator [":" type] ":" docnumber [":" partnumber]
      # [[":" status] ":" edition]
      # [":" docversion] [":" language]

      "urn:iso:std:#{originator}#{type}:#{identifier.number}#{part}#{stage}#{edition}"
    end

    def part
      ":-#{identifier.part}" if identifier.part
    end

    def stage
      ":stage-#{identifier.stage}.#{sprintf('%02d', identifier.substage)}" if identifier.stage
    end

    def originator
      # originator    = "iso" / "iso-iec" / "iso-cie" / "iso-astm" /
      #   "iso-ieee" / "iec"

      if identifier.copublisher
        "#{identifier.publisher.downcase}-#{identifier.copublisher.downcase.gsub('/', '-')}"
      else
        identifier.publisher.downcase
      end
    end

    def edition
      ":ed-#{identifier.edition}" if identifier.edition
    end

    def type
      # type          = "data" / "guide" / "isp" / "iwa" /
      #   "pas" / "r" / "tr" / "ts" / "tta"

      if identifier.type
        ":#{identifier.type.downcase}"
      end
    end
  end
end
