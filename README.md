# nvim-hs-config-example
Example config reflecting the state of [nvim-hs](https://github.com/saep/nvim-hs).

# Testing the functions

1. Clone the configuration to the XDG_CONFIG_DIR directory.
> git clone git@github.com:saep/nvim-hs-config-example.git ~/.config/nvim

2. Make sure that the configuration compiles.
  
   Note that a builtin plugin is in development that will help you with this. But
   until that works properly, you have to be able to debug it by hand. To initiate
   recompilation, you can simply call `nvim-hs --help`. If `~/.cache/nvim/errors.log`
   is empty, it has successfully compiled. Otherwise, there is the ghc compilation
   error log inside that file.

3. Put

   ```vimL
   if has("nvim")
     call remote#host#Register('nvimhs', "*.l\?hs", rpcstart('nvim-hs', ['nvimhs']))
     " Force initialization by calling the 'PingNvimhs' function.
     " This may be required if you happen to call functions
     " before they are regisitered with neovim. This has something to do with
     " the asynchronous nature of starting the plugin provider and cannot
     " really be mitgated currently.
     call rpcrequest(remote#host#Require('nvimhs'), 'PingNvimhs')
   endif
   ```

   inside your neovim configuration.

4. You chould now be able to call functions and commands. Some functionality 
   may not work yet (especially with regard to defining commands). Please open
   issue requests for those!


