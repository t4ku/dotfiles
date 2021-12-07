stackline = require "stackline"
stackline:init()

local log = hs.logger.new('utils', 'info')

require("hs.ipc")

-- install 'hs' command
local cliInstalled = hs.ipc.cliStatus()
if not cliInstalled then
        log.i('installing cli..')
        hs.ipc.cliInstall()
end

wm = require "window-management"
