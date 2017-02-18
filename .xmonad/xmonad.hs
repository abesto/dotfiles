import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig

main :: IO ()
main = xmonad =<< xmobar myConfig

myConfig = def { terminal = "urxvt -e bash --norc -c \"tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$(hostname)\""
               , startupHook = setWMName "LG3D"
               } `removeKeysP` ["M-<Return>"]
