{-# LANGUAGE OverloadedStrings #-}

module Utils
  ( dev2hex 
  , hex2dev
  , base32ToHex
  ) where

import Data.List
import Data.Maybe
import Numeric (showHex, showIntAtBase, readHex)
import Data.Char (intToDigit)
import Data.Char as C

type Radix = Int
type Base32 = String

base32chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567" :: String

{-
  var base32tohex = function (base32) {
        var base32chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
        var bits = "";
        var hex = "";

        for (var i = 0; i < base32.length; i++) {
            var val = base32chars.indexOf(base32.charAt(i).toUpperCase());
            bits += leftpad(val.toString(2), 5, '0');
        }

        for (i = 0; i + 4 <= bits.length; i += 4) {
            var chunk = bits.substr(i, 4);
            hex = hex + parseInt(chunk, 2).toString(16);
        }

        return hex;
    };

    var leftpad = function (str, len, pad) {
        if (len + 1 >= str.length) {
            str = new Array(len + 1 - str.length).join(pad) + str;
        }
        return str;
    };

-}

findChar :: Char -> Bool
findChar c = C.toUpper c `elem` base32chars

-- appendChar = (\acc c ->   
--   let mayBeItem = find findChar y
--   in 
--     case mayBeItem of
--         Just n -> acc ++ [n]
--         Nothing -> acc
--         )

base32ToHex :: Base32 -> String
base32ToHex base32 = 
    foldl (\x y ->
        let mayBeItem = find findChar [y]
        in 
            case mayBeItem of
                Just char ->
                  let binary = leftpad (toBinary 2 char) 5 "0"
                  in  x ++ [binary]
                Nothing -> x
                ) "" base32

-- decimal to HEX
dev2hex :: RealFrac a => a -> String
dev2hex n = 
  let hex = if n < 15.5 then "0" else ""
      rounded = round n
      r = toBinary 16 rounded
  in hex ++ r

  -- HEX to decimal value
hex2dev :: String -> Int
hex2dev = fst . last . readHex

-- convert to some radix
toBinary :: Radix -> String -> String
toBinary r n = showIntAtBase r intToDigit n ""

-- join array of strings to string
join :: [String] -> String
join = foldr (\a b-> a ++ b) ""

-- add zero's to hex if it's empty
leftpad :: String -> Int -> String -> String
leftpad str l pad = if l >= length str 
                    then 
                      let
                        items = l - (length str) 
                        replicated = replicate items pad
                        resultString = join replicated
                      in
                        resultString ++ str
                      else str

