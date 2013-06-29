{-# OPTIONS_GHC -F -pgmF htfpp #-}
module Main where


import Test.Framework

{-| 
 Simply import the test classes,
 in order for them to be run.
-} 
import {-@ HTF_TESTS @-} Diffr.UtilTest

main :: IO()
main = htfMain htf_importedTests
