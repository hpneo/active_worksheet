require "spec_helper"

RSpec.describe ActiveWorksheet::Adapters::FileAdapter do
  class Expectation < ActiveWorksheet::Base
    self.source = File.expand_path("../../../fixtures/file.xlsx", __FILE__)
  end

  it "#all" do
    expect(Expectation.all.count).to eq 119
  end

  it "#find" do
    expectation = Expectation.find(0)
    expect(expectation.responsability_title).to eq "Collaborate with team members and stakeholders to generate and incorporate feedback"
  end

  it "#first" do
    expectation = Expectation.first
    expect(expectation.responsability_title).to eq "Collaborate with team members and stakeholders to generate and incorporate feedback"
  end

  it "#last" do
    expectation = Expectation.last
    expect(expectation.cadence).to eq "Quarterly"
  end

  it "#count" do
    expect(Expectation.count).to eq 119
  end
end