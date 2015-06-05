module TestPlugins
    where

import Neovim

-- Plugins for testing the nvim-hs plugin provider

return42 :: Neovim' Int
return42 = return 42

