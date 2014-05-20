require 'sinatra'
require 'csv'


get '/' do
  @rosters = {}
  @positions = {}

  CSV.foreach(lackp_starting_rosters.csv, headers: true) do |row|
      team = row["team"]
      position = row["position"]
      last_name = row["last_name"]
      first_name = row["firs_name"]

      @positions[position] = {team: [first_name + " " + last_name]}
      @rosters[team] = {position: [first_name + " " + last_name]}
    end
end


get '/rosters/:team' do
  @rosters
  erb :teams
end


get 'postions/:position' do
  @position = params[:position]
  # The :task_name is available in our params hash
  erb :positions
end

