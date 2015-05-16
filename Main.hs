{-# LANGUAGE OverloadedStrings #-}

module Main where

import Prelude
import Yesod

import Control.Concurrent.STM
import Data.IntMap

import Dispatch2 () -- this means that the only thing we want to import from Dispatch2.hs is its Yesod class instance
import Foundation2

main :: IO ()
main = do
    tstore <- atomically $ newTVar empty
    tident <- atomically $ newTVar 0
    warpEnv $ App tident tstore
