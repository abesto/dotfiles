import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig

main :: IO ()
main = xmonad =<< xmobar myConfig 

myConfig = def { terminal = "st"
               , startupHook = setWMName "LG3D"
               } `removeKeysP` ["M-<Return>"]
