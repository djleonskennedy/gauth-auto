import Test.Hspec
import KeyManager (generate)
import Encdec.Encoded
import HuskPrelude
import Encdec.Encoding
import Encdec.Encoder
import Encdec.Encoder as Encoder

-- time mock
getTime :: IO Int
getTime = return 51631600

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