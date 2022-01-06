open Gfile
open Tools
open Path
open Ford_fulkerson

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (******* Test clone_nodes *******)
  (* let graphtest = clone_nodes graph in 
  let () = export outfile graphtest in *)

  (******* Test gmap & add_arc *******)
  (* let graphtest = gmap (add_arc (gmap graph int_of_string) 0 1 5 ) string_of_int in
  let () = export outfile graphtest in *)
  
  (******* Test find_path *******)
  (* let p = find_path (gmap graph int_of_string) [] 0 5 in 
  let () = print_path_option p in *)

  (******* Test to_flow & flow_to_string *******)
  (* let graphtest =  flow_to_string (to_flow (gmap graph int_of_string)) in 
  let () = export outfile graphtest in *)

  (******* Test flow_to_residual *******)
  (* let flow = to_flow (gmap graph int_of_string) in
  let residual = gmap (flow_to_residual flow) string_of_int in
  let () = export outfile residual in *)

  (******* Test add_flow_arc *******)
  (* let flow = to_flow (gmap graph int_of_string) in
  let add1 = add_flow_arc flow 0 3 4 in
  let add2 = add_flow_arc add1 3 1 11 in
  let final = flow_to_string add2  in 
  let () = export outfile final in *)

  (******* Test add_flow_arc & flow_to_residual *******)
  (* let flow = to_flow (gmap graph int_of_string) in
  let add1 = add_flow_arc flow 0 3 4 in
  let add2 = add_flow_arc add1 3 1 11 in
  let residual = gmap (flow_to_residual add2) string_of_int in 
  let () = export outfile residual in *)

  (******* Test find_min *******)
  (* let p = find_path (gmap graph int_of_string) [] 0 5 in
  let min = match p with
     | Some p -> find_min (gmap graph int_of_string) p
     | None -> failwith "No path found" in
  let () = Printf.printf "min = %d \n %!" min ; print_path_option p in *)

  (******* Test fordFulkerson *******)
  let flow = ford_fulkerson (gmap graph int_of_string) _source _sink in
  let result = flow_to_string flow in
  let () = export outfile result in
  
  ()

