{- |
 Module      :  Diffr.Util.ArgumentsProcessor
 Description :  Arguments processor for diffr.
 Since       :  0.2
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

module Diffr.Util.ArgumentsProcessor ( containsHelpArgument, extractOutputFile ) where

import Data.Char ( toLower )

-- | 'containsHelpArgument' checks if the given list of strings contains the help argument.
containsHelpArgument :: [[Char]] -> Bool
containsHelpArgument args = any isHelpArgument ( map ( map toLower ) args )

-- | 'extractOutputFile' extracts the output file argument from a list of strings.
extractOutputFile :: [[Char]] -> [Char]
extractOutputFile args = case args of
    [] -> ""
    ("-o":[]) -> ""
    ("-o":xs) -> head ( xs )
    _ -> extractOutputFile ( tail args )

-- | 'isHelpArgument' checks if a string is a help argument.
isHelpArgument :: [Char] -> Bool
isHelpArgument arg = case arg of
    [] -> False
    ('-':[]) -> False
    ('-':xs) -> isHelpArgument( xs )
    "help" -> True
    _ -> False
