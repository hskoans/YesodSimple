{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Foundation2 where

import Yesod

data App = App
instance Yesod App

mkYesodData "App" $(parseRoutesFile "config/routes2")
