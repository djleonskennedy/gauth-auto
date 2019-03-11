module Arguments (parse, extractConfigPath, extractTargetPath, flagToString, Flag(..)) where

import Control.Monad
import Data.Char
import Data.List
import System.Console.GetOpt
import System.Environment
import System.Exit
import System.IO
import Text.Printf
import HuskPrelude (Eq, Ord, Enum, Show, Bounded)
import HuskPrelude as H

data Flag
  = Config String
  | Target String
  | Help
  deriving (Show, Eq)

options :: [OptDescr Flag]
options =
  [ Option ['c'] ["config"]       (ReqArg Config "config FILE") "-c config file path"
  , Option ['t'] ["target"]       (ReqArg Target "target FILE") "-t target file (txt file that cisco client is using)"
  , Option ['h'] ["help"]         (NoArg Help)                  "help"
  ]

parse :: [String] -> IO ([Flag], [String])
parse argv = -- case getOpt Permute options argv of
  case getOpt Permute options argv of
         (o, n, []) -> return (o, n)
         (_,_, errs) -> ioError (userError (concat errs ++ usageInfo header options))
     where header = "Usage: hauth -c [file path ...] -t [file path...]"

extractConfigPath :: Flag -> Bool
extractConfigPath flags =
  case flags of 
    Config s -> True
    _ -> False

extractTargetPath :: Flag -> Bool
extractTargetPath flags =
  case flags of 
    Target s -> True
    _ -> False

flagToString :: Flag -> String
flagToString flags =
  case flags of 
    Config s -> s
    Target s -> s
    _ -> ""
