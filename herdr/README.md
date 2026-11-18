# herdr

`endpoints.json` seeds herdr's saved SSH machines (`herdr machine list`).
Herdr owns the live file at `~/.local/state/herdr/client/endpoints.json`, so
bootstrap copies this template there only when it is missing; it is not
symlinked. After adding or renaming machines, copy the live file back here.
The `hermes` and `proxmox` targets resolve through `~/.ssh/config`, which is
not tracked in this repo.
