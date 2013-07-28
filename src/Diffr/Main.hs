{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE NamedFieldPuns     #-}
{-# LANGUAGE RecordWildCards    #-}

{- |
 Module      :  Main
 Description :  Main entry point for Diffr.
 Since       :  0.1
 Authors     :  William Martin, Jakub Kozlowski
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

module Main(main) where

import           Control.Monad
import           Data.Array.IO
import           Data.Array.MArray
import qualified Data.ByteString        as B
import qualified Data.ByteString.Char8  as BChar
import qualified Data.List              as List
import qualified Diffr.Util             as DU
import qualified System.Console.CmdArgs as CM
import           System.Environment     (getArgs, withArgs)
import qualified Diffr.Patch as Patch

main :: IO ()
main = do
    args <- getArgs
    -- If the user did not specify any arguments, pretend as "--help" was given
    opts <- (if null args then withArgs ["--help"] else id) $ CM.cmdArgsRun DU.diffrModes
    case opts of
        DU.Diff {..} -> putStrLn "Hello World"
        (DU.Patch {_originalFile, _patchFile, _pOutFile}) -> patch _originalFile _patchFile _pOutFile

patch :: FilePath -> FilePath -> Maybe FilePath -> IO ()
patch path _ _ = do 
    file <- B.readFile path
    print (Patch.parseDumpFile file)
--patch _ _ _ = do
--   file <- liftM (List.zip [1..] . BChar.lines) $ BChar.readFile "/Users/jakubkozlowski/Programming/Eclipse/diffr-h/kernel33.txt"
--   len <- return (length file)
--   arr <- newArray_ (1,len) :: IO (IOArray Int BChar.ByteString)
--   forM_ file $ (\(i, line) -> do
--        writeArray arr i line)
--   b <- readArray arr 1000
--   print b
