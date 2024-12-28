-- local log = hs.logger.new('utils', 'info')
-- -- HyperKey.app doing the similar effects as karabiner elements in the artilce
-- -- https://prodtyping.com/blog/hyperkey-hammerspoon
-- local hyper = {"cmd", "alt", "ctrl","shift"}
-- local function moveFocusedWindowToNextScreen()
--         local win = hs.window.focusedWindow()
--         local screen = win:screen()
--         -- https://www.hammerspoon.org/docs/hs.window.html#moveToScreen
--         win:moveToScreen(screen:next())
-- end
-- 
-- 
-- local function logMessage()
--         log.i('pressed abc')
-- end
-- 
-- 
-- -- bind hotkey
-- -- hs.hotkey.bind('hyper', 'n', moveFocusedWindowToNextScreen)
-- --hs.hotkey.bind({'cmd','alt','ctrl','shift'}, 'n', moveFocusedWindowToNextScreen)
-- hs.hotkey.bind(hyper, 'n', moveFocusedWindowToNextScreen)
-- 
-- return moveFocusedWindowToNextScreen
-- 
local log = hs.logger.new('utils', 'info')
local hyper = {"cmd", "alt", "ctrl", "shift"}
--local hyper={"left_"}

-- Function to move the focused window to the next screen
local function moveFocusedWindowToNextScreen()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    win:moveToScreen(screen:next())
end

-- Function to resize window to full screen
local function fullScreenWindow()
    local win = hs.window.focusedWindow()
    win:maximize()
end

-- Function to toggle window between half screens
local function halfScreenWindow()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    if f.x == max.x then
        -- Move to right half
        f.x = max.x + (max.w / 2)
    else
        -- Move to left half
        f.x = max.x
    end
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end

-- Function to resize window to one-third of the screen
local function oneThirdScreenWindow()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    if f.x <= max.x then
        -- Move to middle third
        f.x = max.x + (max.w / 3)
    elseif f.x <= max.x + (max.w / 3) then
        -- Move to right third
        f.x = max.x + 2 * (max.w / 3)
    else
        -- Move to left third
        f.x = max.x
    end
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
    win:setFrame(f)
end

-- Bind hotkeys
hs.hotkey.bind(hyper, '1', fullScreenWindow)
hs.hotkey.bind(hyper, '2', halfScreenWindow)
hs.hotkey.bind(hyper, '3', oneThirdScreenWindow)
hs.hotkey.bind(hyper, 'n', moveFocusedWindowToNextScreen)

return {
    moveFocusedWindowToNextScreen,
    fullScreenWindow,
    halfScreenWindow,
    oneThirdScreenWindow
}

