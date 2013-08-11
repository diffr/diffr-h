{-# LANGUAGE BangPatterns       #-}
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
import qualified Data.ByteString                  as B
import           Prelude                          hiding (takeWhile)

data Instruction
     = Copy Integer Integer
     | Insert B.ByteString
     deriving (Show)

parsePatch :: B.ByteString -> Maybe [Instruction]
parsePatch bs =
    case AC.feed (AC.parse (AC.many1 line) bs) B.empty of
        Fail {} -> Nothing
        Partial {} -> Nothing
        Done remaining r -> if remaining == B.empty then Just r else Nothing

line :: AC.Parser Instruction
line = (parseCopy <|> parseInsert) <* end

parseCopy :: AC.Parser Instruction
parseCopy = Copy <$> AC.decimal <* "," <*> AC.decimal

parseInsert :: AC.Parser Instruction
parseInsert = Insert <$> (gt *> text)
   where gt = "> "
         text = takeTill (\w -> w == 13 || w == 10)

end :: AC.Parser ()
end =  AC.endOfLine <|> AC.endOfInput
