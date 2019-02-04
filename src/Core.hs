{-# LANGUAGE OverloadedStrings #-}

module Core
    ( app
    ) where

import File (getConfig, errorFileLoad, Config)
import Data.ByteString.Char8 as BChar8
import Data.Hex
import Data.ByteArray
import Time (hexTime)

app :: IO ()
app = do
  -- let key = base32ToHex "E2TSAVIDCG2N4FF52GZ6VUQMAUCIBTQN"
  -- let key = "26a720550311b4de14bdd1b3ead20c050480ce0d" :: String
  -- let msg = "000000000313d5f0" :: String
  -- let msg = "51631600" :: ByteString
  -- let h = hmac key msg :: HMAC SHA1

  -- Prelude.putStrLn $ ("epoch: " ++ show time)
  -- Prelude.putStrLn $ show $ hmacGetDigest h
  time <- hexTime
  Prelude.putStrLn $ show time

  -- time <- Time.getUnixTime
  -- Prelude.putStrLn $ show $ Time.toEpochTime time
  cfg <- getConfig
  either errorFileLoad print cfg
  -- BChar8.putStrLn key
