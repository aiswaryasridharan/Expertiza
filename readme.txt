E617. Refactoring and Testing (misc classes)	-- asridha2, varjun2, usridha

Github link    	   - https://github.com/aiswaryasridharan/Expertiza
VCL link 	   - http://152.46.19.20:3000/

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

super_administrator : list_instructors and list_admins model methods are not invoked at all. This functionality is instead implemented using the controller (bad 				MVC practice). Thus we have commented out that code from the respective models. Therefore the question of SQL injection does not arise for 				super_administrator. But, if in the future someone wishes to use the functionality present in the model instead of the controller, we have 				ensured that the commented code takes care of SQL injection. 

team_node and team_user_node: SQL Injection issue has been rectified and the common query was pulled up to the parent class Node. The parameter 'tablename' is not 				subject to SQL injection attack (passed internally by the subclass) and hence left as is for convenience.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	
Remove constants that are not being used in the class.

super_administrator : QUESTIONNAIRE, SIGNUPSHEET, ASSIGNMENT

ta: QUESTIONNAIRE, ASSIGNMENT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
The self.get methods in the team_node.rb and team_user_node.rb files contain the exact some code. Refactor the classes by removing duplicate code.
	
To accomplish this we did an extract method refactoring to take the common query into a new function, upon which we applied a pull up refactoring, by pulling the method up into the parent class Node. Since Node already has its own self.get, we rename the pulled up method as get_team_or_user_node.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
Remove any cases of empty methods in the listed set of files.
	
teams_user: get_team_members
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------		

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	Look for any unused methods or variables in these files.
	
teams_user 	    : hello
super_administrator : Removed : list_all, list_all_private, get (duplicate method)
                      Commented : list_admins, list_instructors
ta		    : list_all, list_mine
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	
Also apply other refactorings such as Rename variable, Rename method to give the variables and methods more meaningful names.

super_administrator : Extract method : list_admins and list_instructors had the same code, which has been extracted out and put in another function, viz, 							list_admins_or_instructors

team_node and team_user_node : Extract method for common query in get() and then Pull Up to parent Node.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	
Write unit tests for all the methods in each of the above model classes.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

test/unit

super_administrator_test.rb
ta_test.rb
team_node_test.rb
team_user_node_test.rb
teams_user_test.rb