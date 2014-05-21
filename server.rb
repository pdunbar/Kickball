require 'sinatra'
require 'csv'
require 'pry'

def load_list
  rosters =[]
  CSV.foreach('lackp_starting_rosters.csv', headers: true) do |row|
    roster = {
      first_name: row ["first_name"],
      last_name: row["last_name"],
      position: row["position"],
      team: row["team"]
    }
  rosters << roster
  end
  rosters
end

get'/' do
  @rosters = load_list
  erb :index
end

get '/teams/:team' do
  @rosters = load_list
  @roster = @rosters.find do |roster|
    roster[:team] == params[:team]
  end
  erb :teams
end

get '/positions/:position' do
  @rosters = load_list
  @roster = @rosters.find do |roster|
    roster[:position] == params[:position]
  end
  erb :positions
end

