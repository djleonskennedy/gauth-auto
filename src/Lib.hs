module Lib
    ( app
    ) where

import Utils (dev2hex, hex2dev, base32ToHex)

l :: (Show b) => (a -> b) -> a -> IO ()
l f a = putStrLn (show $ f a)

app :: IO ()
app = do 
  putStrLn "dev2hex ------"
  l dev2hex 12
  l dev2hex 16
  l dev2hex 25
  l dev2hex 89
  putStrLn "hex2dev ------"
  l hex2dev "0c"
  l hex2dev "10"
  l hex2dev "19"
  l hex2dev "59"
  putStrLn ("base32ToHex -------------------")
  l base32ToHex "123456789abc"
  -- l base32ToHex "222"
  -- l base32ToHex "ac5"
  return ()
