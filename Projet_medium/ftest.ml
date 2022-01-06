open Gfile
open Tools
open Path
open Ford_fulkerson

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 3 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) outfile(2) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(2)

  in

  (* Open file *)
  let graph = from_file infile in

  (******* Test fordFulkerson *******)
  let flow = ford_fulkerson (gmap graph int_of_string) "source" "sink" in
  

  (* Write the results in the output file *)
  let () = write_results outfile flow in
  
  (* Export a graph showing the results *)
  (* let result = flow_to_string (graph_results flow) in
  let () = export outfile result in *)

  ()

