{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Home2 where

import Prelude
import Data.Default
import Yesod
import Yesod.Default.Util

import Foundation2

getHomeR :: Handler Html
getHomeR = do
    let filenames = ["hello.txt", "whatever.png", "hooray.jpg"] :: [String]
    defaultLayout $ do
        setTitle "File Processor"
        $(widgetFileNoReload def "home2")
