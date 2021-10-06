# RubiksCubeSimulatorNxN
A cube simulator of any dimension. Can animate solver moves (from text file) for random scramble. 
(Propagated to NxN from 3x3)

Each cube has 6 faces and each of them follow the same sequence:
•	Red and Orange along the X axis representing Right (R) and Left (L) respectively
•	White and Yellow along the Y axis representing Up (U) and Down (D) respectively
•	Green and Blue along the Z axis representing Front (F) and Back (B) respectively

The capital letters given in parentheses are representations of clockwise turns along the positive axes. Their small letter counterparts indicate anti-clockwise turns.

To perform a turn more than once add the number as a suffix. For instance, R2 turns the right face clockwise twice, F3 turns the front face clockwise thrice. Similarly, to turn multiple layers at once, add the number of layers as a prefix. 3R2 would turn 3 layers from and including the right face clockwise twice.

The simulator prints the states of the random scramble into a text file ‘RandomScrable.txt’ along with displaying the moves upon pressing of the SPACEBAR.

A second SPACEBAR prompts the simulator to look for the solver output file ‘SolverOutput.txt’ and reads it to perform the solution. In the absence of the file, it performs the reverse of the sates to reset the cube.

An additional feature is pressing the ENTER to read and perform from any input file ‘Input.txt’.
