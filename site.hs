{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll

main :: IO ()
main = hakyll $ do
  match "index.html" compileIndex
  match "css/*" compileCss
  match "posts/*" compilePosts
  match (fromList ["about.markdown"]) compilePages
  create ["archive.html"] compileArchive
  match "templates/*" $ compile templateCompiler

compileIndex :: Rules ()
compileIndex = do
    route idRoute -- TODO: make a "copy to root" route?
    compile $ do
      posts <- loadAll "posts/*" >>= fmap (take 5) . recentFirst
      let indexCtx =
            listField "posts" postCtx (return posts) `mappend`
            defaultContext

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

compilePages :: Rules ()
compilePages = do
  route $ setExtension "html"
  compile $ pandocCompiler
    >>= loadAndApplyTemplate "templates/default.html" defaultContext
    >>= relativizeUrls

compileArchive :: Rules ()
compileArchive = do
  route idRoute
  compile $ do
    posts <- loadAll "posts/*" >>= recentFirst
    let archiveCtx =
          listField "posts" postCtx (return posts) `mappend`
          constField "title" "Archive"             `mappend`
          defaultContext
    makeItem ""
      >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
      >>= loadAndApplyTemplate "templates/default.html" archiveCtx
      >>= relativizeUrls

postCtx :: Context String
postCtx = dateField "date" "%B %e, %Y" `mappend` defaultContext
