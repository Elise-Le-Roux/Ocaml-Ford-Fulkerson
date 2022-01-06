open Graph
open Printf
open Tools
    
type path = string

(* Reads a line with a university. *)
let read_university graph line =
  try Scanf.sscanf line "u \"%s@\" %s" (fun id lbl -> (new_arc (new_node graph id) id "sink" lbl) )
  with e ->
    Printf.printf "Cannot read university in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"
    
(* Reads a line with a student. *)
let read_student graph line =
  try Scanf.sscanf line "s \"%s@\"" (fun id -> new_arc (new_node graph id) "source" id "1" )
  with e ->
    Printf.printf "Cannot read student in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Ensure that the given node exists in the graph. If not, create it. 
 * (Necessary because the website we use to create online graphs does not generate correct files when some nodes have been deleted.) *)
let ensure graph id = if node_exists graph id then graph else new_node graph id

(* Reads a line with a choice. *)
let read_choice graph line =
  try Scanf.sscanf line "c \"%s@\" \"%s@\""
        (fun id1 id2 -> new_arc (ensure (ensure graph id1) id2) id1 id2 "1")
  with e ->
    Printf.printf "Cannot read arc in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Reads a comment or fail. *)
let read_comment graph line =
  try Scanf.sscanf line " %%" graph
  with _ ->
    Printf.printf "Unknown line:\n%s\n%!" line ;
    failwith "from_file"

let from_file path =

  let infile = open_in path in

  (* Read all lines until end of file. *)
  let rec loop (graph : string graph) =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      let line = String.trim line in

      let graph2 =
        (* Ignore empty lines *)
        if line = "" then graph

        (* The first character of a line determines its content : n or e. *)
        else match line.[0] with
          | 'u' -> read_university graph line
          | 's' -> read_student graph line
          | 'c' -> read_choice graph line

          (* It should be a comment, otherwise we complain. *)
          | _ -> read_comment graph line
      in      
      loop graph2

    with End_of_file -> graph (* Done *)
  in

  let final_graph = loop (new_node (new_node empty_graph "source") "sink") in
  
  close_in infile ;
  final_graph
  
  let export path graph =
  (* Open a write-file. *)
  let ff = open_out path in

  (* Write in this file. *)
  fprintf ff "digraph finite_state_machine { \n";
  fprintf ff "    rankdir=LR; \n";
  fprintf ff "    size=\"20\" \n";
  fprintf ff "    node [shape = circle]; \n";
  
  (* Write all arcs *)
  e_iter graph (fun id1 id2 lbl -> fprintf ff "    \"%s\" -> \"%s\" [label = \"%s\"];\n" id1 id2 lbl) ;
  
  (* Write all nodes without outgoing arcs *)
  n_iter graph (fun id -> match (out_arcs graph id) with 
    | [] -> fprintf ff "    \"%s\";\n" id
    | _ -> () );
  
  fprintf ff "}\n" ;
  
  close_out ff ;
  ()
  
 let graph_results graph =
  
  (* clones the student and university nodes *)
  let graph1 = n_fold graph (fun graph id -> if id<>"source" && id<>"sink" then new_node graph id else graph) empty_graph in
  
  (* clones the arcs between the students and the universities where the flow equals 1 *)
  let f gr id1 id2 lbl = if id1<>"source" && id2<>"sink" && lbl<>(0,1) then new_arc gr id1 id2 lbl else gr in
  e_fold graph f graph1
  
  
 let write_results path graph =
  (* Open a write-file. *)
  let ff = open_out path in
  fprintf ff "RESULTS \n";
  
  (* Prepares a graph without the source node *) 
  let graph1 = n_fold graph (fun graph id -> if id<>"source" then new_node graph id else graph) empty_graph in
  (* Adds the arcs between the students and the universities with flow equal to 1 and the arcs between the universities and the sink *)
  let f gr id1 id2 lbl = if id1<>"source" && id2<>"sink" && lbl<>(0,1) then new_arc gr id1 id2 lbl else (if id2="sink" then new_arc gr id1 id2 lbl else gr) in
  let graph2 = e_fold graph f graph1 in
  
  (* Write all pairs of student->university *)
  e_iter graph2 (fun id1 id2 lbl -> if id2<>"sink" && lbl<>(0,1) then fprintf ff "    \"%s\" -> \"%s\"\n" id1 id2) ;
  
  (* Write students without university *)
  fprintf ff "\n";
  fprintf ff "Students without university : \n";
  n_iter graph2 (fun id -> if id<>"sink" then match (out_arcs graph2 id) with 
    | [] -> fprintf ff "    \"%s\"\n" id
    | _ -> ());
    
  close_out ff ;
  ()

