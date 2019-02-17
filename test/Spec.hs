import Test.Hspec
import KeyManager (generate)
import Encdec.Encoded
import HuskPrelude
import Time (getTime)
import Encdec.Encoding
import Encdec.Encoder
import Encdec.Encoder as Encoder

main :: IO ()
main = do
  hspec spec

spec :: Spec
spec = do
  describe "KeyManager" $ do
    it "should generate correct key" $ do
      msg <- fmap Encoder.encode getTime :: IO (Encoded Hex)
      key <- generate msg (Encoded "EEEEAFFF44NNN5524QQQQUQMAUCI2222")
      key `shouldBe` "943132"