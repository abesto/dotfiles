-- Based on And1's xmonad.hs. wfarrPrompt (obviously) from wfarr's xmonad.hs

import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.LayoutHints
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.HintedTile

import XMonad.Actions.WindowBringer
import XMonad.Actions.CycleWS

import XMonad.ManageHook

import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Themes

import XMonad.Prompt
import XMonad.Prompt.Shell

-- import qualified System.IO.UTF8

import qualified Data.Map as M
import qualified XMonad.Actions.FlexibleResize as Flex
import qualified XMonad.StackSet as W

main = do
    din <- spawnPipe myStatusBar
    din2 <- spawnPipe myTopBar

    xmonad $ myUrgencyHook $ defaultConfig
       { normalBorderColor = "#0f0f0f"
       , focusedBorderColor = "#0077cc"
       , terminal = "xterm"
       , layoutHook = myLayout
       , manageHook = newManageHook <+> manageDocks
       , workspaces = ["1:emacs"] ++ map show [2..9] ++ ["mail", "im", "www"]
       --, workspaces = ["1:irc", "2:www", "3:music"] ++ map show [4..9]
       , numlockMask = mod2Mask
       , modMask = mod1Mask
       , borderWidth = 1
       , logHook = dynamicLogWithPP $ myDzenPP din
       , focusFollowsMouse = True
       }
       `additionalKeysP`
       [
       -- Application launchers
       ("M-S-f", spawn "firefox")
       , ("M-S-<Return>", spawn "xterm")
       , ("M-S-o", spawn "soffice")
       , ("M-S-e", spawn "emacs")
       -- Prompt
       , ("M-p", shellPrompt wfarrPrompt)
       -- Workspaces
       , ("M-w", windows $ W.greedyView "www")
       , ("M-m", windows $ W.greedyView "mail")
       , ("M-i", windows $ W.greedyView "im")
       -- Volume control
       , ("M-<KP_Add>", spawn "amixer set PCM 5%+")
       , ("M-<KP_Subtract>", spawn "amixer set PCM 5%-")
       ]

wfarrPrompt :: XPConfig
wfarrPrompt = defaultXPConfig { font              = "-xos4-terminus-medium-r-normal-*-12-*-*-*-c-*-iso10646-1"
                              , bgColor           = "black"
                              , fgColor           = "#999999"
                              , fgHLight          = "#ffffff"
                              , bgHLight          = "#4c7899"
                              , promptBorderWidth = 0
                              , position          = Bottom
                              , height            = 18
                              , historySize       = 128 }

--myFont = "xft:DejaVu Vera Sans Mono:pixelsize=12"
myFont    = "-xos4-terminus-medium-r-normal-*-12-*-*-*-c-*-iso10646-1"
myFontBig = "-xos4-terminus-bold-r-normal-*-32-*-*-*-*-*-iso10646-1"

-- Statusbars
myStatusBar = "dzen2 -x '0' -y '0' -h '12' -w '600' -ta 'l' -fg '#f0f0ff' -bg '#0f0f0f' -fn '" ++ myFont ++ "'"
myTopBar = "conky -c ~/.conkyrc/conky-bar | dzen2 -x '600' -y '0' -h '12' -ta 'r' -fg '#AAAAEE' -bg '#0f0f0f' -fn '" ++ myFont ++ "'"

-- Urgency hint options:
myUrgencyHook = withUrgencyHook dzenUrgencyHook
    { args = ["-x", "0", "-y", "1010", "-h", "12", "-ta", "r", "-expand", "l", "-fg", "#0099ff", "-bg", "#0f0f0f", "-fn", myFont] }

-- Layout
myLayout = avoidStruts $ smartBorders (tabbed shrinkText (theme wfarrTheme) ||| hintedTile Wide  ||| Full)
       where
       hintedTile = HintedTile nmaster delta ratio TopLeft
       nmaster = 1
       ratio = toRational (2/(1+sqrt(5)::Double))
       delta = 3/100

-- Window rules
myManageHook = composeAll . concat $
    [ [className =? c --> doFloat | c <- myFloats]
    , [title =? t --> doFloat | t <- myOtherFloats]
    , [resource =? r --> doFloat | r <- myIgnores]
    , [className =? "Gran Paradiso" --> doF (W.shift "www")]
    , [className =? "Pidgin" --> doF (W.shift "im")]
    , [className =? "Thunderbird" --> doF (W.shift "mail")]
    , [className =? "Claws-mail" --> doF (W.shift "mail")]
    , [title =? "mutt" --> doF (W.shift "mail")]
    ]
    where
    myFloats = ["Gimp", "gimp", "Xmessage"]
    myOtherFloats = ["Downloads", "*Preferences*", "Save As..."]
    myIgnores = []
newManageHook = myManageHook <+> manageHook defaultConfig

-- dynamicLog pretty printer for dzen:
myDzenPP h = defaultPP
    { ppCurrent = wrap "^fg(#0099ff)^bg(#333333)[^fg(#ffffff)" "^fg(#0099ff)]^fg()^bg()^p()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
     --ppVisible = wrap "^fg(#ffffff)^bg(#333333)" "^fg()^bg()^p()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
     , ppHidden = wrap " " " "
     --ppHiddenNoWindows = wrap "^fg(#777777)^bg()^p()^i(/home/and1/.dzen/corner.xbm)" "^fg()^bg()^p()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
    , ppUrgent = wrap "^fg(#0099ff)^bg()^p()" "^fg()^bg()^p()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
    , ppSep = " "
    , ppWsSep = ""
    , ppTitle = dzenColor "#ffff77" "" . wrap "<" ">"
    , ppLayout =
        (\x -> case x of
        "Wide" -> "[-]"
        "Tabbed Simplest" -> "[|]"
        "Full" -> "[ ]"
        )
    , ppOutput = hPutStrLn h
    }
