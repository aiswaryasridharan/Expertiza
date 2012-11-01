
class Ta < User
  has_many :ta_mappings

  #Applied refactorings :
  #unused constants QUESTIONNAIRE, ASSIGNMENT were removed
  #unused methods list_all, list_mine were removed

  def get(object_type, id, user_id)
    object_type.find(:first, 
                     :conditions => ["id = ? AND (instructor_id = ? OR private = 0)", 
                                     id, user_id])
  end
  
  def self.get_my_instructor(user_id)
    course_id = TaMapping.get_course_id(user_id)
    Course.find(course_id).instructor_id
  end
  
  def self.get_mapped_instructor_ids(user_id)
    ids = Array.new
    mappings = TaMapping.find_all_by_ta_id(user_id)
    mappings.each{
      |map|
      ids << map.course.instructor.id
    }
    return ids
  end  
  
  def self.get_mapped_courses(user_id)
    ids = Array.new
    mappings = TaMapping.find_all_by_ta_id(user_id)
    mappings.each{
      |map|
      ids << map.course.id
    }
    return ids
  end
  
  def get_instructor
    Ta.get_my_instructor(self.id)
  end
  
  def set_instructor (new_assign)
    new_assign.instructor_id = Ta.get_my_instructor(self.id)
    new_assign.course_id = TaMapping.get_course_id(self.id)
  end
  
  def set_courses_to_assignment
    @courses = TaMapping.get_courses(self.id)    
  end
  
end