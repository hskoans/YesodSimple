{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import Prelude
import Yesod
import Data.Text (Text)

data App = App

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

instance Yesod App

getHomeR :: Handler Value 
getHomeR = returnJson $ object [ "msg" .= msg ]
    where msg = "Hello, World" :: Text

main :: IO()
main = warp 3000 App
