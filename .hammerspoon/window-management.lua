local function moveFocusedWindowToNextScreen()
        local win = hs.window.focusedWindow()
        local screen = win:screen()
        win:move(win:frame():toUnitRect(screen:frame(), screen:next(), true, 0))
end

-- bind hotkey
hs.hotkey.bind({'hyper', 'cmd'}, 'n', moveFocusedWindowToNextScreen)

return moveFocusedWindowToNextScreen
