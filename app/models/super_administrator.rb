
class SuperAdministrator < User
  def get(object_type, id, user_id)
      object_type.find(:first, :conditions => ["id = ?", id])
  end

  #list_instructors and list_admins used in rendering the page have been called from the admin_controller module.
  #Logically it doesn't make sense to have a db call from the controller which is why these model methods have been
  #commented out and not deleted. In future, if somebody wants to write better mvc code, they can use these methods.
  #However, SQL injection issue has been resolved.
=begin

  def list_admins_or_instructors(object_type, user_id)
    if (object_type != SignupSheet)
      object_type.find(:all,
                       :joins => ["inner join users on ?.instructor_id = users.id AND users.parent_id = ?",object_type.to_s.pluralize, user_id.to_s])
    else
      object_type.find(:all,
                       :joins => ["inner join users on instructor_id = users.id AND users.parent_id = ?", user_id.to_s])
    end
  end

  def list_admins(object_type, user_id)
    list_admins_or_instructors(object_type, user_id)
  end

  def list_instructors(object_type, user_id)
    list_admins_or_instructors(object_type, user_id)
  end
=end

end