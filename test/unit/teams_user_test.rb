require File.dirname(__FILE__) + '/../test_helper'

class TeamsUserTest < ActiveSupport::TestCase
  fixtures :teams_users, :users

  def test_get_user_name
    user = teams_users(:teams_users0)
    assert_equal "student1", user.name
  end

  def test_delete
    teams_user = TeamsUser.new(:team_id => Fixtures.identify(:team4), :user_id => Fixtures.identify(:student5))
    teams_user.save!
    id = teams_user.id
    assert_equal "student5", TeamsUser.find(id).name
    teams_user.delete
    assert_raises(ActiveRecord::RecordNotFound) { TeamsUser.find(id) }
  end
end
