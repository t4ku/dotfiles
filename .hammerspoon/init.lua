stackline = require "stackline"
stackline:init()

local log = hs.logger.new('utils', 'info')

require("hs.ipc")

-- install 'hs' command
local cliInstalled = hs.ipc.cliStatus()
if not cliInstalled then
        log.i('installing cli..')
        local ret = hs.ipc.cliInstall("/opt/homebrew")
        log.i(ret)
        if not ret then
                hs.ipc.cliUninstall()
        end
end

wm = require "window-management"
stackline = require "stackline"
stackline:init()
