{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import Prelude
import Yesod

data App = App
instance Yesod App

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    let filenames = ["hello.txt", "whatever.png"] :: [String]
    setTitle "File Processor"
    toWidget [whamlet|
<h2>Previously submitted files
$if null filenames
    <p>No files have been uploaded yet.
$else
    <ul>
        $forall filename <- filenames
            <li>#{filename}
|]

main :: IO()
main = warpEnv App
