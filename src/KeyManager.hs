{-# LANGUAGE DataKinds #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveFunctor #-}

module KeyManager (generate) where

import Crypto.Hash.Algorithms 
import Crypto.MAC.HMAC 
import Data.Word8 (toLower)
import qualified Numeric as Num
import Data.Bits 
import HuskPrelude
import Data.Result
import Data.ByteArray
import Data.ByteString as BS
import Data.ByteString.Char8 as BChar8
import qualified Data.Hex as DataHex
import qualified Data.Time.Clock.POSIX as PT
import Encdec.Decoder as Decoder
import Encdec.Encoder as Encoder
import Encdec.Encoded
import Encdec.Encoding

generate :: Encoded Hex -> Encoded Base32 -> IO String
generate m base32Key = do
  let preparedKey = BS.map (toLower) $ encoded $ base32ToBase16 base32Key
  preparedKeyUnhex <- DataHex.unhex preparedKey
  let preparedMsg = encoded . pad $ m
  preparedMsgUnhex <- DataHex.unhex preparedMsg
  let result = hmac preparedKeyUnhex preparedMsgUnhex :: HMAC SHA1
  let resultStr = show $ hmacGetDigest result
  return $ extractKey . compareBytes . hexToDex . getSubstringFromHmac $ resultStr

-- extract hmac part by (rfc6238 algoritm)
getSubstringFromHmac :: String -> String
getSubstringFromHmac s =
  let 
    offset = HuskPrelude.last s
    offsetNum = fst . HuskPrelude.head . Num.readHex $ (offset : [])
  in 
    HuskPrelude.take 8 . HuskPrelude.drop (offsetNum * 2) $ s

-- hexadecimal notation to unassigned number
hexToDex :: String -> Int
hexToDex = fst . HuskPrelude.head . Num.readHex

-- compare bytes to fill number (rfc6238 algoritm)
compareBytes :: Int -> String
compareBytes s =
  show $ s .&. (2147483647 :: Int)

extractKey :: String -> String
extractKey s =
  HuskPrelude.take 6 . HuskPrelude.drop (HuskPrelude.length s - 6) $ s

pad :: Encoded Hex -> Encoded Hex
pad (Encoded a) = 
  BS.replicate (16 - BS.length a) 48 <> a 
    |> Encoded

asByteString :: ByteString -> ByteString
asByteString a = a

base32ToBase16 :: Encoded Base32 -> Encoded Base16 
base32ToBase16 a = case (Decoder.decode a :: Result ByteString) of
                  Err _ -> Encoder.encode (asByteString "")
                  Ok a -> Encoder.encode a 