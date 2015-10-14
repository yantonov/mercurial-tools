### how to install tortoisemerge to torgoisehg

Install latest tortoiseSVN (tortoise merge is included).

Assumed TortoiseSVN is installed to C:\Program Files\TortoiseSVN\

Edit .hgrc

    [extdiff]
    cmd.tortoisemerge = C:\Program Files\TortoiseSVN\bin\TortoiseMerge.exe

    [merge-tools]
    tortoisemerge.args=/base:$base /mine:$local /theirs:$other /merged:$output
    tortoisemerge.regkey=Software\TortoiseSVN
    tortoisemerge.regkeyalt=Software\Wow6432Node\TortoiseSVN
    tortoisemerge.checkchanged=True
    tortoisemerge.gui=True
    tortoisemerge.priority=-8
    tortoisemerge.diffargs=/base:$parent /mine:$child /basename:'$plabel1' /minename:'$clabel'

    [ui]
    merge = tortoisemerge

    [tortoisehg]
    vdiff = tortoisemerge
