class SearchesController < ApplicationController
  def user_search
    search = params[:search]
    word = params[:word]
    @users = User.user_search(search,word)
  end

  def search
    search = params[:search]
    word = params[:word]
    @comment = Comment.search(search,word)
    @users = User.all
    @comments = Comment.page(params[:page]).without_count.per(4).order(created_at: :desc)
    @name = {}
    @image = {}
    @comments.each do |comment|
      item_code = comment.item_code
      if item_code.present?
        chocolate = Rakuten.get_item(item_code)
        next if chocolate["Items"].blank?
        image_url = chocolate["Items"][0]["Item"]["mediumImageUrls"][0]["imageUrl"]
        item_name = chocolate["Items"][0]["Item"]["itemName"]
        if image_url.present?
          @image[item_code] = image_url
        end
        if item_name.present?
          @name[item_code] = item_name
        end
      end
    end
  
  end
end
