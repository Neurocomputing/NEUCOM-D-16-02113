# LibCoopt：A Library for Combinatorial Optimization on Partial Permutation Matrices

## What is **LibCoopt**?

**LibCoopt** is an open-source matlab code library which provides an general and convenient tool to approximately solve the combinatorial optimization problems on the set of partial permutation matrices. To use the library, the users only need to offer the objective function and its gradient function associated with the problem at hand. The software is applied to two typical combinatorial optimization problems, the subgraph matching problem and the quadratic assignment problem, to show how to use it, and also to illustrate its generality.

## Architecture

![Framework](https://github.com/RowenaWong/LibCoopt/blob/master/doc/framework.png)

**LibCoopt**  provides a input interface for the objective function and its gradient function which can be customized by the user according to the specific problem. In other words, to use LibCoopt the users only need to design the problem dependent objective function and deduct the corresponding gradient function. 
**LibCoopt** is mainly implemented by Matlab script, with some computationally intensive part implemented by Mex files. Currently only the Windows operation system based version is provided.
The core Matlab function is 

**Solution = Coopt(@F, @nF, Data, Para)**

where *Solution* is the final combinatorial optimization solution including the minimal point, objective value, and running time. The first two inputs *@F* and *@nF* are the function handles of the customized objective function and its gradient function. The third input *Data* is the problem related data. And *Para* is the parameter structure. 

## Installation
Add all files to your directory.

## Example

Here is a simple example. 

```matlab
# demo_GMAD
solution1=run_Coopt_GMAD('toy_GMAD');
# demo_GMAF
solution2=run_Coopt_GMAF('toy_GMAF');
# demo_QAP
solution3=run_Coopt_QAP('toy_QAP');
# experiment on synthetic graphs matching of GMAD
exp_GMAD
# experiment on Chinese characters matching of GMAF
exp_GMAF
# experiment on QAPlib  datasets of QAP
exp_QAP
```
## Reference
[1] Z.-Y. Liu, H.~Qiao, Gnccpâ€”graduated nonconvexityand concavity procedure,
  Pattern Analysis and Machine Intelligence, IEEE Transactions on 36~(6) (2014)
  1258--1267.
  
[2] M.~Zaslavskiy, F.~Bach, J.-P. Vert, A path following algorithm for graph
  matching, in: Image and Signal Processing, Springer, 2008, pp. 329--337.
  
[3]Z.-Y. Liu, H.~Qiao, L.~Xu, An extended path following algorithm for
  graph-matching problem, Pattern Analysis and Machine Intelligence, IEEE
  Transactions on 34~(7) (2012) 1451--1456.
  
[4] X.~Yang, H.~Qiao, Z.~Liu, Outlier robust point correspondence based on {GNCCP},
  Pattern Recognition Letters 55~(0) (2015) 8--14.
  
[5] Z.~Liu, H.~Qiao, A convex-concave relaxation procedure based subgraph matching
  algorithm., in: ACML, 2012, pp. 237--252.
  
[6] R.~E. Burkard, S.~E. Karisch, F.~Rendl, Qaplib--a quadratic assignment problem
  library, Journal of Global optimization 10~(4) (1997) 391--403.
```
