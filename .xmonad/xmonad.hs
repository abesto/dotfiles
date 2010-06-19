-- abesto's XMonad config

import Monad

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

myConfig = myUrgencyHook defaultConfig
       { terminal           = "urxvt"
       , workspaces         = map show [1..9] ++ ["mail", "im", "www"]
       , modMask            = mod4Mask
       , borderWidth        = 2
       , normalBorderColor  = "#4F4F4F"
       , focusedBorderColor = "#6F6F6F"
       , focusFollowsMouse  = True
       , manageHook         = manageHook defaultConfig <+> myManageHook
       , layoutHook         = myLayout
       , startupHook        = do {setWMName "LG3D"}
       , logHook            = takeTopFocus
       } `additionalKeysP` myKeys

myKeys =
       [ ("M-S-f", browser)
       , ("M-S-<Return>", spawn "xterm")
       , ("M-<Return>", spawn $ XMonad.terminal myConfig)
       , ("M-S-i", im)
       , ("M-S-o", spawn "soffice")
       , ("M-S-e", spawn "emacsclient -c")
       , ("M-S-v", spawn $ (XMonad.terminal myConfig)++" -e vifm")
       , ("M-p", spawn "gmrun -path /home/abesto/bin")
       , ("M-e", spawn "eaglemode")
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
       , ("M-f", focusUrgent)
       -- Volume control
       , ("M-<KP_Add>", amixer "Master 5%+")
       , ("<XF86AudioRaiseVolume>", amixer "Master 1%+")
       , ("M-<KP_Subtract>", amixer "Master 5%-")
       , ("<XF86AudioLowerVolume>", amixer "Master 1%-")
       , ("<XF86AudioMute>", amixer "Master toggle")
       -- Misc
       , ("M-S-s", spawn "xset dpms force off")
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
myManageHook = composeAll . concat $
                             [ [className =? c --> doFloat | c <- myFloats]
                             , [title     =? t --> doFloat | t <- myFloats]
                             -- Browsers
                             , [className =? c --> doF (W.shift "www") | c <- browsers]
                             , [title     =? t --> doF (W.shift "www") | t <- browsers]
                             -- Im
                             , [className =? c --> doF (W.shift "im") | c <- ims]
                             , [title     =? t --> doF (W.shift "im") | t <- ims]
                             -- Ignores
                             , [resource  =? r --> doIgnore | r <- myIgnores]
                             ]
          where myFloats  = ["Gimp", "gimp", "Xmessage", "Downloads", "*Preferences*", "Save As..."]
                ims       = ["Skype", "Pidgin", "im"]
                browsers  = ["Iron", "Opera", "Firefox"]
                myIgnores = ["XXkb"]

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

-- Fix Java apps focus
-- Send WM_TAKE_FOCUS
takeTopFocus = withWindowSet $ maybe (setFocusX =<< asks theRoot) takeFocusX . W.peek

atom_WM_TAKE_FOCUS      = getAtom "WM_TAKE_FOCUS"
takeFocusX w = withWindowSet $ \ws -> do
    dpy <- asks display
    wmtakef <- atom_WM_TAKE_FOCUS
    wmprot <- atom_WM_PROTOCOLS

    protocols <- io $ getWMProtocols dpy w
    when (wmtakef `elem` protocols) $ do
        io $ allocaXEvent $ \ev -> do
            setEventType ev clientMessage
            setClientMessageEvent ev w wmprot 32 wmtakef currentTime
            sendEvent dpy w False noEventMask ev

-- Urgency hint configuration
myUrgencyHook = withUrgencyHook dzenUrgencyHook
    {
      args = [
         "-y", "753", "-h", "15", "-x", "1000", "-w", "424",
         "-fg", "#aaaaaa",
         "-bg", "#330000",
         "-fn", terminusMedium
         ],
      duration = (seconds 4)
    }
