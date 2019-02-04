module Time (hexTime) where

import qualified Data.Time.Clock.POSIX as PT
import Data.Hex (hex)
import qualified Numeric as N

data HexTime = HexTime String deriving Show

-- get unix time in HEX format
hexTime :: IO HexTime
hexTime = fmap (HexTime . toHex . round . flip (/) 30) PT.getPOSIXTime

toHex :: Integral a => a -> String
toHex s = N.showHex (toInteger s) ""
