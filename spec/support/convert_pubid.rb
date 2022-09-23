shared_examples "converts pubid to urn" do
  it "converts pubid to urn" do
    expect(subject.urn.to_s).to eq(urn)
    expect(subject.urn.to_s).to eq(urn)
  end
end

shared_examples "converts pubid to pubid" do
  it "converts pubid to pubid" do
    expect(subject.to_s).to eq(pubid)
  end
end

shared_examples "converts to pubid with edition" do
  it "converts to pubid with edition" do
    expect(subject.to_s(with_edition: true)).to eq(pubid_with_edition)
  end
end

shared_examples "converts pubid to french pubid" do
  it "converts pubid to french pubid" do
    expect(subject.to_s(lang: :french)).to eq(french_pubid)
  end
end

shared_examples "converts pubid to russian pubid" do
  it "converts pubid to russian pubid" do
    expect(subject.to_s(lang: :russian)).to eq(russian_pubid)
  end
end
