{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Hakyll
import Hakyll.Core.Configuration

-- wrapping it up
main :: IO ()
main = hakyll $ do
  -- tags
  tags <- buildTags "posts/*" $ fromCapture "tags/*.html"

  -- content
  match "index.html" compileIndex
  match "css/*" compileCss
  match "posts/*" $ compilePosts tags
  match (fromList ["about.markdown", "404.markdown"]) compilePages
  create ["archive.html"] compileArchive

  -- tags rules
  tagsRules tags $ compileTags tags

  -- rss feed
  create ["rss.xml"] compileRss

  -- compile templates
  match "templates/*" $ compile templateCompiler

-- compilers go here
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

compilePosts :: Tags -> Rules ()
compilePosts tags = do
  route $ setExtension "html"
  let ctx = tagsCtx tags
  compile $ pandocCompiler
    >>= saveSnapshot "content"
    >>= loadAndApplyTemplate "templates/post.html" ctx
    >>= loadAndApplyTemplate "templates/default.html" ctx
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

compileTags :: Tags -> String -> Pattern -> Rules ()
compileTags tags tag pattern = do
  let title = "Posts tagged '" ++ tag ++ "'"
  route idRoute
  compile $ do
    posts <- loadAll pattern >>= recentFirst
    let tagCtx =
          constField "title" title                 `mappend`
          listField "posts" postCtx (return posts) `mappend`
          tagsCtx tags
    makeItem ""
      >>= loadAndApplyTemplate "templates/post-list.html" tagCtx
      >>= loadAndApplyTemplate "templates/default.html" tagCtx
      >>= relativizeUrls


compileRss :: Rules ()
compileRss = do
  -- shamelessly stolen from
  -- http://jaspervdj.be/hakyll/tutorials/05-snapshots-feeds.html
  route idRoute
  compile $ do
    let feedCtx =
          postCtx                         `mappend`
          teaserField "teaser" "content"  `mappend`
          bodyField "description"
        applyTeaser = loadAndApplyTemplate "templates/teaser.html" feedCtx
    posts <- loadAllSnapshots "posts/*" "content"
      >>= mapM applyTeaser
      >>= fmap (take 7) . recentFirst
    renderRss tarpitFeed feedCtx posts

-- post context
postCtx :: Context String
postCtx = dateField "date" "%B %e, %Y" `mappend` defaultContext

tagsCtx :: Tags -> Context String
tagsCtx tags = tagsField "tags" tags `mappend` postCtx

-- hakyll configuration
tarpitConfiguration :: Configuration
tarpitConfiguration = defaultConfiguration
  { deployCommand = commStr }
  where
  commStr = "rsync -avz -e 'ssh -p 2200'"
         ++ "_site mogosanu.ro:/virtual/sites/thetarpit.org"

-- support for RSS feeds
tarpitFeed :: FeedConfiguration
tarpitFeed = FeedConfiguration
  { feedTitle       = "The Tar Pit"
  , feedDescription = "tarpit :: IO ()"
  , feedAuthorName  = "Lucian Mogoșanu"
  , feedAuthorEmail = ""
  , feedRoot        = "http://thetarpit.org"
  }
