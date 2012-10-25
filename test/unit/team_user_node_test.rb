require File.dirname(__FILE__) + '/../test_helper'

class TeamUserNodeTest < ActiveSupport::TestCase
  fixtures :nodes, :users, :teams, :courses
=begin
  def test_get_name
    team_given = nodes(:node20)
    team_expected = users(:student5)
    assert_equal team_expected.name, team_given.get_name
  end
=end

  def test_get_with_parent_id
    team_given = nodes(:node18)
    course = courses(:course0)
    team_given.class.get(team_given.parent_id).each do |team|
      assert_equal course.id, team.parent_id
    end
  end

  def test_get_without_parent_id
    team_given = nodes(:node18)
    result = team_given.class.get(nil)
    assert_equal 0, result.count
  end

  def test_sql_injection
    team_given = nodes(:node18)
    result = team_given.class.get("' OR 1 --")
    assert_blank result
  end
end