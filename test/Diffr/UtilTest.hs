{-# OPTIONS_GHC -F -pgmF htfpp #-}
{- |
 Module      :  UtilTest
 Description :  Tests 'Diffr.Util'.
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
module Diffr.UtilTest where

import qualified Diffr.Util                 as DU
import           Test.Framework
import           Test.Framework.TestManager

-- | Example QuickCheck test
prop_config :: FilePath -> FilePath -> FilePath -> Bool
prop_config base new out =  config == config
    where config = DU.Diff { DU.baseFile = base, DU.newFile = new, DU.dOutFile = Just out}

-- | Test fixture
defaultConfig :: DU.DConfig
defaultConfig = DU.Diff { DU.baseFile = "original.txt", DU.newFile = "original-1.txt", DU.dOutFile = Nothing}

-- | Example assertion test
test_oddSquareSum :: Assertion
test_oddSquareSum = do assertEqual defaultConfig defaultConfig
                       assertEqual True True
