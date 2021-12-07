local log = hs.logger.new('example','info')
log.i('example')

local query = {"-m", "query", "--windows"}
hs.task.new(
  '/usr/local/bin/yabai',
  function(exitCode, stdOut, stdErr)
    log.i('task callback')
    log.i(stdOut)
    log.i(exitCode)
    log.i(stdErr)
  end,
  query
):start()
log.i('started task')
