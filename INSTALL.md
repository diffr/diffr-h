Installation Instructions
=========================
This program is written in Haskell and built using cabal.  
To build, you will need:
* haskell-platform

#### Building

For best results:
1. Run "cabal clean".  
2. Run "cabal configure".  
3. Run "cabal build" to compile the sources to dist/.  

#### Installation

Optionally:
* Run "cabal install --prefix=/usr/local/" to install the program.

#### Testing

1. Run "cabal clean".
2. Run "cabal configure".
3. Run "cabal build" to compile the sources to dist/.
4. Run "cabal test" to run the tests.

#### Running

* Run "./diffr" to run the program from within the build directory, or if installed, just run "diffr".
* Run "./patchr" to run the program from within the build directory, or if installed, just run "patchr".

#### Documentation

* Run "cabal configure".
* Run "cabal haddock --executables" to generate documentation.

