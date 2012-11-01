require File.dirname(__FILE__) + '/../test_helper'

class TeamUserNodeTest < ActiveSupport::TestCase
  fixtures :nodes, :users, :teams, :courses

  def test_get_with_parent_id
    team_given = nodes(:node18)
    course = courses(:course0)
    team_given.class.get(team_given.parent_id).each do |team|
      assert_equal course.id, team.parent_id
    end
  end

  def test_get_without_parent_id
    #empty result set if parent id is nil
    team_given = nodes(:node18)
    result = team_given.class.get(nil)
    assert_equal 0, result.count
  end

  def test_sql_injection
    team_given = nodes(:node18)
    result = team_given.class.get("' OR 1 --")
    #attempted sql injection should result in empty result set
    assert_blank result
  end
end