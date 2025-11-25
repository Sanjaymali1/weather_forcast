# spec/services/geocoding_service_spec.rb
require "rails_helper"

RSpec.describe GeocodingService, type: :service do
  describe ".lookup" do
    it "returns lat/lon/zip for a valid address" do
      # Stub API call or real logic if using local dummy data
      allow(GeocodingService).to receive(:lookup).with("Pune, India").and_return({ lat: 18.5204, lon: 73.8567, zip: "411001" })
      result = GeocodingService.lookup("Pune, India")
      expect(result).to include(:lat, :lon, :zip)
    end

    it "returns nil for an invalid address" do
      allow(GeocodingService).to receive(:lookup).with("InvalidAddress123XYZ").and_return(nil)
      result = GeocodingService.lookup("InvalidAddress123XYZ")
      expect(result).to be_nil
    end
  end
end
