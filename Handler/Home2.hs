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
    (formWidget, formEncType) <- generateFormPost uploadForm
    filenames <- getList -- getList is able to get the list stored in memory because we make it available at App [Text]
    defaultLayout $ do
        setTitle "File Processor"
        $(widgetFileNoReload def "home2")

postHomeR :: Handler Html
postHomeR = do
    ((result, _), _) <- runFormPost uploadForm
    case result of
        FormSuccess fi -> do
            app <- getYesod
            addFile app $ fileName fi
        _ -> return ()
    redirect HomeR

uploadForm = renderDivs $ fileAFormReq "file"
