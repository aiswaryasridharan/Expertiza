require File.dirname(__FILE__) + '/../test_helper'

class TeamsUserTest < ActiveSupport::TestCase
  fixtures :teams_users, :users

  def test_get_user_name
    #tests if the user_name is returned as expected

    user = teams_users(:teams_users0)
    user_name_expected = "student1"
    assert_equal user_name_expected, user.name
  end

  def test_delete
    #creates a new team user and tests if the new user can be deleted properly
    teams_user = TeamsUser.new(:team_id => Fixtures.identify(:team4), :user_id => Fixtures.identify(:student5))
    teams_user.save!
    id = teams_user.id
    user_name_expected = "student5"
    found_user = TeamsUser.find(id)
    assert_equal user_name_expected, found_user.name
    teams_user.delete
    #Corner case : since the user is deleted, the system should raise an error when that id is searched for
    assert_raises(ActiveRecord::RecordNotFound) { TeamsUser.find(id) }
  end
end
