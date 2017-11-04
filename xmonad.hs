import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.FadeInactive
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.Spiral
import XMonad.Layout.Accordion
import XMonad.Layout.Grid
import XMonad.Util.Run
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myLayout = tiled ||| Mirror tiled ||| Full ||| spacedspiral ||| Accordion
    where
        tiled = spacing 3 $ Tall nmaster delta ratio
    
        nmaster = 1
    
        ratio = 1/2
    
        delta = 3/100

        spacedspiral = spacing 3 $ spiral (6/7)

myWorkspaces = ["一","二","三","四","五","六","七","八","九"]

myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    , className =? "Gimp"   --> doFloat
    ]

wsPP =    def { ppOrder = \(ws:_:t:_) -> [ws]
                , ppCurrent = xmobarColor "green" ""
                , ppHidden = xmobarColor "white" ""
                , ppUrgent = xmobarColor "red" "yellow"
                }

tilePP = def { ppOrder = \(ws:_:t:_) -> [t]
             , ppTitle = xmobarColor "orange" "" . shorten 50
             }

myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.8

main = do
    curtile <- spawnPipe "cat > /tmp/.currenttile"
    xmproc <- spawnPipe "/home/john/.cabal/bin/xmobar /home/john/.xmobarrc"
    xmonad $ ewmh defaultConfig
        { modMask = mod4Mask
        , workspaces = myWorkspaces
        , borderWidth = 0
        , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ smartBorders(myLayout)
        , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
        , logHook = dynamicLogWithPP wsPP { ppOutput = hPutStrLn xmproc }
                <+> dynamicLogWithPP tilePP { ppOutput = hPutStrLn curtile }
                <+> myLogHook
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((shiftMask, xK_Print), spawn "scrot")
        , ((0, 0x1008ff13), spawn "amixer set Master 2+")
        , ((0, 0x1008ff11), spawn "amixer set Master 2-")
        , ((0, 0x1008ff12), spawn "amixer set Master toggle")
        ]
