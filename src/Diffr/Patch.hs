{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE OverloadedStrings  #-}
{- |
 Module      :  Diffr.Patch
 Description :  Functions for parsing a patch file
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
module Diffr.Patch where

import           Control.Applicative              hiding (many)
import           Data.Attoparsec.ByteString
import qualified Data.Attoparsec.ByteString.Char8 as AC
import           Data.Attoparsec.Combinator
import qualified Data.ByteString                  as B
import           Data.Word                        (Word8)
import Prelude hiding (takeWhile)

data Instruction = Copy Integer Integer | Insert B.ByteString deriving (Show)

parseDumpFile :: B.ByteString -> [Instruction]
parseDumpFile contents =
  case AC.feed (AC.parse (choice [parseCopy, parseInsert]) contents) B.empty of
    --Fail _ _ y -> error y
    Done contents' bla -> bla : parseDumpFile contents'
    Fail {} -> []
    Partial {} -> []
    

parseCopy :: AC.Parser Instruction
parseCopy = Copy <$> (AC.decimal AC.<*. ",")
                 <*> (AC.decimal <* newline)

parseInsert :: AC.Parser Instruction
parseInsert = Insert <$> (gt *> text)
   where gt = AC.string ">"
         text = takeWhile notEOL <* newline
         notEOL w = not (w == 13 || w == 10)

newline :: AC.Parser ()
newline =  return () <$> choice [word8 10, word8 13]

main :: IO ()
main = do
  file <- B.readFile "/Users/jakubkozlowski/Programming/Eclipse/diffr-h/cp.patch"
  print (parseDumpFile file)

