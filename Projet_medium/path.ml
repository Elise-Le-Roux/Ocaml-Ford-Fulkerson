open Graph


type path = id list


(* Returns a list of the first element of each tuple in list l 
 * For example first_elements [(1,2);(3,4);(5,6)] returns [1;3;5] 
 * 
 * This function is only used in find_path to extracte the destination identifiers 
 * in the list of arc out_arcs *)
let first_elements l =  
  let rec f_aux l acu = match l with
    | [] -> acu
    | (a,_) :: rest -> f_aux rest (a :: acu)
  in
  f_aux l []
  
  
let rec find_path gr forbidden id1 id2 =
  if id1 = id2 then Some [id1] else
    let neighbor_nodes =(List.filter (fun y -> not(List.mem y forbidden)) (first_elements ((out_arcs gr id1)))) in (* neighbor nodes of id1 that have not already been visited *)
    let rec f_aux gr neighbor_nodes id2 forbidden =
      match neighbor_nodes with
        | x :: rest -> if (find_path gr forbidden x id2) = None then f_aux gr rest id2 forbidden else (find_path gr forbidden x id2)
        | [] -> None
    in
    match (f_aux gr neighbor_nodes id2 (id1::forbidden)) with
      | Some p -> Some (id1 :: p)
      | None -> None


let rec print_path_option = function 
  | Some p -> (match p with
      | [] -> Printf.printf "\n%!"  
      | [x] -> Printf.printf "%s\n%!" x;
      | x :: rest -> Printf.printf "%s -> " x; print_path_option (Some rest))
  | None -> Printf.printf "No path found\n%!"  
  
  
let find_min gr path =
  let rec f_aux gr path min =
    match path with
      | [] -> min
      | [x] -> min
      | x :: ( y :: rest) -> match (find_arc gr x y) with
        | Some lbl -> if lbl < min then f_aux gr (y :: rest) lbl else f_aux gr (y :: rest) min
        | None -> failwith "invalid path"
  in
  f_aux gr path max_int


    
    
    
    
