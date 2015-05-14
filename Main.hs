{-# LANGUAGE OverloadedStrings #-}

module Main where

import Prelude
import Yesod

import Control.Concurrent.STM

import Dispatch2 () -- this means that the only thing we want to import from Dispatch2.hs is its Yesod class instance
import Foundation2

main :: IO ()
main = do
    tnextid <- newTVarIO 1
    tstore <- newTVarIO []
    warpEnv $ App tnextid tstore
