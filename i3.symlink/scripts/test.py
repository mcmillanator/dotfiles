#!/usr/bin/env python
'''Parse workspace configs for i3'''
import yaml

TYPE_MAP = {
    'app' : 'a',
    'term' : 't'
    }

def load_config():
    """Load cofig file to memory"""
    with open('workspaces.yml', 'r') as data:
        return yaml.safe_load(data)

def build_command(config, mode=False):
    """Build command for i3"""
    cmd = 'bindsym '
    if not mode:
        cmd += '$super+'
    if 'app' in config.keys():
        app_type = 's'
        if 'type' in config['app'].keys():
            app_type = TYPE_MAP[config['app']['type']]
        return cmd + "%s exec --no-startup-id ~/.i3/scripts/workspace.sh %s -%s \"%s\""\
               %(config['key'], config['name'], app_type, config['app']['command'])
    return cmd + "%s $%s" \
            %(config['key'], config['name'])

def build_set_command(config):
    """Build set command"""
    return "set $%s workspace %s" %(config['name'], config['name'])

def build_move_command(config):
    """Build move command"""
    return "bindsym $alt+$super+%s move container to $%s" \
            %(config['key'], config['name'])

def build_mode(config):
    """Build mode function"""
    print "mode \"%s\" {" %(config['name'])
    for bindings in config['bindings']:
        print "\t %s ; mode \"default\"" %(build_command(bindings['workspace'], True))
#        print "\t %s ; mode \"default\"" %(build_command(bindings['workspace'], True))
    print "\t bindsym Return mode \"default\""
    print "\t bindsym Escape mode \"default\""
    print "}"
    print "bindsym $alt+%s mode \"%s\"" %(config['key'], config['name'])
    print

for conf in load_config():
    if 'workspace' in conf.keys():
        print build_set_command(conf['workspace'])
        print build_command(conf['workspace'])
        print build_move_command(conf['workspace'])
        print
    elif 'mode' in conf.keys():
        build_mode(conf['mode'])

#mode "game" {
#        # These bindings trigger as soon as you enter the mode
#        set $game workspace game
#        bindsym g $game
#        bindsym $alt+g move container to $game
#
#        bindsym c exec --no-startup-id ~/.i3/scripts/workspace.sh chat -a discord ; mode "default"
#        bindsym s exec --no-startup-id ~/.i3/scripts/workspace.sh game -a steam ; mode "default"
#        bindsym l exec --no-startup-id ~/.i3/scripts/workspace.sh lutris -a lutris ; mode "default"
#        bindsym b exec --no-startup-id ~/.i3/scripts/workspace.sh bnet -a lutris lutris:rungameid/1 ; mode "default"
#
#        # back to normal: Enter or Escape
#}
