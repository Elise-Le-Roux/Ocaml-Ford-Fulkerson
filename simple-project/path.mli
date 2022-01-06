open Graph

(* A path is a list of nodes. *)
type path = id list

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 * forbidden is a list of forbidden nodes (they have already been visited) *)
val find_path: int graph -> id list -> id -> id -> path option

(* Print a path option, 
 * if the path option is of type "some path" then print the path,
 * else if it is of type "None" then print "No path found". *)
val print_path_option: path option -> unit

(* find_min gr p returns the minimal value of the labels encountered on the given path *)
val find_min: int graph -> path -> int
