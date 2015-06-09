module TestPlugins
    where

import Neovim

-- Plugins for testing the nvim-hs plugin provider

return42 :: Neovim r st Int
return42 = return 42

add1 :: Int -> Neovim r st Int
add1 i = return $ i+1
