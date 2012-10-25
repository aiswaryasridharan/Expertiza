require File.dirname(__FILE__) + '/../test_helper'

class TeamNodeTest < ActiveSupport::TestCase
  fixtures :nodes, :teams,:teams_users, :courses

  def test_get_name
    team_given = nodes(:node12)
    team_expected = teams(:team0)
    assert_equal team_expected.name, team_given.get_name
  end

  def test_get_children
    team_given = nodes(:node12)
    assert_blank team_given.get_children
  end

  def test_get_with_parent_id
    team_given = nodes(:node14)
    course = courses(:course0)
    team_given.class.get(team_given.parent_id).each do |team|
      assert_equal course.id, team.parent_id
    end
  end

  def test_get_without_parent_id
    team_given = nodes(:node12)
    team_expected = [nodes(:node12), nodes(:node13), nodes(:node14)]
    result = team_given.class.get(nil)
    assert_equal team_expected.count, result.count
    result.each do |output|
       assert team_expected.include?(output)
    end
  end

  def test_sql_injection
    team_given = nodes(:node12)
    result = team_given.class.get("' OR 1 --")
    assert_blank result
  end
end