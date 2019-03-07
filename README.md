# Arc Consistency vs. Bounds Consistency Patches [![Build Status](https://travis-ci.org/pothitos/ACvsBC-Solver-Patches.svg?branch=master)](https://travis-ci.org/pothitos/ACvsBC-Solver-Patches)

:warning: This repository contains the _source code_ that
supports the corresponding
[article](https://github.com/pothitos/ACvsBC).

> In order to make comparisons, we had to employ two
> different solvers: one that maintains arc consistency
> (AC) and another that maintains bounds consistency (BC).
> Therefore, we took the open source [Naxos
> Solver](https://github.com/pothitos/naxos) and
> created its AC and BC variants.
> 
> Note that the original Naxos Solver implements several
> consistency levels for various constraints. Consequently,
> we created two sets of patches, one that implements pure
> arc consistency and another for pure bounds consistency
> for every constraint employed.
> 
> Similarly to the theory of this work, we considered only
> binary constraints (that apply between two constrained
> variables) to simplify consistency enforcement. Therefore,
> we binarized the global constraints (that apply to more
> than two variables) that exist in some CSP instances by
> substituting them by groups of equivalent binary
> constraints.
