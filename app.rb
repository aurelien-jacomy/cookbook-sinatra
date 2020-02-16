require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require_relative 'cookbook'
require_relative 'scrap_marmiton_service'
require "better_errors"
set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

# -------- CONTROLLER ----------
# SHOW LIST OF RECIPES
get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :create
end

get '/destroy' do
  erb :select_recipe
end

post '/recipes' do
  recipe = Recipe.new(params[:name], params[:description], params[:prep_time], params[:difficulty])
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/destroy/:recipe_id' do
  recipe_id = params[:recipe_id].to_i
  cookbook.remove_recipe(recipe_id)
  redirect '/'
end

get '/search' do
  @keyword = params[:keyword]
  @recipes = ScrapMarmitonService.call(@keyword)
  RECIPES = @recipes
  erb :select_recipe
end

get '/add/:index' do
  recipe = RECIPES[params[:index].to_i]
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/mark_as_done/:index' do
  recipe_id = params[:index].to_i
  cookbook.mark_as_done(recipe_id)
  redirect '/'
end

