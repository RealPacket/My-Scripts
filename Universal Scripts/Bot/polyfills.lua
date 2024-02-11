-- made because codex is gay and can't save files
-- currently only polyfills the file API
-- TODO: should we make it using instances instead?

local polyfills = {}

-- file API
do
	local fs = {}
	-- list files convenience
	local fsData = {
		filePaths = {},
		folderPaths = {},
	}
	-- local function getFileName(path: string)
	-- 	local splitted = path:split("/")
	-- 	return splitted[#splitted]
	-- end
	local function getFolderPath(path: string)
		local splitted = path:split("/")
		return table.concat(splitted, "/", 1, #splitted - 1)
	end
	function polyfills.readfile(name: string)
		local suc, res = pcall(readfile, name)
		if not suc then
			warn("[POLYFILLS] ORIGINAL READ FILE CALL FAILED! REVERTING TO POLYFILL FILES.")
			print("[POLYFILLS]  Error:", res)
			if not fs[name] then
				error(('File "%s" not found in file table!'):format(name))
			end
			return fs[name].content
		end
	end
	function polyfills.isfolder(path: string)
		local suc, res = pcall(isfolder, path)
		if not suc then
			warn("[POLYFILLS] ORIGINAL ISFOLDER CALL FAILED! REVERTING TO POLYFILL FILES.")
			print("[POLYFILLS]  Error:", res)
			return table.find(fsData.folderPaths, path) ~= nil
		end
		return res
	end
	function polyfills.isfile(path: string)
		local suc, res = pcall(isfile, path)
		if not suc then
			warn("[POLYFILLS] ORIGINAL ISFILE CALL FAILED! REVERTING TO POLYFILL FILES.")
			print("[POLYFILLS]  Error:", res)
			return table.find(fsData.filePaths, path) ~= nil
		end
		return res
	end
	function polyfills.writefile(path: string, content: string)
		-- try to call original writefile with protection,
		local suc, res = pcall(writefile, path, content)
		fs[path] = { type = "file", content = content }
		table.insert(fsData.filePaths, path)
		local foldPath = getFolderPath(path)
		local fold = fsData[foldPath]
		print("[POLYFILLS] folder path:", foldPath)
		print("[POLYFILLS] folder:", fold)
		if not fold then
			print(("[POLYFILLS] auto-created folder: %s"):format(foldPath))
			polyfills.makefolder(foldPath)
			fold = fsData[foldPath]
			print("[POLYFILLS] new folder:", fold)
		end
		if not table.find(fold.filePaths, path) then
			print("[POLYFILLS] insert file path")
			table.insert(fold.filePaths, path)
			fsData.folderPaths[foldPath] = fold
		end
		return suc and res
	end
	function polyfills.makefolder(path: string)
		fs[path] = { type = "folder" }
		fsData[path] = {
			type = "folder",
			filePaths = {},
		}
		table.insert(fsData.folderPaths, path)
	end
	function polyfills.listfiles(path: string)
		local suc, res = pcall(listfiles, path)
		if not suc then
			warn("[POLYFILLS] ORIGINAL LIST FILES FAILED! REVERTING TO POLYFILL FS.")
			print("[POLYFILLS]  Error:", res)
			return fsData[path].filePaths
		end
		return res
	end
end

return polyfills
