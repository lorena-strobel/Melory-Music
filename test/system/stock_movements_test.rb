require "application_system_test_case"

class StockMovementsTest < ApplicationSystemTestCase
  setup do
    @stock_movement = stock_movements(:one)
  end

  test "visiting the index" do
    visit stock_movements_url
    assert_selector "h1", text: "Stock movements"
  end

  test "should create stock movement" do
    visit stock_movements_url
    click_on "New stock movement"

    fill_in "Item", with: @stock_movement.item_id
    fill_in "Movement date", with: @stock_movement.movement_date
    fill_in "Reason", with: @stock_movement.reason
    click_on "Create Stock movement"

    assert_text "Stock movement was successfully created"
    click_on "Back"
  end

  test "should update Stock movement" do
    visit stock_movement_url(@stock_movement)
    click_on "Edit this stock movement", match: :first

    fill_in "Item", with: @stock_movement.item_id
    fill_in "Movement date", with: @stock_movement.movement_date.to_s
    fill_in "Reason", with: @stock_movement.reason
    click_on "Update Stock movement"

    assert_text "Stock movement was successfully updated"
    click_on "Back"
  end

  test "should destroy Stock movement" do
    visit stock_movement_url(@stock_movement)
    click_on "Destroy this stock movement", match: :first

    assert_text "Stock movement was successfully destroyed"
  end
end
