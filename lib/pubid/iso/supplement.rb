module Pubid::Iso
  class Supplement
    attr_accessor :version, :number, :stage

    def initialize(version:, number:, stage: nil)
      @version, @number, @stage = version, number, stage
    end

    def ==(other)
      other.version == version && (number.nil? || other.number == number) && (stage.nil? || other.stage == stage)
    end

    def render_pubid_stage
      ((@stage && @stage) || "")
    end

    def render_pubid_number
        if @number
          "#{@version}:#{@number}"
        else
          "#{@version}"
        end
    end

    def render_urn_stage
      ((@stage && ":stage-#{sprintf('%05.2f', Urn::STAGES[@stage.to_sym])}") || "")
    end

    def render_urn_number
        if @number
          ":#{@number}:v#{@version}"
        else
          ":#{@version}:v1"
        end
    end
  end
end