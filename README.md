# LibCoopt： A Library for Combinatorial Optimization on Partial Permutation Matrices
[![license](https://img.shields.io/pypi/l/hdidx.svg?style=flat-square)](https://raw.githubusercontent.com/wanji/hdidx/master/LICENSE.md)

## What is **LibCoopt**?

**LibCoopt** is an open-source matlab code library which provides an general and convenient tool to approximately solve the combinatorial optimization problems on the set of partial permutation matrices. To use the library, the users only need to offer the objective function and its gradient function associated with the problem at hand. The software is applied to two typical combinatorial optimization problems, the subgraph matching problem and the quadratic assignment problem, to show how to use it, and also to illustrate its generality.

## Architecture

![Framework](https://github.com/RowenaWong/LibCoopt/blob/master/doc/framework.png)

For different combinatorial optimization problems on partial permutation matrices, **LibCoopt**  provides a input interface for the objective function and its gradient function which can be customized by the user according to the specific problem. In other words, to use LibCoopt the users only need to design the problem dependent objective function and deduct the corresponding gradient function. It is these customized functions that takes the problem related data as input, while LibCoopt is not directly related to the data. That is why LipCoopt is claimed to be a general and convenient tool for combinatorial optimization on partial permutation matrices. 


LibCoopt is mainly implemented by Matlab script, with some computationally intensive part implemented by Mex files. 

The core Matlab function is 
\begin{center}
\verb"Solution = Coopt(@F, @nF, Data, Para)"
\end{center}
where \verb"Solution" is the final combinatorial optimization solution including the minimal point, objective value, and running time. The first two inputs \verb"@F" and \verb"@nF" are the function handles of the customized objective function and its gradient function. The third input \verb"Data" is the problem related data. And \verb"Para" is the parameter structure. 

## Installation
Add all files to your  directory.

## Example

Here is a simple example. 

```matlab
# LibCoopt for GMAD
# LibCoopt for GMAF
# LibCoopt for QAP


## Reference
```
[1] Z.-Y. Liu, H. Qiao, Gnccpgraduated nonconvexityand concavity procedure, Pattern Analysis and Ma- 85
chine Intelligence, IEEE Transactions on 36 (6) (2014) 1258–1267. 86
[2] M. Zaslavskiy, F. Bach, J.-P. Vert, A path following algorithm for graph matching, in: Image and Signal 87
Processing, Springer, 2008, pp. 329–337. 88
[3] Z.-Y. Liu, H. Qiao, L. Xu, An extended path following algorithm for graph-matching problem, Pattern 89
Analysis and Machine Intelligence, IEEE Transactions on 34 (7) (2012) 1451–1456. 90
[4] X. Yang, H. Qiao, Z. Liu, Outlier robust point correspondence based on GNCCP, Pattern Recognition 91
Letters 55 (0) (2015) 8–14. 92
[5] Z. Liu, H. Qiao, A convex-concave relaxation procedure based subgraph matching algorithm., in: ACML, 93
2012, pp. 237–252. 94
[6] R. E. Burkard, S. E. Karisch, F. Rendl, Qaplib–a quadratic assignment problem library, Journal of 95
Global optimization 10 (4) (1997) 391–403
```
