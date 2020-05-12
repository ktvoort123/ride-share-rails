class Api < ApplicationRecord
  include HTTParty

  BASE_URL = "https://randomuser.me/api/"

  def self.query
    response = HTTParty.get(BASE_URL)
    img_url = response['results'][0]['picture']['large']
    return img_url
  end

end





