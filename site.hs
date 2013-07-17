{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll

main :: IO ()
main = hakyll $ do
  match "index.html" $ do
    route idRoute -- TODO: make a "copy to root" route?
    compile $ do
      let indexCtx = defaultContext

      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
        >>= relativizeUrls

  match "templates/*" $ compile templateCompiler
