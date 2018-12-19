import re

def try_extract_ticket_number(branch):
    branch_regexp = re.compile(r'.*/([A-Z]+-[0-9]+)[^/]*$')
    m = branch_regexp.match(branch)
    if m:
        return m.group(1)
    else:
        return None

def precommit_hook(repo, **kwargs):

    # keep a copy of repo.commitctx
    commitctx = repo.commitctx

    def updatectx(ctx, error):

        branch = ctx.branch();
        ticket_number = try_extract_ticket_number(branch)
        if ticket_number != None:
            ctx._text = "".join([ticket_number, ": ", ctx._text])
        return commitctx(ctx, error)

    # monkeypatch the commit method
    repo.commitctx = updatectx
