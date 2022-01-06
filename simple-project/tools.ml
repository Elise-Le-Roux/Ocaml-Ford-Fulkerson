open Graph


let clone_nodes (gr:'a graph) =
  n_fold gr new_node empty_graph


let gmap gr f = 
  let g1  = clone_nodes gr in
  let f1 g id1 id2 lbl = new_arc g id1 id2 (f lbl) in
  e_fold gr f1 g1


let add_arc g id1 id2 n =
  let value = find_arc g id1 id2 in
  match value with
  | Some a ->  new_arc g id1 id2 (a+n)
  | None ->  new_arc g id1 id2 n
