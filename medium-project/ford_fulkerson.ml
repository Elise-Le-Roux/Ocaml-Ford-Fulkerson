open Graph
open Tools
open Path


type flowGraph = (int*int) graph


let to_flow gr =
  let f lbl = (0, lbl) in
  gmap gr f


let flow_to_residual flow =
  let g1  = clone_nodes flow in
  let f1 g id1 id2 (flo,cap) = 
    match (flo,cap) with
    | (0,n) -> new_arc g id1 id2 n
    | (c,d) -> if c=d then new_arc g id2 id1 c else new_arc (new_arc g id1 id2 (d-c)) id2 id1 c
  in
  e_fold flow f1 g1


let add_flow_arc g id1 id2 n =
  let value = find_arc g id1 id2 in
  match value with
  | Some (a,b) -> new_arc g id1 id2 (a+n, b)
  | None -> g


let rec add_flow flow res path n =
  match path with
  | [] -> flow
  | [x] -> flow
  | x :: ( y :: rest) -> match ((find_arc res x y),(find_arc flow x y)) with
    | (None,_) -> failwith "invalid path or residual graph"
    | (_,None) -> add_flow (add_flow_arc flow y x (-n)) res (y::rest) n
    | (Some a, Some b) -> add_flow (add_flow_arc flow x y n) res (y::rest) n


let ford_fulkerson gr source puit =
  let init = to_flow gr in
  let rec f_aux flow source puit =
    let residual = flow_to_residual flow in
    let path = find_path residual [] source puit in
    match path with
    | None -> flow
    | Some p -> f_aux (add_flow flow residual p (find_min residual p) ) source puit
  in
  f_aux init source puit
  
  
let flow_to_string gr = gmap gr (fun (a,b) -> string_of_int(a) ^ "/" ^ string_of_int(b))
