class SearchesController < ApplicationController
  def user_search
    search = params[:search]
    word = params[:word]
    @user = User.search(search,word)

  end

  def search
    search = params[:search]
    word = params[:word]
    @comment = Comment.search(search,word)
    @image = {}
    @comment.each do |comment|
      item_code = comment.item_code
      if item_code.present? 
        chocolate = Rakuten.get_item(item_code)
        next if chocolate["Items"].empty?
        imageUrl = chocolate["Items"][0]["Item"]["mediumImageUrls"][0]["imageUrl"] 
        if imageUrl.present?
          @image[item_code] = imageUrl
        end
      end 
    end   
  end
  end
end
