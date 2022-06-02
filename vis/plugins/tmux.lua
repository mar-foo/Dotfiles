vis:command_register("tmux-split-horizontal", function(argv, _, win)
	local cmd = (argv[1] or "")
	local f = io.popen("tmux splitw -v -- " .. cmd)
	f:close()
end)

vis:command_register("tmux-split-vertical", function(argv, _, win)
	local cmd = (argv[1] or "")
	local f = io.popen("tmux splitw -h -- " .. cmd)
	f:close()
end)

vis:command_register("tmux-open-vertical", function(argv, _, win)
	local filename = (argv[1] or "")
	vis:feedkeys(string.format(':tmux-split-vertical "vis %s"<Enter>', filename))
end)

vis:command_register("tmux-open-horizontal", function(argv, _, win)
	local filename = (argv[1] or "")
	vis:feedkeys(string.format(':tmux-split-horizontal "vis %s"<Enter>', filename))
end)

vis:command_register("fzf-tmux", function(argv, force, win, selection, range)
    local command = string.gsub([[
            $fzf_path \
                --header="Enter:edit,^s:split,^v:vsplit" \
                --expect="ctrl-s,ctrl-v" \
                $fzf_args $args
        ]],
        '%$([%w_]+)', {
            fzf_path=module.fzf_path,
            fzf_args=module.fzf_args,
            args=table.concat(argv, " ")
        }
    )

    local file = io.popen(command)
    local output = {}
    for line in file:lines() do
        table.insert(output, line)
    end
    local success, msg, status = file:close()

    if status == 0 then
        local action = 'e'

        if     output[1] == 'ctrl-s' then action = 'tmux-open-horizontal'
        elseif output[1] == 'ctrl-v' then action = 'tmux-open-vertical'
        end

        vis:feedkeys(string.format(":%s '%s'<Enter>", action, output[2]))
    elseif status == 1 then
        vis:info(
            string.format(
                "fzf-open: No match. Command %s exited with return value %i.",
                command, status
            )
        )
    elseif status == 2 then
        vis:info(
            string.format(
                "fzf-open: Error. Command %s exited with return value %i.",
                command, status
            )
        )
    elseif status == 130 then
        vis:info(
            string.format(
                "fzf-open: Interrupted. Command %s exited with return value %i",
                command, status
            )
        )
    else
        vis:info(
            string.format(
                "fzf-open: Unknown exit status %i. command %s exited with return value %i",
                status, command, status
            )
        )
    end

    vis:feedkeys("<vis-redraw>")

    return true;
end, "Select file to open with fzf")

