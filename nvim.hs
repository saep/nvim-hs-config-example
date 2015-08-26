import Neovim

main :: IO ()
main = neovim defaultConfig
    { plugins = plugins defaultConfig ++ []
    }
