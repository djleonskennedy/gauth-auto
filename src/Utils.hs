{-# LANGUAGE OverloadedStrings #-}

module Utils (
  base32ToHex,
  getTime
) where

import qualified Codec.Binary.Base32 as Base32
import qualified Data.ByteString as S
import Data.Monoid
import Data.Hex
import Data.Digest.Pure.SHA

-- import Data.Time 
-- import System.Locale 
import Control.Applicative

base32ToHex :: S.ByteString -> S.ByteString
base32ToHex b = case Base32.decode b of
  Right str -> str
  Left (a, b) -> "Error:" <> a <> b

getTime :: IO Int
getTime = return 1548948028 -- (read <$> formatTime defaultTimeLocale "%s" <$> getCurrentTime) :: IO Int