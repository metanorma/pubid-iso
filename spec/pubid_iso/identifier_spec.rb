RSpec.describe PubidIso::Identifier do
  subject { described_class.parse(pubid) }

  shared_examples "converts pubid to urn" do
    it "converts pubid to urn" do
      expect(subject.urn.to_s).to eq(urn)
    end
  end

  context "ISO 4" do
    let(:pubid) { "ISO 4" }
    let(:urn) { "urn:iso:std:iso:4" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/IEC FDIS 7816-6" do
    let(:pubid) { "ISO/IEC FDIS 7816-6" }
    let(:urn) { "urn:iso:std:iso-iec:7816:-6:stage-50.00" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/TR 30406:2017" do
    let(:pubid) { "ISO/TR 30406:2017" }
    let(:urn) { "urn:iso:std:iso:tr:30406" }

    it_behaves_like "converts pubid to urn"
  end

  context "IWA 8:2009" do
    let(:pubid) { "IWA 8:2009" }
    let(:urn) { "urn:iso:std:iwa:8" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/IEC TR 24754-2:2011" do
    let(:pubid) { "ISO/IEC TR 24754-2:2011" }
    let(:urn) { "urn:iso:std:iso-iec:tr:24754:-2" }

    it_behaves_like "converts pubid to urn"
  end

  context "FprISO 105-A03" do
    let(:pubid) { "FprISO 105-A03" }
    let(:urn) { "urn:iso:std:iso:105:-A03:stage-50.00" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/IEC/IEEE 26512" do
    let(:pubid) { "ISO/IEC/IEEE 26512" }
    let(:urn) { "urn:iso:std:iso-iec-ieee:26512" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/IEC 30142 ED1" do
    let(:pubid) { "ISO/IEC 30142 ED1" }
    let(:urn) { "urn:iso:std:iso-iec:30142:ed-1" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO 22610:2006 Ed" do
    let(:pubid) { "ISO 22610:2006 Ed" }
    let(:urn) { "urn:iso:std:iso:22610:ed-1" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO 17121:2000 Ed 1" do
    let(:pubid) { "ISO 17121:2000 Ed 1" }
    let(:urn) { "urn:iso:std:iso:17121:ed-1" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO 11553-1 Ed.2" do
    let(:pubid) { "ISO 11553-1 Ed.2" }
    let(:urn) { "urn:iso:std:iso:11553:-1:ed-2" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO 21143.2" do
    let(:pubid) { "ISO 21143.2" }
    let(:urn) { "urn:iso:std:iso:21143" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/FDIS 21420.2" do
    let(:pubid) { "ISO/FDIS 21420.2" }
    let(:urn) { "urn:iso:std:iso:21420:stage-50.00.v2" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/TR 30406:2017" do
    let(:pubid) { "ISO/TR 30406:2017" }
    let(:urn) { "urn:iso:std:iso:tr:30406" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO 5843/6" do
    let(:pubid) { "ISO 5843/6" }
    let(:urn) { "urn:iso:std:iso:5843:-6" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/NP 23219" do
    let(:pubid) { "ISO/NP 23219" }
    let(:urn) { "urn:iso:std:iso:23219:stage-10.00" }

    it_behaves_like "converts pubid to urn"
  end

  context "IEC 80601-2-60" do
    let(:pubid) { "IEC 80601-2-60" }
    let(:urn) { "urn:iso:std:iec:80601:-2-60" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/TR27957:2008" do
    let(:pubid) { "ISO/TR27957:2008" }
    let(:urn) { "urn:iso:std:iso:tr:27957" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO 10231:2003/Amd 1:2015" do
    let(:pubid) { "ISO 10231:2003/Amd 1:2015" }
    let(:urn) { "urn:iso:std:iso:10231:amd:2015:v1" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO 10360-1:2000/Cor 1:2002" do
    let(:pubid) { "ISO 10360-1:2000/Cor 1:2002" }
    let(:urn) { "urn:iso:std:iso:10360:-1:cor:2002:v1" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO 13688:2013/Amd 1:2021(en)" do
    let(:pubid) { "ISO 13688:2013/Amd 1:2021(en)" }
    let(:urn) { "urn:iso:std:iso:13688:amd:2021:v1:en" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/IEC 10646:2020/CD Amd 1" do
    let(:pubid) { "ISO/IEC 10646:2020/CD Amd 1" }
    let(:urn) { "urn:iso:std:iso-iec:10646:stage-30.00:amd:v1" }

    it_behaves_like "converts pubid to urn"
  end

  context "ISO/IEC 13818-1:2015/Amd 3:2016/Cor 1:2017" do
    let(:pubid) { "ISO/IEC 13818-1:2015/Amd 3:2016/Cor 1:2017" }
    let(:urn) { "urn:iso:std:iso-iec:13818:-1:amd:2016:v3:cor:2017:v1" }

    it_behaves_like "converts pubid to urn"
  end
end
