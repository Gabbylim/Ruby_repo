require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
   @user = users(:michael)
  end

  test "unsuccessful edit" do
   log_in_as(@user)
   get edit_user_path(@user)
   assert_template 'users/edit'
   patch user_path(@user), params: { user: { name: "", email: "fii@invalid", password: "foo",password_confirmation: "bar" } }
   assert_select "div.alert","Hey! you made 4 errors."
   assert_template 'users/edit'
   end

  test "successfl edit" do 
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Foo bar"
    email = "foo@bar.com"
    patch user_path(@user),params: { user: { name: name,email: email,password: "",password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email,@user.email
    end

  test "succesful edit with friendly forwarding" do
   
    get edit_user_path(@user)
    log_in_as(@user)
     assert_nil session[:forwarding_url]
    name = "Foo bar"
    email = "foo@bar.com"
    patch user_path(@user),params: { user: { name: name,email: email,password: "",password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,@user.name
    assert_equal email,@user.email
    end  

  

end
