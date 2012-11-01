class TeamsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  #Applied refactorings
  # removed methods : get_team_members(empty), hello(unused)

  def name
    self.user.name
  end
  
  def delete
    TeamUserNode.find_by_node_object_id(self.id)
    team = self.team
    self.destroy
    if team.teams_users.length == 0
      team.delete    
    end
  end
end