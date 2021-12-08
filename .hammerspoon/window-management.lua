local log = hs.logger.new('utils', 'info')
-- HyperKey.app doing the similar effects as karabiner elements in the artilce
-- https://prodtyping.com/blog/hyperkey-hammerspoon
local hyper = {"cmd", "alt", "ctrl","shift"}
local function moveFocusedWindowToNextScreen()
        local win = hs.window.focusedWindow()
        local screen = win:screen()
        -- https://www.hammerspoon.org/docs/hs.window.html#moveToScreen
        win:moveToScreen(screen:next())
end


local function logMessage()
        log.i('pressed abc')
end


-- bind hotkey
-- hs.hotkey.bind('hyper', 'n', moveFocusedWindowToNextScreen)
--hs.hotkey.bind({'cmd','alt','ctrl','shift'}, 'n', moveFocusedWindowToNextScreen)
hs.hotkey.bind(hyper, 'n', moveFocusedWindowToNextScreen)

return moveFocusedWindowToNextScreen
