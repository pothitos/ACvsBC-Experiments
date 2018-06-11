# Arc Consistency vs. Bounds Consistency Sources [![Build Status](https://travis-ci.org/pothitos/ACvsBC-Experiments.svg?branch=master)](https://travis-ci.org/pothitos/ACvsBC-Experiments)

:warning: This repository contains the _source code_ that
supports the corresponding
[article](https://github.com/pothitos/ACvsBC).

## Mission Statement

We are trying to track the cases when _bounds consistency_
(BC) is more efficient than _arc consistency_ (AC) in
Constraint Programming.

## Intuition

Let _n_ be the number of the constraint variables and _d_
the cardinality of their maximum domain, in a _constraint
satisfaction problem_ (CSP).There seems to be a threshold of
the ratio _d_/_n_: after this theshold, maintaining _bounds
consistency_ is more efficient than maintaining _arc
consistency_.
