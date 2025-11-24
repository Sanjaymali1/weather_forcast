# Responsible only for converting an address into lat/lon + ZIP.

class GeocodingService
  include HTTParty
  base_uri "https://nominatim.openstreetmap.org"

  def self.lookup(address)
    response = get("/search", query: { q: address, format: "json", limit: 1 })
    return nil if response.empty?

    {
      lat: response[0]["lat"],
      lon: response[0]["lon"],
      zip: response[0]["display_name"][/\b\d{5,6}\b/] # extract ZIP
    }
  end
end
