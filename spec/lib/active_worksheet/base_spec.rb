require "spec_helper"

RSpec.describe ActiveWorksheet::Base do
  SOURCES = [
    "https://docs.google.com/spreadsheets/d/1ICvYPjSDl7mj0J_3mPNCy7_kYqifpsTqLnuQcdXijUc/edit",
    File.expand_path("../../../fixtures/file.xlsx", __FILE__)
  ]

  class BrickLinkCart < ActiveWorksheet::Base
    self.source = SOURCES[0]
  end

  class Expectation < ActiveWorksheet::Base
    self.source = SOURCES[1]
  end

  it "defines a source" do
    expect(BrickLinkCart.source).to eq SOURCES[0]
    expect(Expectation.source).to eq SOURCES[1]

    expect(BrickLinkCart.is_source_remote?).to be true
    expect(Expectation.is_source_local?).to be true
  end

  it "chooses the right adapter" do
    expect(BrickLinkCart.adapter.class::ADAPTER_NAME).to eq "GoogleSheets"
    expect(Expectation.adapter.class::ADAPTER_NAME).to eq "File"
  end
end
