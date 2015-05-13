{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Foundation2 where

import Prelude
import Yesod
import Data.Text (Text)

data App = App [Text] -- Using Text to store our filenames at application state level
instance Yesod App

mkYesodData "App" $(parseRoutesFile "config/routes2")

getList :: Handler [Text]
getList = do
    App state <- getYesod
    return state
