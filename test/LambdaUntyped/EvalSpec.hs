module LambdaUntyped.EvalSpec
(
    main,
    spec,
)
where

import Test.Hspec

import LambdaUntyped.Data.Exp
import LambdaUntyped.Eval
import Shared.Data.Env

spec :: Spec
spec = do
  describe "simple eval tests" $ do
    it "Unit" $ do
      let expression = ExpUnit
      let expected = ExpUnit
      eval expression `shouldBe` expected

    it "True" $ do
      let expression = ExpTrue
      let expected = ExpTrue
      eval expression `shouldBe` expected

    it "False" $ do
      let expression = ExpFalse
      let expected = ExpFalse
      eval expression `shouldBe` expected

    it "IfElse True" $ do
      let expression = IfElse ExpTrue ExpUnit (Var "doesnt exist, will blow up if eval-ed")
      let expected = ExpUnit
      eval expression `shouldBe` expected

    it "IfElse False" $ do
      let expression = IfElse ExpFalse (Var "doesnt exist, will blow up if eval-ed") ExpUnit
      let expected = ExpUnit
      eval expression `shouldBe` expected

  describe "lambda tests" $ do
    it "simple lambda" $ do
      let expression = (Abs "x" (Var "x"))
      let expected = (AbsClosure "x" (Var "x") env_new)
      eval expression `shouldBe` expected

    it "simple application" $ do
      let expression = (App (Abs "x" (Var "x")) ExpUnit)
      let expected = ExpUnit
      eval expression `shouldBe` expected

main :: IO ()
main = hspec spec

