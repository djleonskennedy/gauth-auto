import Test.Hspec

main :: IO ()
main = do
  hspec spec

spec :: Spec
spec = do
  describe "time" $ do
    it "conform RFC examples" $ do
      Decoder.decode (Encoded "" :: Encoded 'Base32) `shouldBe` Right ""
      Decoder.decode (Encoded "MY======" :: Encoded 'Base32) `shouldBe`
        Right "f"
      Decoder.decode (Encoded "MZXQ====" :: Encoded 'Base32) `shouldBe`
        Right "fo"
      Decoder.decode (Encoded "66" :: Encoded 'Hex) `shouldBe` Right "f"