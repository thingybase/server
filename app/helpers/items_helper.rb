module ItemsHelper
  def item_expiration_tense(item)
    item.shelf_life_end > Time.now ?  "Expires" : "Expired"
  end
end
