require "rails_helper"

RSpec.describe Forecast, type: :model do
  let(:forecast) do
    Forecast.new(
      current_temp: 28,
      high: 30,
      low: 25,
      forecast_text: "Light rain expected tomorrow",
      source: "API"
    )
  end

  it "has current_temp" do
    expect(forecast.current_temp).to eq(28)
  end

  it "has high temperature" do
    expect(forecast.high).to eq(30)
  end

  it "has low temperature" do
    expect(forecast.low).to eq(25)
  end

  it "has forecast_text" do
    expect(forecast.forecast_text).to eq("Light rain expected tomorrow")
  end

  it "has source" do
    expect(forecast.source).to eq("API")
  end

  it "is immutable" do
    expect { forecast.instance_variable_set(:@current_temp, 100) }.to raise_error(FrozenError)
  end
end
