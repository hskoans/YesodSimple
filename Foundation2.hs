{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Foundation2 where

import Prelude
import Yesod
import Data.Text (Text)
import Control.Concurrent.STM

data App = App (TVar [Text])    -- Using Text to store our filenames at application state level
                                -- Use TVar to mark our Text list as a transactional variable
instance Yesod App

mkYesodData "App" $(parseRoutesFile "config/routes2")

getList :: Handler [Text]
getList = do
    App tstate <- getYesod
    liftIO $ readTVarIO tstate

addFile :: App -> Text -> Handler ()
addFile (App tstore) op =
    liftIO . atomically $ do
        modifyTVar tstore $ \ ops -> op : ops
