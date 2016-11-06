require_relative 'graph'
require 'set'

# Implementing topological sort using both Kahn's and Tarjan's algorithms

# Kahn
def topological_sort(vertices)
  order = []

  in_edge_counts = vertices.each_with_object({}) do |vertex, hash|
    hash[vertex] = vertex.in_edges.length
  end

  queue = in_edge_counts.select{|_, in_edge_count| in_edge_count == 0}.keys
  until queue.empty?
    node = queue.shift
    order << node

    neighbors = node.out_edges.map(&:to_vertex)
    neighbors.each do |neighbor|
      in_edge_counts[neighbor] -= 1
    end

    queue += neighbors.select{|neighbor| in_edge_counts[neighbor] == 0}
  end

  order.length == vertices.length ? order : []
end

# Tarjan
def topological_sort(vertices)
  visited = Set.new

  vertices.each do |vertex|
    next if visited.include? vertex

    visit(vertex, visited, order)
  end

  order
end

def visit vertex, visited, order
  visited.add(vertex)

  neighbors = vertex.out_edges.map(&:to_vertex)
  neighbors.each do |neighbor|
    next if visited.include? neighbor

    visit(neighbor, visited, order)
  end

  order.unshift(vertex)
end
