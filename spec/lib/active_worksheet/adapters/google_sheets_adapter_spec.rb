require "spec_helper"

RSpec.describe ActiveWorksheet::Adapters::GoogleSheetsAdapter do
  class Savings < ActiveWorksheet::Base
    self.source = "https://docs.google.com/spreadsheets/d/1dFM1P2KxhS5EMHc-aX50-DwX7LyRN9YNzuSehCHVYJI/edit"
    self.authorization = {
      credentials: Google::Auth::UserRefreshCredentials.new(
        client_id: "CLIENT_ID",
        client_secret: "CLIENT_SECRET",
        refresh_token: "REFRESH_TOKEN",
        type: "authorized_user"
      )
    }
  end

  it "#all" do
    expect(Savings.all.count).to eq 52
  end

  it "#find" do
    savings = Savings.find(0)
    expect(savings.week).to eq "1"
  end

  it "#first" do
    savings = Savings.first
    expect(savings.weekly_savings).to eq "S/.25.00"
  end

  it "#last" do
    savings = Savings.last
    expect(savings.done).to eq "FALSE"
  end

  it "#count" do
    expect(Savings.count).to eq 52
  end
end