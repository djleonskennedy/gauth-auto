module Time (getTime) where

import HuskPrelude
import Data.Time.Clock.POSIX as PT

getTime :: IO Int
getTime = fmap (round . flip (/) 30) PT.getPOSIXTime
