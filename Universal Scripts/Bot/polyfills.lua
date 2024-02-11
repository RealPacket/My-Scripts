-- made because codex is gay and can't save files
-- currently only polyfills the file API

local polyfills = {}

-- file API
do
	local files = {}
	function polyfills.readfile(name: string)
		local suc, res = pcall(readfile, name)
		if not suc then
			warn("[POLYFILLS] ORIGINAL READ FILE CALL FAILED! REVERTING TO POLYFILL FILES.")
			print("[POLYFILLS]  Error:", res)
			if not files[name] then
				error(('File "%s" not found in file table!'):format(name))
			end
			return files[name]
		end
	end
	function polyfills.writefile(name: string, content: string)
		-- try to call original writefile with protection,
		local suc, res = pcall(writefile, name, content)
		if not suc then
			warn("[POLYFILLS] ORIGINAL WRITEFILE FAILED! REVERTING TO POLYFILL FILES.")
			files[name] = content
			return
		end
		return res
	end
end

return polyfills
