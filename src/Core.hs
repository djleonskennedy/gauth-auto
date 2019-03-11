module Core
  ( app
  ) where

import File (Config, secret, errorFileLoad, getConfig, writeConfig, getEmpty)
import KeyManager (generate)
import Encdec.Encoded
import HuskPrelude
import Time (getTime)
import Encdec.Encoder as Encoder
import Encdec.Encoding
import Arguments (parse, extractConfigPath, extractTargetPath, flagToString, Flag( Help ))
import System.Environment
import Data.Maybe
import Data.List
import Data.Either
import qualified Data.ByteString.Char8 as BChar8

app :: IO ()
app
 = do
  -- parse argument to specify config and file to save
  (options, _) <- getArgs >>= parse

  -- extracting config option
  config <- getConfig . flagToString . fromMaybe Help $ find extractConfigPath options

  -- log config
  putStrLn $ "Config: " ++ show config

  -- get message from time
  msg <- fmap Encoder.encode getTime :: IO (Encoded Hex)

  --  get base 32 key from config
  let b32 = either (\_ -> Encoded "")  (Encoded . BChar8.pack . secret) config

  -- generate key
  key <- generate msg b32

  -- file path to save target file that will be used with any connect
  let saveFilePath = flagToString . fromMaybe Help $ find extractTargetPath options

  -- write cisco config
  result <- writeConfig saveFilePath (fromRight getEmpty config) key

  -- log it :)
  print $ "Config: OK! ->" <> result
