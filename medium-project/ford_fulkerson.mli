open Graph
open Path

(* A flow graph is a graph whose arcs have for label a tuple indicating their flow and their capacity.
 * label = (flow,capacity)
 *)
type flowGraph = (int*int) graph

(* toFlow gr returns a flow graph whose arcs have for flow 0 and for capacity the value of the labels of gr. *)
val to_flow: int graph -> flowGraph

(* Converts a flow graph into a residual graph. *)
val flow_to_residual: flowGraph -> int graph

(* add_flow_arc gr id1 id2 n adds n to the flow of the arc between id1 and id2 in graph gr. *)
val add_flow_arc: flowGraph -> id -> id -> int -> flowGraph

(* add_flow gr res p n 
 *   adds n to the flow of all the arcs on the path p if this arc is positive.
 *   remove n to the flow of all the arcs on the path p if this arc is negative.
 *   
 * res is the residual graph it is used to check which arcs are positive and which ones are negative
 * according to their direction. *)
val add_flow: flowGraph -> int graph -> path -> int -> flowGraph

(* Performs the actual fordFulkerson algorithm using the functions above.
 * forFulkerson gr source sink returns a flow graph with a maximal flow between the source node and the sink node. *)
val ford_fulkerson: int graph -> id -> id -> flowGraph

(* Converts a flow graph into a string graph. *)
val flow_to_string: flowGraph -> string graph
