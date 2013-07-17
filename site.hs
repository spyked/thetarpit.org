{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll

main :: IO ()
main = hakyll $ do
  match "index.html" compileIndex
  match "css/*" compileCss
  match "posts/*" compilePosts
  match "templates/*" $ compile templateCompiler

compileIndex :: Rules ()
compileIndex = do
    route idRoute -- TODO: make a "copy to root" route?
    compile $ do
      let indexCtx = defaultContext

      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
        >>= relativizeUrls

compileCss :: Rules ()
compileCss = do
  route idRoute
  compile compressCssCompiler

compilePosts :: Rules ()
compilePosts = do
  route $ setExtension "html"
  compile $ pandocCompiler
    >>= loadAndApplyTemplate "templates/default.html" postCtx
    >>= relativizeUrls

postCtx :: Context String
postCtx = dateField "date" "$B %e, %Y" `mappend` defaultContext
