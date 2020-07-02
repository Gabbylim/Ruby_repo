require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
 
   def setup
     @admin = users(:michael)
     @non_admin = users(:archer)

     @active = users(:lana)
     @nonactive = users(:malory)
   end

  test "index including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination',count: 2
    User.where(activated: true).paginate(page: 1).each do |user|
      assert_select 'a[href=?]',user_path(user),text: user.name
      end
    end

   test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.where(activated: true).paginate(page: 1)
    first_page_of_users.each do  |user|
      assert_select 'a[href=?]',user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]',user_path(user),text: 'delete'
        assert_equal true,user.activated?
       end
     end
   assert_difference 'User.count', -1 do
    delete user_path(@non_admin)
    end
  end
 
  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a',text: 'delete', count: 0
   end

  test "non active users redirected to root" do
    log_in_as(@nonactive)
    assert_redirected_to root_url
  end

  test "active users be redirected to their show page" do 
    log_in_as(@active)
    assert_redirected_to @active
  end
  end
 
