{- |
 Module      :  Main
 Description :  Main entry point for diffr.
 Since       :  0.1
 Authors     :  William Martin
 License     :  This file is part of diffr-h.

 diffr-h is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 diffr-h is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 You should have received a copy of the GNU General Public License
 along with diffr-h.  If not, see <http://www.gnu.org/licenses/>.
-}

module Main ( main ) where

import System.Environment( getArgs )
import System.Exit ( exitFailure, exitSuccess )

-- | 'main' runs the main program
main :: IO ()
main = do
    args <- getArgs
    if not ( 2 == length args || 4 == length args )
      then do
        printUsage
        exitFailure
      else do
        print ( length args )
        exitSuccess



-- | 'printUsage' prints the usage information for diffr.
printUsage :: IO ()
printUsage = putStrLn ( "Usage: \n" ++
                   "    diffr <original-file> <new-file>\n" ++
                   "    diffr <original-file> <new-file> -o <output-file>" )
