require File.dirname(__FILE__) + '/../test_helper'

class SuperAdministratorTest < ActiveSupport::TestCase
  fixtures :users, :roles

  def setup
    @superadmin = SuperAdministrator.new(
        :name => "suadmin_new", :parent_id => Fixtures.identify(users(:superadmin)), :password => Digest::SHA1.hexdigest("suadmin_new"),
        :password_salt => nil, :email => "suadmin_new@mailinator.com",:role_id => Fixtures.identify(roles(:SuperAdministrator_role)),
        :email_on_review => 1, :email_on_submission => 1, :email_on_review => 1
    )
  end

  def test_get
    #tests if superadmin is able to fetch the right id of the object
    user_expected = users(:instructor1)
    user_obtained = @superadmin.get(User,users(:instructor1).id,nil)
    assert_equal user_expected, user_obtained
  end
end