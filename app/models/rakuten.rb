class Rakuten 
  
  require 'json'
  require 'net/https'
  require "uri"

  def self.get_item(item_code)
    data={
      "applicationId": "1066887408306301186",
      "itemCode": item_code
    }
    
    query=data.to_query
    uri = URI("https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?"+query)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri)
    res = http.request(req)
    res_data = JSON.parse(res.body)
  end
  def favorites
    Favorite.where(item_code: item_code)
  end
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
