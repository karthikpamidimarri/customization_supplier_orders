Deface::Override.new(virtual_path: 'spree/admin/orders/_form',
                     name: 'add_if_statment_orders_form',
                     replace: 'strong.order-total',
                     text: "
        <% if try_spree_current_user && try_spree_current_user.supplier? %>
            <% order.shipments.each do |shipment| %>
                <% if can? :show, shipment %>
                    <td><%= Spree::Money.new(shipment.final_price_with_items, currency: shipment.currency).to_html %></td>
                <% end %>
            <% end %>
        <% else %>
            <td><%= order.display_total.to_html %></td>
        <% end %>

  ")

Deface::Override.new(:virtual_path => 'spree/admin/orders/index',
                     :name => "add_if_statment_orders_index",
                     :replace => "erb[loud]:contains('order.display_total.to_html')",
                     :text => "<% if try_spree_current_user && try_spree_current_user.supplier? %>
            <% order.shipments.each do |shipment| %>
                <% if can? :show, shipment %>
                    <%= Spree::Money.new(shipment.final_price_with_items, currency: shipment.currency).to_html %>
                <% end %>
            <% end %>
        <% else %>
            <%= order.display_total.to_html %>
        <% end %>"
  )
Deface::Override.new(:virtual_path => 'spree/admin/orders/_line_items',
                     :name => "add_can_statment_line_items",
                     :insert_before => "tr.line-item",
                     :text => "<% if can? :update, item %>"
)
Deface::Override.new(:virtual_path => 'spree/admin/orders/_line_items',
                     :name => "close_can_statment_line_items",
                     :insert_after => "tr.line-item",
                     :text => "<% end %>"
)

Deface::Override.new(virtual_path: 'spree/admin/orders/_line_items_edit_form',
                     name: 'add_if_statment_line_items_edit',
                     replace: 'strong.order-total',
                     text: "
        <% if try_spree_current_user && try_spree_current_user.supplier? %>
            <% order.shipments.each do |shipment| %>
                <% if can? :show, shipment %>
                    <td><%= Spree::Money.new(shipment.final_price_with_items, currency: shipment.currency).to_html %></td>
                <% end %>
            <% end %>
        <% else %>
            <td><%= order.display_total.to_html %></td>
        <% end %>

  ")
Deface::Override.new(virtual_path: 'spree/admin/orders/_shipment',
                     name: 'can_check_for_shipment_starting_page',
                     insert_before: '[data-hook="admin_shipment_form"]',
                     text: "<% if can? :manage, shipment %>")
Deface::Override.new(virtual_path: 'spree/admin/orders/_shipment',
                     name: 'can_check_for_shipment_ending_page',
                     insert_after: '[data-hook="admin_shipment_form"]',
                     text: "<% end %>")