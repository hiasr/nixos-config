#!/usr/bin/env python3

import i3ipc
from i3ipc import Event
import time

while True:
    try:
        sway = i3ipc.Connection()
        break
    except:
        time.sleep(1)


def get_active_output(conn) -> str:
    outputs = conn.get_outputs()
    for output in outputs:
        print(f"{output.name}: {output.focused}")
    for output in outputs:
        if output.focused:
            return output.name
    return ""

def switch_to_workspace(conn, num, output) -> None:
    print(f"Switching to workspace {num} on output {output}")
    conn.command(f"workspace {num}:{output}")

def move_container_to_workspace(conn, num, output) -> None:
    print(f"Moving container to workspace {num} on output {output}")
    conn.command(f"move container to workspace {num}:{output}{num}")

def handle_tick(conn, e):
    if e.payload == "":
        return

    print(f"New tick: {e.payload}")
    try:
        command, num_str = e.payload.split(":")
        workspace_num = int(num_str)
        active_output = get_active_output(conn)
        if command == "focus":
            switch_to_workspace(conn, workspace_num, active_output)
        elif command == "move":
            move_container_to_workspace(conn, workspace_num, active_output)
    except:
        print("Can't parse to integer")

if __name__ == '__main__':
    sway.on(Event.TICK, handle_tick)
    sway.main()

