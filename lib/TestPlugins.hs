module TestPlugins
    where

import Neovim
import System.Random

-- Plugins for testing the nvim-hs plugin provider

return42 :: Neovim r st Int
return42 = return 42

add1 :: Int -> Neovim r st Int
add1 i = return $ i+1

nextRand :: Neovim () StdGen Int16
nextRand = do
    (r,g) <- random <$> get
    put g
    return r
