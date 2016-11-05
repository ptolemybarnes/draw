# Draw

#### Running Draw
```
$ bundle
$ ruby run.rb
```

#### Commands

1. Draw a canvas, giving x and y dimensions:
```
enter command: C 20 4

______________________
|                    |
|                    |
|                    |
|                    |
----------------------
```

2. Draw a line, giving xy coordinates of start and finish
```
enter command: L 1 2 6 2

______________________
|                    |
|xxxxxx              |
|                    |
|                    |
----------------------
```

3. Draw a rectangle, giving xy coordinates of top-left and bottom-right.
```
enter command: R 16 1 20 3

______________________
|               xxxxx|
|xxxxxx         x   x|
|               xxxxx|
|                    |
----------------------
```

4. Fill with a given 'colour' from an xy coordinate.
```
enter command: B 10 3 o

______________________
|oooooooooooooooxxxxx|
|xxxxxxooooooooox   x|
|oooooooooooooooxxxxx|
|oooooooooooooooooooo|
----------------------
```

5. Quit.
```
enter command: Q
```

#### Tests
`$ rspec`

#### Design
###### Modelling the grid
At the outset I chose to model the grid as a 2D array. This worked well until I wanted to implement the fill tool, which seemed to require a more graph-like data structure where each node is able to query the nodes around it. I briefly experimented with such a data structure but ultimately decided against it. Unfortunately this meant that the `Fill` shape needs to have access to the canvas to ensure it doesn't modify already-filled points.
###### CLI
I wanted to entirely decouple the Draw program from the means by which the user would enter input. I have done this using a CLI class that parses commands and arguments and calls the Draw program. I read a book recently called 'Understanding Computation' by Tom Stuart and it seemed to me that there were some analogies between this problem and the processes of tokenization and parsing that he describes. However this part is incomplete and the CLI doesn't do any argument-checking.
