class TeamNode < Node
  def self.table
    "teams"
  end
  
  def self.get(parent_id)
    Node.get_team_or_user_node(parent_id, 'parent_id', self.table, self.to_s)
  end

  def get_name
    Team.find(self.node_object_id).name    
  end
  
  def get_children(sortvar = nil,sortorder = nil,user_id = nil,parent_id = nil)
    TeamUserNode.get(self.node_object_id)
  end  
end
