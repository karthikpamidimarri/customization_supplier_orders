class AbilityDecorator
include CanCan::Ability
  def initialize(user)
    if user.respond_to?(:has_spree_role?) && (user.supplier)

      can [:manage], Spree::Order,  state: 'complete' , supplier_variants: { supplier_id: user.supplier_id }    
      can :manage, Spree::LineItem,supplier_variants: { supplier_id: user.supplier_id }
      can :manage, Spree::StateChange
      can :manage, Spree::Adjustment
      can :manage, Spree::Payment
      can :manage, Spree::ReturnAuthorization
      can :manage, Spree::CustomerReturn

    end
  end
end

Spree::Ability.register_ability(AbilityDecorator)

