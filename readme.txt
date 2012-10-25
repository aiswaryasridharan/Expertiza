E617. Refactoring and Testing (misc classes)	-- asridha2, varjun2, usridha

CLASSES:
models/super_administrator.rb (58 lines)
models/ta.rb (81 lines)
models/team_node.rb (23 lines)
models/team_user_node.rb (23 lines)
models/teams_user.rb (27 lines)

What it does: Manages teams, TA or super-admin functionality in Expertiza

Checklist:
	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
The SQL statements used across the different methods in classes (super_administrator, team_node, team_user_node) just plug-in the input values into the SQL 	code.   This may not be the appropriate way to write SQL considering this input is coming from the UI (SQL injection). Refactor/rewrite the SQL statements to 	avoid   direct plugi-in of variables.
	
We found that some of the code (which happens to use SQL statements) was not being used at all, and the functionailty is instead implemented using the controller (bad practice). Thus we have commented that code. Therefore the question of SQL injection does not arise for super_administrator. But, if in the future someone wishes to use the functionality present in the model instead of the controller, we have ensured that the commented code takes care of SQL injection. In the other two classes - team_node and team_user_node, the problem has been rectified.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	
Remove constants that are not being used in the class.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
The self.get methods in the team_node.rb and team_user_node.rb files contain the exact some code. Refactor the classes by removing duplicate code.
	
To accomplish this we have used pull up refactoring, by pulling the method up into the parent class Node. Since Node already has its own self.get, we rename the pulled up method as get_team_or_user_node.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
Remove any cases of empty methods in the listed set of files.
	
teams_user: get_team_members
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------		

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	Look for any unused methods or variables in these files.
	
team_user 	    : hello
super_administrator : list_admins, list_instructors, get (duplicate method)
ta		    : list_all
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	
Also apply other refactorings such as Rename variable, Rename method to give the variables and methods more meaningful names.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	
Write unit tests for all the methods in each of the above model classes.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


