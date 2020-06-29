require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
 def setup
  @user = users(:michael)
 end
 test "layout links" do
   get root_path
   assert_template 'static_pages/home'
   assert_select "a[href=?]",root_path,count: 0
   assert_select "a[href=?]",help_path
   assert_select "a[href=?]",about_path
   assert_select "a[href=?]",contact_path
 end

  test "site layout" do
   get root_path
   assert_template 'static_pages/home'
   assert_select "a[href=?]",login_path
   get login_path
   assert_select "title", "Log in | ChattboxKE"
   log_in_as(@user)
   assert_redirected_to(@user)
   follow_redirect!
   assert_select "a[href=?]",users_path
   assert_select "a[href=?]",edit_user_path(@user)
   assert_select "a[href=?]",logout_path
   
  end

end
