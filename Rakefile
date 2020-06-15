require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do

  Pry.start
end

desc "seeds the file"
task :seed do
  sh "ruby db/seeds.rb"
end

desc "reseeds before starting the game"
task :start_game => :seed do
  # sh "rake db:seed"
  sh "ruby bin/run.rb"
end
