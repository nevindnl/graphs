require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra(source)
  min_distances = {}
  running_distances = {}

  running_distances[source] = {cost: 0}

  until running_distances.empty?
    vertex, min_distance = running_distances.min_by{|_, distance| distance[:cost]}

    min_distances[vertex] = min_distance
    running_distances.delete(vertex)

    vertex.out_edges.each do |edge|
      neighbor = edge.to_vertex
      next if min_distances[neighbor]

      current_distance = running_distances[neighbor]
      new_distance = min_distance[:cost] + edge.cost

      if current_distance
        if current_distance[:cost] > new_distance
          running_distances[neighbor] = {cost: new_distance}
        end
      else
        running_distances[neighbor] = {cost: new_distance}
      end
    end
  end

  min_distances
end
