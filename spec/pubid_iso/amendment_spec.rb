module Pubid::Iso
  RSpec.describe Amendment do
    let(:pubid_amendment) { "/Amd 1:2009" }

    describe "#render" do
      subject { described_class.new(number: 1, year: 2009, typed_stage: "Amd") }

      it { expect(subject.render_pubid).to eq(pubid_amendment) }

      context "when amendment has stage" do
        subject { described_class.new(number: 1, year: 2009, typed_stage: "CD Amd") }
        let(:pubid_amendment) { "/CD Amd 1:2009" }
        let(:urn_amendment) { ":stage-draft:amd:2009:v1" }

        it { expect(subject.render_pubid).to eq(pubid_amendment) }
        it { expect(subject.render_urn).to eq(urn_amendment) }
      end
    end
  end
end
