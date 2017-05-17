# Implementation class for Cancan gem.  Instead of overriding this class, consider adding new permissions
# using the special +register_ability+ method which allows extensions to add their own abilities.
#
# See http://github.com/ryanb/cancan for more details on cancan.

module Spree
  Ability.class_eval do

    def initialize(user)
      self.clear_aliased_actions

      # override cancan default aliasing (we don't want to differentiate between read and index)
      alias_action :delete, to: :destroy
      alias_action :edit, to: :update
      alias_action :new, to: :create
      alias_action :new_action, to: :create
      alias_action :show, to: :read
      alias_action :index, :read, to: :display
      alias_action :create, :update, :destroy, to: :modify

      user ||= Spree.user_class.new

      if user.respond_to?(:has_spree_role?) && user.has_spree_role?('admin')
        can :manage, :all

          else
            can :display, Country
            can :display, OptionType
            can :display, OptionValue
            can :create, Order
            can [:read, :update], Order do |order, token|
              order.user == user || order.guest_token && token == order.guest_token
            end
            can :display, CreditCard, user_id: user.id
            can :display, Product
            can :display, ProductProperty
            can :display, Property
            can :create, Spree.user_class
            can [:read, :update, :destroy], Spree.user_class, id: user.id
            can :display, State
            can :display, Taxon
            can :display, Taxonomy
            can :display, Variant,supplier_variants: { supplier_id: user.supplier_id }
            can :display, Zone
        end


      # Include any abilities registered by extensions, etc.
      Ability.abilities.merge(abilities_to_register).each do |clazz|
        ability = clazz.send(:new, user)
        @rules = rules + ability.send(:rules)
      end

      # Protect admin role
      cannot [:update, :destroy], Role, name: ['admin']
    end


  end
end
