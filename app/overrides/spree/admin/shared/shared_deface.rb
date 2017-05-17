Deface::Override.new(virtual_path: 'spree/admin/shared/_order_summary',
                     name: 'add_can_statment_orders_summary_for_sub_total_field',
                     replace: 'td#item_total',
                     text: "
        <td id='item_total'>
          <% if try_spree_current_user && try_spree_current_user.supplier? %>
              <% @order.shipments.each do |shipment| %>
                  <% if can? :show, shipment %>
                      <%= Spree::Money.new(shipment.display_item_cost, currency: shipment.currency).to_html %>
                  <% end %>
              <% end %>
          <% else %>
              <%= @order.display_item_total.to_html %>
          <% end %>
        </td>
  ")

Deface::Override.new(virtual_path: 'spree/admin/shared/_order_summary',
                     name: 'add_can_statment_orders_summary_for_ship_total_field',
                     replace: 'td#ship_total',
                     text: "
        <td id='ship_total'>
          <% if try_spree_current_user && try_spree_current_user.supplier? %>
              <% @order.shipments.each do |shipment| %>
                  <% if can? :show, shipment %>
                      <%= Spree::Money.new(shipment.display_cost, currency: shipment.currency).to_html %>
                  <% end %>
              <% end %>
          <% else %>
              <%= @order.display_ship_total.to_html %>
          <% end %>
        </td>
  ")
Deface::Override.new(virtual_path: 'spree/admin/shared/_order_summary',
                     name: 'add_can_statment_orders_summary_for_order_total_field',
                     replace: 'td#order_total',
                     text: "
        <td id='order_total'>
          <% if try_spree_current_user && try_spree_current_user.supplier? %>
              <% @order.shipments.each do |shipment| %>
                  <% if can? :show, shipment %>
                      <%= Spree::Money.new(shipment.final_price_with_items, currency: shipment.currency).to_html %>
                  <% end %>
              <% end %>
          <% else %>
              <%= @order.display_total.to_html %>
          <% end %>
        </td>
  ")