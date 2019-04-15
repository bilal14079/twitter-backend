require "application_system_test_case"

class UserFriendsTest < ApplicationSystemTestCase
  setup do
    @user_friend = user_friends(:one)
  end

  test "visiting the index" do
    visit user_friends_url
    assert_selector "h1", text: "User Friends"
  end

  test "creating a User friend" do
    visit user_friends_url
    click_on "New User Friend"

    fill_in "Friend", with: @user_friend.friend_id
    fill_in "User", with: @user_friend.user_id
    click_on "Create User friend"

    assert_text "User friend was successfully created"
    click_on "Back"
  end

  test "updating a User friend" do
    visit user_friends_url
    click_on "Edit", match: :first

    fill_in "Friend", with: @user_friend.friend_id
    fill_in "User", with: @user_friend.user_id
    click_on "Update User friend"

    assert_text "User friend was successfully updated"
    click_on "Back"
  end

  test "destroying a User friend" do
    visit user_friends_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User friend was successfully destroyed"
  end
end
