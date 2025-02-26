# How to RMOD

## Create a server
1. Copy `RMOD_server.lua` on your server (requires the `serverAPI` script).
2. Add `RMOD_server = require("RMOD_server")` to your server code.
3. Call `RMOD_server.setup("<your-hostname>")`.
4. Finally, call `RMOD_server.start()` when you want to start the server.

## Use the command line tool to manage the modules
1. Copy `rmod.lua` on your server.
2. Run it from the shell to add or remove module versions.
#### Commands:
- Add a new version: `rmod push -p <path> -m <name> -v <version>`
- Remove a version: `rmod remove -m <name> -v <version>`

> Where:
`<path>` = path to the module code,
`<name>` = name of the module,
`<version>` = version number.

## Get the modules from the server in your program
1. Copy `RMOD_client.lua` on your local machine.
2. Add `RMOD_client = require("RMOD_client")` to your local code.
3. Call `RMOD_client.get("<hostname>", "<module>")`
to get your module from the server.
An additional `"<version>"` parameter can be used to specify the version you want to download - if it's not provided, it will get the latest one.
