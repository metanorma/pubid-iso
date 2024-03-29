require "parslet/rig/rspec"

RSpec.describe Pubid::Iso::Parser do
  subject { described_class.new }

  it "parses ISO 3166 2-character language codes" do
    expect(subject.language).to parse("(en,ru,fr)")
  end

  it "parses a single character codes" do
    expect(subject.language).to parse("(R/E)")
  end

  it "parses part" do
    expect(subject.part).to parse("-1")
    expect(subject.part_matcher).to parse("20601")
  end

  describe "parse identifiers from examples files" do
    shared_examples "parse identifiers from file" do
      it "parse identifiers from file" do
        f = open("spec/fixtures/#{examples_file}")
        f.readlines.each do |pub_id|
          next if pub_id.match?("^#")
          expect(subject).to parse(pub_id.split("#").first.strip.chomp)
        end
      end
    end

    context "parses identifiers from iso-pubid-basic.txt" do
      let(:examples_file) { "iso-pubid-basic.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iso-pubid-nsb.txt" do
      let(:examples_file) { "iso-pubid-nsb.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iso-pubid-coramd.txt" do
      let(:examples_file) { "iso-pubid-coramd.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iso-pubid-languages.txt" do
      let(:examples_file) { "iso-pubid-languages.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iwa-pubid.txt" do
      let(:examples_file) { "iwa-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iso-pubid-draft-amd-cor.txt" do
      let(:examples_file) { "iso-pubid-draft-amd-cor.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iso-pubid-legacy-tr-ts.txt" do
      let(:examples_file) { "iso-pubid-legacy-tr-ts.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parse identifiers from iso-pubid-french.txt" do
      let(:examples_file) { "iso-pubid-french.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iso-pubid-russian.txt" do
      let(:examples_file) { "iso-pubid-russian.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iso-pubid-directives.txt" do
      let(:examples_file) { "iso-pubid-directives.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iso-pubid-supplement-iteration.txt" do
      let(:examples_file) { "iso-pubid-supplement-iteration.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iso-pubid-cd.txt" do
      let(:examples_file) { "iso-pubid-cd.txt" }

      it_behaves_like "parse identifiers from file"
    end
  end
end
