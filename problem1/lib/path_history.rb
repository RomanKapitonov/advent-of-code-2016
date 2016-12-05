class PathHistory
  attr_accessor :intersections, :history

  def initialize(history)
    @history = history
  end

  def intersections
    @intersections = {}

    history.each_with_index do |coordinates, index|
      (@intersections[coordinates] ||= []) << index
    end
    @intersections.delete_if { |k, v| v.size == 1 }
  end

  def first_intersection
    intersections.min_by { |k, v| v.sort.first }.first
  end
end
