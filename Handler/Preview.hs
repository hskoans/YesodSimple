{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Handler.Preview where

import Prelude
import Control.Exception hiding (Handler)
import qualified Data.ByteString.Lazy as LB
import Data.Default
import qualified Data.Text as Text
import qualified Data.Text.Lazy as LT
import qualified Data.Text.Lazy.Encoding as LT
import Text.Blaze
import Yesod
import Yesod.Default.Util

import Foundation2

getPreviewR :: Int -> Handler Html
getPreviewR ident = do
    StoredFile filename bytes <- getById ident
    defaultLayout $ do
        setTitle . toMarkup $ "File Processor - " `Text.append` filename
        previewBlock <- liftIO $ preview bytes
        $(widgetFileNoReload def "preview")

-- only supports txt files for now
preview :: LB.ByteString -> IO Widget
preview bytes = do
    eText <- try . evaluate $ LT.decodeUtf8 bytes :: IO (Either SomeException LT.Text)
    return $ case eText of
        Left _ -> errorMessage
        Right mytext -> [whamlet|<pre>#{mytext}|]
    where
        errorMessage = [whamlet|<pre>Unable to display file contents.|]
