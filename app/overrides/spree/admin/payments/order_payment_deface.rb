
Deface::Override.new(:virtual_path => 'spree/admin/payments/_list',
                     :name => "add_can_statment_payment",
                     :replace => "td.amount.text-center",
                     :text => "<td class='amount.text-center'><% if try_spree_current_user && try_spree_current_user.supplier? %>
              <% @order.shipments.each do |shipment| %>
                  <% if can? :show, shipment %>
                      <%= Spree::Money.new(shipment.display_item_cost, currency: shipment.currency).to_html %>
                  <% end %>
              <% end %>
              <% else %>
                  <%= payment.display_amount %>
              <% end %></td>"
)

Deface::Override.new(virtual_path: 'spree/admin/payments/index',
                     name: 'add_can_statment_payment_index',
                     replace: 'strong',
                     text: "
        <% if try_spree_current_user && try_spree_current_user.supplier? %>
          <% @order.shipments.each do |shipment| %>
              <% if can? :show, shipment %>
                  <%= Spree::Money.new(shipment.display_item_cost, currency: shipment.currency).to_html %>
              <% end %>
          <% end %>
        <% else %>
            <%= @order.display_outstanding_balance %>
        <% end %>
  ")
