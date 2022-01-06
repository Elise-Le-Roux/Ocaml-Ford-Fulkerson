# Ocaml-Ford-Fulkerson

# simple-project
Implementation of the Ford-Fulkerson algorithm.

Execution : `./ftest.native [infile] [source] [sink] [outfile]`

Generate an image from the outfile dot file : `dot -Tsvg your-dot-file > some-output-file.svg`

The infile has to be added in the simple-project directory. Some graphs are already present for you to test (graph1.txt and graph2.txt).
You can also download your own graphs [here](https://algorithms.discrete.ma.tum.de/graph-algorithms/flow-ford-fulkerson/index_en.html).

# medium-project
Use-case of the Ford-Fulkerson algorithm (bipartite matching).

The program match a set of students to a set of universities given their choices.

Execution : `./ftest.native [infile] [outfile]`

The infile has to be in the following format :
```
u "[university's-name]" [number-of-places]

s "[name-of-the-student]"

c "[name-of-the-student]" "[university's-name]"
```

An example is available under the name "test.txt" and its result under the name "result_test.txt" (You can also find .svg images for this example).
