import XMonad
import XMonad.Hooks.DynamicLog

main :: IO ()
main = xmonad =<< xmobar myConfig

myConfig = def { terminal = "st"
               }
