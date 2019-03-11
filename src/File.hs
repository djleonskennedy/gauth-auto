{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module File (
  Config,
  getConfig,
  errorFileLoad,
  secret,
  writeConfig,
  getEmpty
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
  , host :: String
} deriving (Generic, Show, Eq)

instance FromJSON Config

getEmpty :: Config
getEmpty = Config {login="", password="", secret="", host=""}

getJSON :: FilePath -> IO B.ByteString
getJSON = B.readFile

getConfig :: FilePath -> IO (Either String Config)
getConfig f = do
  content <- getJSON f
  return $ eitherDecode content

errorFileLoad :: String -> IO ()
errorFileLoad s = print $ "Opp's cannot get file, cause: " <> s

writeConfig :: FilePath -> Config -> String -> IO String
writeConfig fp cfg key = do
  let result = concatAll cfg key
  HuskPrelude.writeFile fp $ concatAll cfg key
  return result

concatAll :: Config -> String -> String
concatAll c key = host c <> ['\n'] <> login c <> ['\n'] <> key <> ['\n'] <> password c