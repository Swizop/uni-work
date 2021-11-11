Consider a lot of natural numbers initially vida. The following types of operations are performed on this set:

operation type 1: element $x$ is added to the set (where $x$ is a parameter of the operation). If $x$ is already in the set, then it remains unchanged. operation type 2: delete element $x$, if it is already in the set. Otherwise, the crowd remains unchanged. *type 3 operation: returns $1$ if and only if $x$ is in the set, and otherwise returns $0$.

###Input

Input file hashuri.in contains on the first line the number $N$ of the operations performed. Each of the following $N$ lines contains a pair of natural numbers $(\text{op}$ $x)$, where $\text{op}$ is the number of the operation being performed (from $1$ to $3$) , and $x$ is the parameter of the operation.

###Output

Output file hashuri.out will contain a number of lines equal to the number of type $3$ operations in the input file. On each line will be the answer returned by the corresponding operation.

###Constraints

$3$ $≤$ $N$ $≤$ $1.000.000$
Each operation has a natural number parameter in the range $[1,$ $2.000.000.000]$