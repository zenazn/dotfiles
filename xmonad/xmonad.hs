import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/carl/.xmobarrc"
  xmonad $ defaultConfig
    { terminal = "urxvt"
    , modMask = mod4Mask
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppCurrent = xmobarColor "yellow" ""
      , ppTitle = xmobarColor "white" "" . shorten 80
      }
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , manageHook = manageDocks <+> manageHook defaultConfig
    }
    `additionalKeysP` myKeys

myKeys =
  [ ("M-w", spawn "chromium")
  , ("M-S-w", spawn "chromium --incognito")
  , ("M-p", spawn "dmenu_run")
  ]
