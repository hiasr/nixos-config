#!/usr/bin/env python3

import i3ipc

sway = i3ipc.Connection()

def get_active_output() -> str:
    outputs = sway.get_outputs()
    for output in outputs:
        if output.focused:
            return output.name
    return ""

def init_workspaces():
    outputs = sway.get_outputs()
    for output in outputs:
        sway.command(f"focus output {output.name}")
        sway.command(f"workspace 1:{output.name}")



if __name__ == '__main__':
    active_output = get_active_output()
    init_workspaces()
    sway.command(f"focus output {active_output}")
