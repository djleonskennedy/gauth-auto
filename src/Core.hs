module Core
  ( app
  ) where

import File (Config, errorFileLoad, getConfig)
import KeyManager (generate)
import Encdec.Encoded
import HuskPrelude
import Time (getTime)
import Encdec.Encoder as Encoder
import Encdec.Encoding

app :: IO ()
app
 = do
  let b32 = Encoded "EEEEAFFF44NNN5524QQQQUQMAUCI2222"
  msg <- fmap Encoder.encode getTime :: IO (Encoded Hex)
  key <- generate msg b32
  print key
