import re

def match(command):
    return (len(re.findall(r'^(gi t|git\S )', command.script)) > 0)

def get_new_command(command):
    if (len(re.findall(r'^gi t', command.script)) > 0):
        return re.compile(r'^gi t').sub('git ', command.script)
    else:
        return re.compile(r'^git(\S) ').sub(r'git \1', command.script)
