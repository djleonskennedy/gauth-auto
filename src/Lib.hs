{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( app
    ) where

import Utils (base32ToHex, getTime)
import File (getConfig, errorFileLoad, Config)
import Data.ByteString.Char8 as BChar8
import Data.Hex
import Data.ByteArray
import Crypto.Hash.IO
import Crypto.Hash.Algorithms (SHA1)

-- import qualified Crypto.Hash.SHA1 as SHA1
import Crypto.MAC.HMAC (hmac, hmacGetDigest, HMAC)

app :: IO ()
app = do
  -- let key = base32ToHex "E2TSAVIDCG2N4FF52GZ6VUQMAUCIBTQN"
  -- let key = "26a720550311b4de14bdd1b3ead20c050480ce0d" :: String
  -- let msg = "000000000313d5f0" :: String
  -- let msg = "51631600" :: ByteString
  -- let h = hmac key msg :: HMAC SHA1

  time <- getTime
  -- Prelude.putStrLn $ ("epoch: " ++ show time)
  -- Prelude.putStrLn $ show $ hmacGetDigest h
  cfg <- getConfig
  either errorFileLoad print cfg
  -- BChar8.putStrLn key
