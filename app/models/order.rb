class Order < ApplicationRecord
    has_many :order_items
    before_save :set_subtotal
    belongs_to :user

    def subtotal
        order_items.sum do |order_item|
          if order_item.valid? && order_item.unit_price.present? && order_item.quantity.present?
            order_item.unit_price * order_item.quantity
          else
            0
          end
        end
      end
      
      private
  
      def set_subtotal
          self[:subtotal]=subtotal
  
      end
end
