import Utils (leftpad)

main :: IO ()
main = do 
    let one = leftpad 14 5 "0"
        two = leftpad 11 5 "0"
        tree = leftpad 4 5 "0"
        for = leftpad 1 5 "0"
    putStrLn one >> putStrLn two >> putStrLn tree >> putStrLn for
