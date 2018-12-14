#!/usr/bin/env python
"""Parse workspaces from i3-msg"""
import subprocess
import json

def get_workspaces():
    """fetch the workspace json object from i3-msg"""
    return json.loads(subprocess.check_output(["i3-msg", "-t", "get_workspaces"]))

def list_names():
    """list workspace names"""
    return [i['name'] for i in get_workspaces()]

def print_for_dmenu():
    """print for dmenu"""
    print '\n'.join(list_names())

print_for_dmenu()
