require File.dirname(__FILE__) + '/../test_helper'

class TaTest < ActiveSupport::TestCase
  fixtures :users, :roles, :ta_mappings, :courses

  def setup
    @ta= Ta.new(
        :name => "ta5", :parent_id => Fixtures.identify(users(:instructor1)), :fullname => "teaching_assistant5", :password => Digest::SHA1.hexdigest("ta5"),
        :password_salt => nil, :email => "ta5@mailinator.com", :role_id => Fixtures.identify(roles(:Teaching_Assistant_role)), :email_on_review => 1,
        :email_on_submission => 1, :email_on_review => 1, :master_permission_granted => 1, :handle => "ta5"
    )
    @ta.save!
    TaMapping.new( :ta_id => @ta.id , :course_id => Fixtures.identify(:course_object_oriented)).save!
  end

  def test_get_instructor
    instructor1 = users(:instructor1)
    assert_equal instructor1.id, @ta.get_instructor
  end

  def test_set_courses_to_assignment
    assert_equal [courses(:course_object_oriented)],@ta.set_courses_to_assignment
  end

  def test_set_instructor
    assign_assignment = Assignment.new
    @ta.set_instructor(assign_assignment)
    assert_equal users(:instructor1).id,assign_assignment.instructor_id
    assert_equal courses(:course_object_oriented).id,assign_assignment.course_id
  end

  def test_get_mapped_courses
    assert_equal [courses(:course_object_oriented).id],Ta.get_mapped_courses(@ta.id)
  end

  def test_get_mapped_courses_with_nil_user
    assert_blank Ta.get_mapped_courses(nil)
  end

  def test_get_mapped_instructor_ids
    assert_equal [users(:instructor1).id],Ta.get_mapped_instructor_ids(@ta.id)
  end

  def test_get_mapped_instructor_ids_with_nil_user
    assert_blank Ta.get_mapped_instructor_ids(nil)
  end

end