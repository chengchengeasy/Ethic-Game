class WelcomeController < ApplicationController
  def index
    # This is default info til we get info from the db
    #@scenarioNames = ["Test Scenario", "Water Boiling Exercise", "Team Building Exercise"];
    @scenarioNames = Scenario.get_all_scenarios
    
    @scenarios = Scenario.all
  end
  
  def detail
    #@scenario = params[:scenario]
    id = params[:id] # retrieve movie ID from URI route
    @scenario = Scenario.find(id) # look up movie by unique ID
  end
  
  def show
    #@scenario = params[:scenario]
    id = params[:id] # retrieve movie ID from URI route
    @scenario = Scenario.find(id) # look up movie by unique ID
    
    # For now assume only one player
    @player = Player.find(1)
    
    @histories = PlayerHistory.get_player_history(@player)
    @history_length = @histories.size
    
    @question_history = PossibleQuestion.get_question_by_history(@histories)
    @response_history = PossibleResponse.get_response_by_history(@histories)
    
    #Test code for getQuestionResponses
    groups = Group.all
    group = groups[0]
    group_possible_questions = GroupsPossibleQuestion.where("group_id = ?", group.id)
    group_possible_question = group_possible_questions[0];
    #puts("Group possible questions = #{group_possible_question}")
    responses = getQuestionResponses(group_possible_question)
    responses.each do |resp|
      puts("Response is #{resp.response}")
    end
  end
  
  def show_history
    
  end
  
  def getQuestionResponses(group_question) 
    # Send in group possible questions
    responses = []
    question_responses = PossibleQuestionsResponse.where("possible_question_id = ?", group_question.possible_question_id)
    question_responses.each do |question_response|
      #Loop through all the questions responses objects and gets there possible response
      
      resp = question_response.possible_response
      responses.push(resp)
    end
    return responses
  end
  
end
