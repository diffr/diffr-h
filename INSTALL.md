Installation Instructions
=========================

This program is written in Haskell and built using (cabal)[http://www.haskell.org/cabal/].  

It is suggested that (cabal-dev)[http://hackage.haskell.org/package/cabal-dev] be used as
it provides a sandboxed, per-project dependency management, which leads to less issues with
conflicting library versions. 

To build, you will need:
* haskell-platform
* cabal (or cabal-dev)

If you're on a mac, check out (homebrew)[http://mxcl.github.io/homebrew/].

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
2. Run "cabal configure --enable-tests".
3. Run "cabal build" to compile the sources to dist/.
4. Run "cabal test" to run the tests.

#### Running

* Run "./diffr" to run the program from within the build directory, or if installed, just run "diffr".
* Run "./patchr" to run the program from within the build directory, or if installed, just run "patchr".

#### Documentation

* Run "cabal configure".
* Run "cabal haddock --executables" to generate documentation.

