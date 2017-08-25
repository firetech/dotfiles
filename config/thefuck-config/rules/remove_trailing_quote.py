import re

def match(command):
    return (command.script.endswith('\'') and len(re.findall(r'\'', command.script)) % 2 == 1)

def get_new_command(command):
    return command.script[:-1]
