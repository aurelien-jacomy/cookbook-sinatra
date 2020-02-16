require 'csv'
require_relative 'recipe'

class Cookbook
  # 1 - Store recipes in an instance variable recipes = Array
  # 2 - Load a cookbook from a CSV File
  # 3 - Save the array into a CSV File
  # 4 - Return all recipes from repository cookbook
  # 5 - Add a recipe to the cookbook
  # 6 - Delete a recipe at index id from the repository

  def initialize(csv_path)
    @recipes = []
    @csv_path = csv_path
    if !csv_path.nil?
      CSV.foreach(csv_path) do |row|
        @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
      end
    else
      @csv_path = 'my_cookbook.csv'
    end
  end

  # def load_cookbook_from_csv(csv_path)
  # end

  def save_cookbook_to_csv
    # 1 - Check if the cookbook already has a file
    csv_options = { col_sep: ',', quote_char: '"' }
    CSV.open(@csv_path, 'w', csv_options) do |csv|
      @recipes.each_with_index do |recipe, index|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done]
      end
    end
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_cookbook_to_csv
  end

  def remove_recipe(recipe_id)
    @recipes.delete_at(recipe_id)
    save_cookbook_to_csv
  end

  def find_id(recipe_id)
    return @recipes[recipe_id]
  end

  def mark_as_done(recipe_id)
    @recipes[recipe_id].mark_as_done
    save_cookbook_to_csv
  end
end
