{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes        #-}
{-# LANGUAGE TemplateHaskell #-}
import           TestPlugins
import           Neovim
import           Neovim.API.IPC
import           Neovim.API.Plugin
import           Neovim.API.TH

import           Data.Int          (Int16)
import           System.Log.Logger
import           System.Random

main :: IO () 
main = neovim def
    { plugins = [ randPlugin ]
    , logOptions = Just ("nvim-log.txt", DEBUG)
    }

randPlugin :: IO SomePlugin
randPlugin = do
    logM "Random" INFO "Starting Rand plugin"
    q <- newTQueueIO
    g <- newStdGen
    return $ SomePlugin Plugin
      { name = "Random number generator"
      , functions = [("Return42" , $(function 'return42))]
      , statefulFunctions = [("Random", q), ("Randoom", q)]
      , services = [ ( (), g, nextRand q ) ]
      }

nextRand :: RandomGen s => TQueue SomeMessage -> Neovim cfg s ()
nextRand q = do
    liftIO $ debugM "Random" "nextRand is running"
    req <- awaitRequest q
    liftIO $ debugM "Random" "nextRand got a request"
    if | reqMethod req == "Random" -> do
         (r,g) <- random <$> get
         let r' = r :: Int16
         put g
         respond (reqId req) (Right (fromIntegral r' :: Int64))
       | otherwise -> error "Unhandled reqMethod"
    nextRand q
