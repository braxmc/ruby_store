# Display a menu in the console
  #:heavy_check_mark: for the user to interact with.
# Create a default array of hashes
  #:heavy_check_mark:that represent items at a grocery store.
# Create a menu option to add items
  #to a user's grocery cart.
# Create a menu option to display
  #all the items in the cart.
# Create a menu option to remove
  #an item from the users cart.
# Create a menu option to show the total cost
  #of all the items in the user's cart.
# Add new items to the grocery store.
# Zip it up and turn it in!
# This works
require 'pry'

@money = 15

Store_inventory = [
  {name: 'Apple', price: 2, qty: 5},
  {name: 'Orange', price: 3, qty: 5},
  {name: 'Cherry', price: 1, qty: 5}
]

Cart = []

Purchased = []
# This works
def menu
  puts "---------------------------"
  puts "Welcome to the Ruby Store."
  puts 'What would you like to buy?'
  puts '1) Store Inventory'
  puts '2) Add items to cart'
  puts '3) Remove item from cart'
  puts '4) View cart'
  puts '5) Total Cost'
  puts '6) Add new store item'
  puts '7) Remove all items from cart'
  puts '8) View balance'
  puts '9) Checkout'
  puts '10) Select to recieve 25% off order before checkout'
  puts '11) Transaction History'
  puts '12) Exit'
  puts "---------------------------"
  user_choice = gets.strip.to_i
  if user_choice === 1
    puts 'This is what we have for sale:'
    show_inventory
    menu
  elsif user_choice === 2
    add_cart_item
    # gets menue to add items to inventory
  elsif user_choice === 3
    remove_cart_item
  elsif user_choice === 4
    view_cart
    menu
  elsif user_choice === 5
    # @cart but it only pulls pricing and it totals it up
    cart_menu_total
  elsif user_choice === 6
    # Add new item to the store inventory
    add_store_item
  elsif user_choice === 7
    cart_remover
  elsif user_choice === 8
    view_balance
  elsif user_choice === 9
    checkout
  elsif user_choice === 10
    order_discount
  elsif user_choice === 11
    transaction_history
  elsif user_choice === 12
    puts 'Good Bye!'
    exit
  else
    puts 'plz choose options 1-6'
    # recursion - call methods to be used over and over again
    menu
  end
end
# 1) Store Inventory
def show_inventory
  Store_inventory.map.with_index { |i,index|
    puts "#{index + 1}: #{i[:name]} $#{i[:price]} in stock: #{i[:qty]}"
  }
end
# 2) Add items to cart
def add_cart_item
  puts 'Type an item number to add it to your cart:'
  show_inventory
  user_choice = gets.strip.to_i
  if Store_inventory[user_choice - 1][:qty] >= 1
  Cart <<  Store_inventory[user_choice - 1]
  puts 'Item added'
  Store_inventory[user_choice - 1][:qty] -= 1
  end
  if Store_inventory[user_choice][:qty] == 0
    puts "Out of Stock"
  end
  menu
end
# 3) Remove item from cart
def remove_cart_item
  puts "Select an item's number to remove:"
  view_cart
  user_choice = gets.strip.to_i
  if Cart[user_choice - 1][:qty] >= 1
    Cart[user_choice - 1]
    Cart[user_choice -1][:qty] += 1
  end
  Cart.delete_at(user_choice - 1)
  menu
end
# 4) View Cart
def view_cart
  if Cart.empty?
    puts 'your cart is empty'
  end
  puts "Here is your cart:"
  Cart.map.with_index { |i,index|
    puts "#{index + 1}: #{i[:name]} $#{i[:price]}"
  }
end
# 5) Total Cost
def cart_total
  if Cart.empty?
    total_cost = 0
    Cart.each { |item|
    total_cost = total_cost + item[:price]
    }
    total_cost
  else
    total_cost = 1
    Cart.each { |item|
      total_cost = total_cost * item[:price] }
  total_cost
  end
end
def item_tax_total
  if Cart.empty?
    total_cost = 0
    Cart.each { |item|
    total_cost = total_cost + item[:price]
    }
    total_cost
  else
    tax_total = 1.08.round(2)
    Cart.each { |tax|
    tax_total = tax_total * tax[:price]
    }
  tax_total
  end
end
def cart_menu_total
  if @discount
  puts "Discount price before tax: $#{@discount}"
  puts "Discount price after tax: $#{@discount_tax}"
  else
  puts "Cart Total Before Tax: $#{cart_total}"
  puts "Cart Total After Tax: $#{item_tax_total}"
  end
  menu
end
# ^ this will show price, but won't add it together
# 6) Add new store item
def add_store_item
  puts 'enter name'
  name = gets.chomp
  puts 'enter price'
  price = gets.chomp
  puts 'enter stock quantity'
  qty = gets.chomp
  new_item = {name: name, price: price, qty: qty}
  Store_inventory << new_item
  puts 'item added to inventory'
  menu
end
# 7) Remove all items from cart_total
# Allow a user to remove multiple items at once from the cart.
def remove_all_from_cart
  Cart.clear
end
def cart_remover
  remove_all_from_cart
  puts "Items removed"
  menu
end
# 8) Assign the user an amount of money to start.
def view_balance
  puts "$#{@money}"
  menu
end
# 9) Give the user the option to "Check out".
# If they have enough money, their cart gets cleared and money is subtracted.
# If they don't have enough money, they have to delete items.
def checkout
  if @discount_tax
    if @money < @discount_tax
      puts "Insufficent funds, please remove items"
      menu
    end
  @money -= @discount_tax
  else
    if @money < item_tax_total
      puts "Insufficent funds, please remove items"
      menu
    end
  @money -= item_tax_total
  end
  Cart.map { |item|
  Purchased << item}
  remove_all_from_cart
  puts 'Thanks for purchasing'
  puts "Remaining balance $#{@money}"
  menu
end
# 10) Apply some sort of coupon system.
# For example, a 20% off coupon that takes the price of all items down by 20%
# applies 25% off
def order_discount
  @discount = cart_total * 0.75
  @discount_tax = item_tax_total * 0.75
  puts "enjoy the discount!"
  puts "New price before tax: $#{@discount}"
  puts "New price after tax: $#{@discount_tax}"
  menu
end

# 11) Apply taxes to transaction.
# 12) A menu option that shows a history of all the items purchased. (While the script runs)
def transaction_history
  Purchased.map.with_index { |i, index|
    puts "#{index + 1}: #{i[:name]} $#{i[:price]}"
  }
  menu
end
# 13) Grocery store items have a quantity. (They can be out of stock)
menu
