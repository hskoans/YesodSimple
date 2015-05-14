{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Home2 where

import Prelude
import Data.Default
import Yesod
import Yesod.Default.Util
import Data.Conduit
import Data.Conduit.Binary
import Control.Monad.Trans.Resource (runResourceT)

import Foundation2

getHomeR :: Handler Html
getHomeR = do
    (formWidget, formEncType) <- generateFormPost uploadForm
    storedFiles <- getList -- getList is able to get the list stored in memory because we make it available at App [Text]
    defaultLayout $ do
        setTitle "File Processor"
        $(widgetFileNoReload def "home2")

postHomeR :: Handler Html
postHomeR = do
    ((result, _), _) <- runFormPost uploadForm
    case result of
        FormSuccess fi -> do
            app <- getYesod
            fileBytes <- runResourceT $ fileSource fi $$ sinkLbs
            addFile app $ StoredFile (fileName fi) fileBytes
        _ -> return ()
    redirect HomeR

uploadForm = renderDivs $ fileAFormReq "file"
