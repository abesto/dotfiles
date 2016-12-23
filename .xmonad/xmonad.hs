import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName

main :: IO ()
main = xmonad =<< xmobar myConfig



myConfig = def { terminal = "st"
               , startupHook = setWMName "LG3D"
               }
