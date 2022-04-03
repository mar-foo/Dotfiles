{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

import Data.Bits ((.|.))
import qualified Data.Map as M
import Graphics.X11.Xlib
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Run

myLayouts =
  spacing $
  gap $ Tall nmaster delta ratio ||| ThreeColMid nmaster delta ratio ||| Full
  where
    gap = avoidStruts
    spacing = spacingRaw False (Border 5 5 5 5) True (Border 5 5 5 5) True
    nmaster = 1
    delta = 3 / 100
    ratio = 0.55

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["a", "e", "o", "u"]

myTerminal :: String
myTerminal = "st"

myModMask = mod4Mask

myKeys =
  [ ("M-<Return>", spawn myTerminal) -- %! Launch terminal
  , ("M-r", spawn "dmenu_run") -- %! Launch dmenu
  , ("M-q", kill) -- %! Close the focused window
  , ("M-i", sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
  , ("M-d", sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area
  , ( "M-S-r"
    , spawn
        "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi" -- %! Restart xmonad
     )
  , ("M-w", spawn "surf-open.sh")
  , ("M-s", spawn "em-daemon")
  , ("M-<Space>", windows W.swapMaster)
  , ("M-f", sendMessage NextLayout)
  , ("M--", spawn "amixer sset Master 5%-")
  , ("M-S--", spawn "amixer sset Master 5%+")
  ] ++
  [ (m ++ "M-" ++ [k], windows $ f i)
  | (i, k) <- zip myWorkspaces "aeou"
  , (f, m) <- [(W.view, ""), (W.shift, "S-")]
  ]

myManageHook =
  composeAll
    [ className =? "Navigator" --> doShift "o"
    , className =? "mpv" --> doShift "u"
    ]

myFocusedBorderColor = "#4499BB"

main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
  xmonad . ewmhFullscreen . ewmh . xmobarProp . docks $
    def
      { modMask = myModMask
      , layoutHook = myLayouts
      , workspaces = myWorkspaces
      , terminal = myTerminal
      , logHook =
          dynamicLogWithPP $
          xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppCurrent = xmobarColor "#4499BB" "#222222"
            , ppTitle = xmobarColor "#4499BB" "#222222" . shorten 100
            }
      , manageHook = myManageHook
      , focusedBorderColor = myFocusedBorderColor
      } `additionalKeysP`
    myKeys
