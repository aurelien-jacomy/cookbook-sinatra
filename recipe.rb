class Recipe
  attr_reader :name, :description, :prep_time, :difficulty

  def initialize(name, description, time, difficulty = nil)
    @name = name
    @description = description
    @prep_time = time
    @done = false
    @difficulty = difficulty
  end

  def mark_as_done
    @done = !@done
  end

  def done?
    @done
  end
end
