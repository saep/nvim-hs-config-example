import Neovim

import Neovim.Ghcid
import qualified Neovim.Ghcid as Ghcid

main :: IO ()
main = neovim defaultConfig
    { plugins = plugins defaultConfig ++ [ Ghcid.plugin ]
    }
