TraversalSplitter
=================

This is a haxe implementation of an algorithm that partitions orthogonal polygons into several small rectangular areas.
A more detailed description about the algorithm can be found on my [blog](http://scrambledrk.blogspot.co.at/2014/07/polygon-partitioning.html).

![AlgorithmRundown](http://1.bp.blogspot.com/-p1GqJiiXK4g/U7P62VbzwcI/AAAAAAAAAKc/skfpaNK0HFY/s1600/algorithm.png)

1. traverse the polygon clockwise and find vertices with counterclockwise rotation
2. split the graph from those vertices to any direction
3. pick a vertex and traverse the adjusted graph clockwise to build your rectangle
---
runtime:
* multiple platform targets supported
* simple input / output interface

development time:
* confusing line detection algorithm
* monster class
