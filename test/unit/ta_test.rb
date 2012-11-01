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
    instructor_expected = users(:instructor1).id
    instructor_not_expected = users(:instructor2).id
    # tests if the ta has the right instructor
    instructor_obtained= @ta.get_instructor
    assert_equal instructor_expected, instructor_obtained
    assert_not_equal instructor_not_expected, instructor_obtained
  end

  def test_set_courses_to_assignment
    #tests if the assignment is mapped to the correct course
    assert_equal [courses(:course_object_oriented)],@ta.set_courses_to_assignment
  end

  def test_set_instructor
    #tests if the instructor and course are rightly set for a new assignment

    assign_assignment = Assignment.new
    @ta.set_instructor(assign_assignment)
    assert_equal users(:instructor1).id,assign_assignment.instructor_id
    assert_equal courses(:course_object_oriented).id,assign_assignment.course_id
  end

  def test_get_mapped_courses
    #tests if the Ta is mapped to the right course(s)
    assert_equal [courses(:course_object_oriented).id],Ta.get_mapped_courses(@ta.id)
  end

  def test_get_mapped_courses_with_nil_user
    #testing corner case : when the class method is invoked with nil argument(user_id)
    assert_blank Ta.get_mapped_courses(nil)
  end

  def test_get_mapped_instructor_ids
    #tests if the user is mapped to the right instructor
    assert_equal [users(:instructor1).id],Ta.get_mapped_instructor_ids(@ta.id)
  end

  def test_get_mapped_instructor_ids_with_nil_user
    #testing corner case : when the class method is invoked with nil argument(user_id)
    assert_blank Ta.get_mapped_instructor_ids(nil)
  end

  def test_get
    #tests if ta is able to fetch the right id of the course object
    course_expected = courses(:course_object_oriented)
    course_obtained = @ta.get(Course,courses(:course_object_oriented).id,users(:instructor1).id)
    assert_equal course_expected, course_obtained
  end
end