# nvim-hs-config-example
Example config reflecting the state of nvim-hs.

# Testing the functions

1) Make sure that it compiles.
2) Put

   > let g:haskellChan = rpcstart("/path/to/nvim-hs", [])

   inside your neovim configuration

3) Call the functions like so:

   > :let i = rpcrequest(g:haskellChan, "Random")

4) Inspect the value with

   > :echo i


