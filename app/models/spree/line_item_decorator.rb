Spree::LineItem.class_eval do
  # TODO here to fix cancan issue thinking its just Order

  has_one :supplier_variants, through: :variant
  has_one :suppliers, through: :supplier_variants

end
