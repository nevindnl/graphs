class Node{
  constructor(id, neighbors){
    this.id = id;
    this.neighbors = neighbors;
  }
}

function bfs(source, target) {
  if (!(source instanceof Node) || !(target instanceof Node)) {
    return null;
  }

  const queue = [];
  const visited = new Set();

  const previousNodes = {};

  queue.push(source);

  function tracePath(node){
    const path = [node];
    while (path[0] !== source) {
      path.unshift(previousNodes[path[0]]);
    }
    return path;
  }

  while (queue.length !== 0) {
    let current = queue.shift();
    visited.add(current);

    for (let i = 0; i < current.neighbors.length; i++) {
      let node = current.neighbors[i];

      if (node === target) {
        previousNodes[node] = current;
        return tracePath(node);
      }

      if (!visited.has(node)) {
        queue.push(node);
        previousNodes[node] = current;
      }
    }
  }

  return null;
}
