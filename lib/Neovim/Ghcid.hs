{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{- |
Module      :  Neovim.Ghcid
Description :  Ghcid plugin
Copyright   :  (c) Sebastian Witte
License     :  Apache-2.0

Maintainer  :  woozletoff@gmail.com
Stability   :  experimental
Portability :  GHC

-}
module Neovim.Ghcid
    where

import Neovim

import Neovim.Ghcid.Plugin
import qualified Data.Map as Map

plugin :: Neovim (StartupConfig NeovimConfig) () NeovimPlugin
plugin = wrapPlugin Plugin
    { exports = []
    , statefulExports =
        [ ((), GhcidState Map.empty,
            [ $(command' 'ghcidStart) ["async", "!"]
            , $(command' 'ghcidStop) ["async"]
            ])
        ]
    }
