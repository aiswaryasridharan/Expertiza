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
    assert_equal users(:instructor1), @superadmin.get(User,users(:instructor1).id,nil)
  end
end