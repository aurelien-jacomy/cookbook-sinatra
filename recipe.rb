class Recipe
  attr_reader :name, :description, :prep_time, :difficulty, :done

  def initialize(name, description, time, difficulty = nil, done = false)
    @name = name
    @description = description
    @prep_time = time
    @done = done
    @difficulty = difficulty
  end

  def mark_as_done
    @done = !@done
  end

  def done?
    @done
  end
end
