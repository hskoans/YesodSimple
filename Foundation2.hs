{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Foundation2 where

import Prelude
import Yesod
import Control.Concurrent.STM
import Data.ByteString.Lazy (ByteString)
import Data.Text (Text)
import qualified Data.Text as Text

data App = App (TVar [(Text, ByteString)])      -- Using Text to store our filenames at application state level
                                                -- Use TVar to mark our Text list as a transactional variable
instance Yesod App

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

mkYesodData "App" $(parseRoutesFile "config/routes2")

getList :: Handler [Text]
getList = do
    App tstate <- getYesod
    state <- liftIO $ readTVarIO tstate
    return $ map fst state

addFile :: App -> (Text, ByteString) -> Handler ()
addFile (App tstore) op =
    liftIO . atomically $ do
        modifyTVar tstore $ \ ops -> op : ops

getById :: Text -> Handler ByteString
getById ident = do
    App tstore <- getYesod
    operations <- liftIO $ readTVarIO tstore
    case lookup ident operations of
        Nothing -> notFound
        Just bytes -> return bytes
