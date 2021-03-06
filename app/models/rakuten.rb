class Rakuten
  require 'json'
  require 'net/https'
  require "uri"
  # TODO: 今後はDBにデータを保存できるようにして、APIの呼び出しを減らしたい！
  def self.get_item(item_code)
    data = {
      "applicationId": ENV['applicationId'],
      "itemCode": item_code,
    }

    query = data.to_query
    uri = URI("https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?" + query)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri)
    res = http.request(req)
    JSON.parse(res.body)
  end
end
