# nvim-hs-config-example
Example config reflecting the state of nvim-hs.

# Testing the functions

1. Clone the configuration to the XDG_CONFIG_DIR directory.
> git clone git@github.com:saep/nvim-hs-config-example.git ~/.config/nvim

2. Make sure that it compiles.

3. Put

   > let g:haskellChan = rpcstart("/path/to/nvim-hs", [])

   inside your neovim configuration.

4. Call the functions like so:

   > :let i = rpcrequest(g:haskellChan, "Random")

5. Inspect the value with:

   > :echo i


