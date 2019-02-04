import Test.Hspec

main :: IO ()
main = do
  hspec spec

spec :: Spec
spec = do
  describe "time" $ do
    it "unix time to hex" $ do
      Decoder.decode (Encoded "" :: Encoded 'Base32) `shouldBe` Right ""
