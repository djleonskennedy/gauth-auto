import Test.Hspec
import Time (toHex)

main :: IO ()
main = do
  hspec spec

spec :: Spec
spec = do
  describe "time" $ do
    it "toHex" $ do
      (toHex 11) `shouldBe` "b"
