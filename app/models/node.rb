#Base Node class
#Provides common method definitions, but minimal functoinality.
#Must be subclassed for use in tree_display code
#
#Author: AJBUDLON
#Date: 7/18/2008
class Node < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :parent, :class_name => 'Node', :foreign_key => 'parent_id'

  # Retrieves the nodes of this type
  def self.get(sortvar = nil,sortorder =nil,user_id = nil,show = nil, parent_id = nil)       
  end

  #Retrieves node of a type for team and user nodes
  def self.get_team_or_user_node(parent_id, id_name, tablename, classname)
    query = "select nodes.* from nodes, #{tablename} where nodes.node_object_id = #{tablename}.id"
    query = query+" and nodes.type = ?"
    if parent_id
      query = query+ " and ? = ?"
      find_by_sql([query, classname, tablename+'.'+id_name, parent_id.to_s])
    else
      find_by_sql([query, classname])
    end
  end

  # Retrieves the children of this node
  def get_children(sortvar = nil,sortorder =nil,user_id = nil,show = nil,parent_id = nil)    
  end
  
  # Retrieves the action partial for this node
  def get_partial_name
     self.class.table+"_actions"      
  end
  
  # Most objects are not leaves
  # Currently only assignment and questionnaire are a leaf 
  # type node
  def is_leaf
    false
  end
  
  # Retrieves the corresponding model for the
  # node's object type
  def self.table 
  end
  
  # Retreives the node's object name
  def get_name
  end
  
  # Retrieves the node's object directory
  def get_directory
  end  
  
  # Retrieves the node's object create_at
  def get_creation_date
  end
  
  # Retrieves the type of children this node has
  def get_child_type   
  end
end
