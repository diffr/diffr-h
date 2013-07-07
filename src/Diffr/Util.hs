{-# LANGUAGE DeriveDataTypeable #-}
{- |
 Module      :  Diffr.Util
 Description :  Utility functions and configuration options
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
module Diffr.Util (
      DConfig(..)
    , diffrModes
) where

import           System.Console.CmdArgs

{-| Static values -}
_PROGRAM_NAME, _PROGRAM_VERSION,
 _PROGRAM_INFO, _PROGRAM_ABOUT, _COPYRIGHT :: String
_PROGRAM_NAME = "diffr"
_PROGRAM_VERSION = "0.1"
_PROGRAM_INFO = _PROGRAM_NAME ++ " version " ++ _PROGRAM_VERSION
_PROGRAM_ABOUT = unwords [
      "An intelligent diff/patch tool"
    , "that knows how to copy and move,"
    , "has an 'r' at the end of its name"
    , "and is written in Haskell."]
_COPYRIGHT = "(C) diffr 2013"

------------------------------------------------

{-| Configuration for running diffr's commands -}
data DConfig =

    -- | Configuration for running diff command
    Diff  { -- | Path to the 'base' file we will diff against
            baseFile     :: FilePath

            -- | Path to the 'new' file we will compare to 'base' file
          , newFile    :: FilePath

            -- | Path to the output file where to write the diff file
          , dOutFile    :: Maybe FilePath
          }

    -- | Configuration for running patch command
  | Patch { -- | Path to the 'original' file we will apply patch to
            originalFile :: FilePath

            -- | Path to the 'patch' file we will apply to 'originalFile'
          , patchFile  :: FilePath

            -- | Path to the output file where to write the patched file
          , pOutFile    :: Maybe FilePath
          } deriving (Eq, Show, Data, Typeable)

{-| Annotate the 'Diff' configuration -}
diff :: DConfig
diff = Diff
    { baseFile  = def &= argPos 0
                      &= typ "BASEFILE"
    , newFile   = def &= argPos 1
                      &= typ "NEWFILE"
    , dOutFile  = def &= help "path to the output file"
                      &= name "output-file" &= typFile
    }

{-| Annotate the 'Patch' configuration -}
patch :: DConfig
patch = Patch
    { originalFile  = def &= argPos 0
                          &= typ "ORIGINALFILE"
    , patchFile     = def &= argPos 1
                          &= typ "PATCHFILE"
    , pOutFile      = def &= help "Path to the output file where to write the patched file"
                          &= name "output-file"
                          &= typFile
    }

{-| Available commands -}
diffrModes :: Mode (CmdArgs DConfig)
diffrModes = cmdArgsMode $ modes [diff, patch]
    &= versionArg [explicit, name "version", name "v", summary _PROGRAM_INFO]
    &= summary (_PROGRAM_INFO ++ ", " ++ _COPYRIGHT)
    &= help _PROGRAM_ABOUT
    &= helpArg [explicit, name "help", name "h"]
    &= program _PROGRAM_NAME

