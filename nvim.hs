{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes        #-}
{-# LANGUAGE TemplateHaskell   #-}
import           Neovim
import           TestPlugins

import           System.Log.Logger
import           System.Random

main :: IO ()
main = neovim def
    { plugins = [ randPlugin ]
    , logOptions = Just ("/tmp/nvim-log.txt", DEBUG)
    }

randPlugin :: IO NeovimPlugin
randPlugin = do
    logM "Random" INFO "Starting Rand plugin"
    g <- newStdGen
    wrapPlugin Plugin
      { exports =
          [ $(function' 'return42) Sync
          , $(function "Succ" 'add1) Sync
          ]
      , statefulExports = [((), g, [$(function "NextRand" 'nextRand) def])]
      }
