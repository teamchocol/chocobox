require 'rails_helper'

RSpec.describe Rakuten, type: :model do
  it '楽天APIから情報を取得すること' do
  rakuten_mock = double('Rakuten item')
  allow(rakuten_mock).to receive(:get_item).and_return(JSON.parse('{"body":"milk-chocolate"}'))
  item_code = '31342'
  response = rakuten_mock.get_item(item_code)
  expect(response["body"]).to include('milk-chocolate')
  end
end
