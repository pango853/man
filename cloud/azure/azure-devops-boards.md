
# Agile process work item types and workflow

REF: https://docs.microsoft.com/en-us/azure/devops/boards/work-items/guidance/agile-process-workflow?view=azure-devops


Portfolio backlog
[Epic]
 |
 |-- [Feature]
		|
--------+------------------------------------
		|
Product	|-- [User Story]   OR   [Bug]
backlog			|				  |
				|-- [Task]		  |-- [Task]
---------------------------------------------
Issue tracking [Issue]

Test
[Test Plan]
  |
  |-- [Test Suite]
          |
		  |-- [Test Case]
		         |   |
				 |   |-- [Shared Steps]
				 |
				 |------ [Shared Parameters]


# Difinitions

- User Story
  User stories define the applications, requirements, and elements that teams need to create.
  Teams define user stories to manage the backlog of work and then, using the Kanban board, track progress by updating the status of those stories.

	e.g. Cancel order form


# Steps

1. Define User Stories
2. Map User Stories to Features
3. Define Tasks linked to User Stories


# Agile workflow states

User Story:
	New  --> Active --> Resolved --> Closed
	 |^  <--        <--          <--
	 ||
	 ||-- Removed
	 |--> 
Bug:
	New  --> Active --> Resolved --> Closed
         <--        <--                |
               ^                       |
			   |------------------------
Task:
	New  --> Active --> Closed
	^|^  <--        <--   |
	|||                   |
	|||-- Removed         |
	||-->                 |
	|                     |
	----------------------|

# Workflow

A typical workflow progression for a user story follows:

1. The product owner creates a user story in the New state with the default reason, New user story
2. The team updates the status to Active when they decide to complete the work during the sprint
3. A user story is moved to Resolved when the team has completed all its associated tasks and unit tests for the story pass
4. A user story is moved to the Closed state when the product owner agrees that the story has been implemented according to the Acceptance Criteria and acceptance tests pass.
