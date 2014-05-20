require 'sinatra'
require 'csv'
require 'pry'

get '/' do
  @rosters = {}
  @positions = {}

  CSV.foreach('lackp_starting_rosters.csv', headers: true) do |row|
      team = row["team"]
      position = row["position"]
      last_name = row["last_name"]
      first_name = row["first_name"]


      @positions[position] = {team => first_name}
      @rosters[team] = {position => first_name}
    end

    erb :teams
end



