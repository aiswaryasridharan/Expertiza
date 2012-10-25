class TeamUserNode < Node
  def self.table
    "teams_users"
  end  
  
  def get_name
    TeamsUser.find(self.node_object_id).name    
  end  
  
  def self.get(parent_id)
    Node.get_team_or_user_node(parent_id, 'team_id', self.table, self.to_s)
  end 
  
  def is_leaf
    true
  end
end
