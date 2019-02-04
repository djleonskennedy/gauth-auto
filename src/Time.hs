module Time () where

import qualified Data.UnixTime as T
import qualified Data.Hex as Hex

data HexTime = HexTime String

toHexTime :: String -> HexTime
toHexTime s = HexTime s

hexTime :: IO HexTime
hexTime = do 
  time <- T.getUnixTime 
  return $ toHexTime $ Hex.hex . show . T.toEpochTime $ time