module Time (hexTime) where

import qualified Data.Time.Clock.POSIX as PT
import Data.Hex (hex)

data HexTime = HexTime String deriving Show

-- get unix time in HEX format
hexTime :: IO HexTime
hexTime = fmap (HexTime . hex . show . round . flip (/) 30) PT.getPOSIXTime
