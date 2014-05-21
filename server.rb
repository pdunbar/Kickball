require 'sinatra'
require 'csv'
require 'shotgun'

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
  team_list =[]
  positions_list =[]

  @rosters.each do |roster|
    if !team_list.include? roster[:team]
      team_list << roster[:team]
    end
    if !positions_list.include? roster[:position]
      positions_list << roster[:position]
    end
  end
  @team_list = team_list
  @positions_list = positions_list

  erb :index
end

get '/teams/:team' do
  @rosters = load_list
  @roster = @rosters.find do |roster|
    roster[:team] == params[:team]
  end
  @team = params[:team]
  erb :teams
end

get '/positions/:position' do
  @rosters = load_list
  @roster = @rosters.find do |roster|
    roster[:position] == params[:position]
  end
  erb :positions
end

