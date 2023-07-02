#!/usr/bin/env python3

import i3ipc
import sys

sway = i3ipc.Connection()

def get_active_output(conn) -> str:
    outputs = conn.get_outputs()
    for output in outputs:
        if output.focused:
            return output.name
    return ""

output = get_active_output(sway)
num = sys.argv[1]

sway.command(f"move container to workspace {num}:{output}")
