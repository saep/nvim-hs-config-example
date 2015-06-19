# nvim-hs-config-example
Example config reflecting the state of [nvim-hs](https://github.com/saep/nvim-hs).

# Testing the functions

1. Clone the configuration to the XDG_CONFIG_DIR directory.
> git clone git@github.com:saep/nvim-hs-config-example.git ~/.config/nvim

2. Make sure that it compiles.

3. Put

   ```vimL
   if has("nvim")
     " Define an arbitrary name for the provider
     let s:nvimhsName
     " Create a factory function to intialize 
     " an nvim-hs provider
     function! s:RequireHaskellHost(name)
       " Or replace with fully qualified path 
       " if the nvim-hs exectuable is not on your path
       return rpcstart("nvim-hs", ['-n',a:name])
     endfunction

     " Register the factory function
     call remote#host#Register(s:nvimhsName, function('s:RequireHaskellHost'))
     " Force initialization by calling the 'Ping' function.
     " This may be required if you happen to call functions
     " before they are regisitered with neovim. This has something to do with
     " the asynchronous nature of starting the plugin provider and cannot
     " really be mitgated well otherwise.
     call rpcrequest(remote#host#Require(s:nvimhsName), 'Ping')
   endif
   ```

   inside your neovim configuration.

4. You chould now be able to call functions and commands. Some functionality 
   may not work yet (especially with regard to defining commands). Please open
   issue requests for those!


