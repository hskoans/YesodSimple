{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import Prelude
import Yesod
import Data.Default
import Yesod.Default.Util

data App = App
instance Yesod App

mkYesod "App" $(parseRoutesFile "config/routes2")

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    let filenames = ["hello.txt", "whatever.png", "hooray.jpg"] :: [String]
    setTitle "File Processor"
    $(widgetFileNoReload def "home2")

main :: IO()
main = warpEnv App
