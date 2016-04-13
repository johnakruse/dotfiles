import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.Spiral
import XMonad.Layout.Accordion
import XMonad.Util.Run
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myLayout = tiled ||| Mirror tiled ||| Full ||| spiral (6/7) ||| Accordion
    where
        tiled = Tall nmaster delta ratio
    
        nmaster = 1
    
        ratio = 1/2
    
        delta = 3/100

myWorkspaces = ["1","2","3","4","5","6","7","8","9","10"]

myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    , className =? "Pidgin" --> doShift "2"
    , className =? "Gimp"   --> doFloat
    ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/john/.xmobarrc"
    xmonad $ ewmh defaultConfig
        { modMask = mod4Mask
        , workspaces = myWorkspaces
        , manageHook = manageDocks <+> myManageHook <+>  manageHook defaultConfig
        , layoutHook = avoidStruts $ smartBorders(myLayout)
        , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "orange" "" . shorten 50
            }
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "slock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((shiftMask, xK_Print), spawn "scrot")
        , ((0, 0x1008ff13), spawn "amixer set Master 2+")
        , ((0, 0x1008ff11), spawn "amixer set Master 2-")
        , ((0, 0x1008ff12), spawn "amixer set Master toggle")
        ]
