module Time (getTime) where

import HuskPrelude

getTime :: IO Int
--getTime = fmap (round . flip (/) 30) PT.getPOSIXTime
getTime = return 51631600
