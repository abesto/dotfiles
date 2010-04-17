-- abesto's XMonad config
-- Time-stamp: <2010-04-17 14:12:05>

import XMonad hiding (Tall)

import XMonad.Util.EZConfig
import XMonad.ManageHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.LayoutHints
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.HintedTile
import XMonad.Layout.NoBorders
import XMonad.Util.Themes

import XMonad.Hooks.SetWMName

import qualified XMonad.StackSet as W

main = xmonad =<< myStatusBar myConfig

myConfig = withUrgencyHook NoUrgencyHook defaultConfig
       { terminal           = "urxvt"
       , workspaces         = map show [1..9] ++ ["mail", "im", "www"]
       , modMask            = mod4Mask
       , borderWidth        = 2
       , normalBorderColor  = "#4F4F4F"
       , focusedBorderColor = "#6F6F6F"
       , focusFollowsMouse  = True
       , manageHook         = myManageHook <+> manageDocks <+> manageHook defaultConfig
       , layoutHook         = myLayout
       , startupHook        = do {setWMName "LG3D"; spawn "/home/abesto/bin/nm"}
       } `additionalKeysP` myKeys

myKeys =
       [ ("M-S-f", browser)
       , ("M-S-<Return>", spawn "xterm")
       , ("M-<Return>", spawn $ XMonad.terminal myConfig)
       , ("M-S-i", im)
       , ("M-S-o", spawn "soffice")
       , ("M-S-e", spawn "emacsclient -c")
       , ("M-p", spawn "gmrun")
       -- MPC
       , ("<XF86AudioPlay>", mpc "toggle")
       , ("M-S-w", mpc "toggle")
       , ("M-S-p", mpcShow "prev")
       , ("<XF86AudioPrev>", mpcShow "prev")
       , ("M-S-n", mpcShow "next")
       , ("<XF86AudioNext>", mpcShow "next")
       , ("M-<KP_Multiply>", mpc "seek +3%")
       , ("M-<XF86AudioRaiseVolume>", mpc "seek +1%")
       , ("M-<KP_Divide>", mpc "seek -3%")
       , ("M-<XF86AudioLowerVolume>", mpc "seek -1%")
       , ("M-S-m", mpcShow "")
       -- Workspaces
       , ("M-w", windows $ W.greedyView "www")
       , ("M-m", windows $ W.greedyView "mail")
       , ("M-i", windows $ W.greedyView "im")
       -- Volume control
       , ("M-<KP_Add>", amixer "Master 5%+")
       , ("<XF86AudioRaiseVolume>", amixer "Master 1%+")
       , ("M-<KP_Subtract>", amixer "Master 5%-")
       , ("<XF86AudioLowerVolume>", amixer "Master 1%-")
       , ("<XF86AudioMute>", amixer "Master toggle")
       ]


terminusMedium = "-xos4-terminus-medium-r-normal-*-12-*-*-*-c-*-iso10646-1"
terminusLarge    = "-xos4-terminus-bold-r-normal-*-32-*-*-*-*-*-iso10646-1"

browser     = spawn "conkeror"
mpc cmd     = spawn $ "mpc -h /mnt/storage/music/.mpd/socket " ++ cmd
mpcShow cmd = mpc $ cmd ++ ("| head -n1 | dzen2 -p 2 -y '400' -h '40' -fn '" ++ terminusLarge ++ "' -bg '#000040' -fg '#8080CC' -e")
amixer cmd  = spawn $ "amixer set " ++ cmd
mutt :: X ()
mutt        = spawn "urxvt -name 'conapp' -e '/home/abesto/bin/mutt'"
im :: X ()
im          = spawn "urxvt -name 'im' -T 'im' -e '/home/abesto/bin/im'"

-- Window rules
myManageHook = makeManageHook W.greedyView <+> makeManageHook W.shift
    where makeManageHook f = composeAll . concat $
                             [ [className =? c --> doFloat | c <- myFloats]
                             , [title     =? t --> doFloat | t <- myFloats]
                             -- Browsers
                             , [className =? c --> doF (f "www") | c <- browsers]
                             , [title     =? t --> doF (f "www") | t <- browsers]
                             -- Im
                             , [className =? c --> doF (f "im") | c <- ims]
                             , [title     =? t --> doF (f "im") | t <- ims]
                             ]
          myFloats = ["Gimp", "gimp", "Xmessage", "Downloads", "*Preferences*", "Save As..."]
          ims = ["Skype", "Pidgin", "im"]
          browsers = ["Iron", "Conkeror", "Opera", "Firefox"]
          myIgnores = []

-- Status bar
myStatusBar = statusBar "xmobar" pp toggleStrutsKey
    where pp = defaultPP { ppCurrent = xmobarColor "#FFD7A7" "" . wrap "[" "]"
                         , ppTitle   = xmobarColor "#80D4AA"  "" . shorten 40
                         , ppVisible = wrap "(" ")"
                         , ppUrgent = xmobarColor "#FFA3A3" "" . xmobarStrip
                         }
          toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Layout
myLayout = avoidStruts $ smartBorders (tabbed shrinkText (theme wfarrTheme) ||| hintedTile Wide  ||| hintedTile Tall)
       where
       hintedTile = HintedTile nmaster delta ratio TopLeft
       nmaster = 1
       ratio = toRational (2/(1+sqrt(5)::Double))
       delta = 3/100
