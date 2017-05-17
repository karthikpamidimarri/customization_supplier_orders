Spree::Order.class_eval do
  has_many :supplier_variants, through: :variants
end
