{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module File (
  Config,
  getConfig,
  errorFileLoad
) where

import Data.Aeson
import GHC.Generics
import Data.Monoid
import qualified Data.ByteString.Lazy as B
import HuskPrelude

data Config = Config {
    login :: String
  , password :: String
  , secret :: String
  , filepath :: String
  , host :: String
} deriving (Generic, Show, Eq)

instance FromJSON Config

jsonFile :: FilePath
jsonFile = "C:/projects/vpn/config.json"

getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile

getConfig :: IO (Either String Config)
getConfig = do
  content <- getJSON
  return $ eitherDecode content

errorFileLoad :: String -> IO ()
errorFileLoad s = print $ "Opp's cannot get file, cause: " <> s

