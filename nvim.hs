{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes        #-}
{-# LANGUAGE TemplateHaskell   #-}
import           Neovim
import           Neovim.API.Plugin
import           Neovim.API.TH
import           TestPlugins

import           System.Log.Logger
import           System.Random

main :: IO ()
main = neovim def
    { plugins = [ randPlugin ]
    , logOptions = Just ("~/nvim-log.txt", DEBUG)
    }

randPlugin :: IO SomePlugin
randPlugin = do
    logM "Random" INFO "Starting Rand plugin"
    g <- newStdGen
    return $ SomePlugin Plugin
      { exports =
          [ $(function' 'return42)
          , $(function "succ" 'add1)
          ]
      , statefulExports = [((), g, [$(function' 'nextRand)])]
      }

nextRand :: Neovim cfg StdGen Int16
nextRand = do
    (r,g) <- random <$> get
    put g
    return r
