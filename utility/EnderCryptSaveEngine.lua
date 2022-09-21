SaveEngine = {}
SaveEngine.cache = {}

function SaveEngine.open(file,force)
        if (SaveEngine.cache[file] == nil) or (force == true) then
                if not SaveEngine.fileExists(file) then
                        SaveEngine.cache[file] = {}
                end
                local file_load = io.open(file,"r")
                if file_load == nil then
                        return false
                end
                --print("loading save...")
                SaveEngine.cache[file] = {}
                local currentLabel = nil
                input = file_load:read()
                line_number = 0
                while not (input == nil) do
            --print("read: "..input)
                        line_number = line_number + 1
                        if string.sub(input,1,1) == "[" and string.sub(input,string.len(input),string.len(input)) then
                                currentLabel = string.sub(input,2,string.len(input)-1)
                                SaveEngine.cache[file][currentLabel] = {}
                        else
                                if currentLabel == nil then
                                        file_load:close()
                                        return false
                                end
                                local equal_sign = string.find(input,"=")
                                local first = string.sub(input,1,equal_sign-1)
                                local var_type_name = string.find(first,":")
                                local var_type = string.sub(first,1,var_type_name-1)
                                local var = string.sub(first,var_type_name+1,string.len(first))
                                local value = string.sub(input,equal_sign+1,string.len(input))
                                if var_type == "string" then
                                        SaveEngine.cache[file][currentLabel][var] = value
                                end
                                if var_type == "number" then
                                        SaveEngine.cache[file][currentLabel][var] = tonumber(value)
                                end
                                if var_type == "boolean" then
                    SaveEngine.cache[file][currentLabel][var] = nil
                                        if (value == "true") or (value == "1") then
                                                SaveEngine.cache[file][currentLabel][var] = true
                                        end
                    if (value == "false") or (value == "0") then
                                                SaveEngine.cache[file][currentLabel][var] = false
                                        end
                                end
                                if var_type == "table" then
                                        SaveEngine.cache[file][currentLabel][var] = table.tostring(value)
                                end
                --print("Value: "..SaveEngine.cache[file][currentLabel][var])
                        end
                        input = file_load:read()
                end
                file_load:close()
        end
        return true
end

function SaveEngine.fileExists(file)
        local file_check = io.open(file,"r")
        if file_check == nil then
                return false
        end
        file_check:close()
        return true
end

function SaveEngine.save(file)
        if SaveEngine.cache[file] == nil then
                return false
        end
        local file_save = io.open(file,"w")
        if file_save == nil then
                return false
        end
        for label in pairs(SaveEngine.cache[file]) do
                file_save:write("["..label.."]\n")
                for variable in pairs(SaveEngine.cache[file][label]) do
                        local var_type = type(SaveEngine.cache[file][label][variable])
                        local var_name = variable
                        local value = SaveEngine.cache[file][label][variable]
            if var_type == "table" then
                value = table.val_to_str(value)
            end
            file_save:write(var_type..":"..var_name.."="..tostring(value).."\n")
                end
        end
        file_save:close()
        return true
end

function SaveEngine.saveAll()
        if SaveEngine.cache[file] == nil then
                return false
        end
        for file in pairs(SaveEngine.cache) do
                SaveEngine.save(file)
        end
end

function SaveEngine.write(file,label,variable,newValue)
        if SaveEngine.cache[file] == nil then
                SaveEngine.cache[file] = {}
                SaveEngine.cache[file][label] = {}
        end
        if SaveEngine.cache[file][label] == nil then
                SaveEngine.cache[file][label] = {}
        end
        SaveEngine.cache[file][label][variable] = newValue
        return true
end

function SaveEngine.read(file,label,variable,default)
        if SaveEngine.cache[file] == nil then
                SaveEngine.cache[file] = {}
                SaveEngine.cache[file][label] = {}
                SaveEngine.cache[file][label][variable] = default
        end
        if SaveEngine.cache[file][label] == nil then
                SaveEngine.cache[file][label] = {}
                SaveEngine.cache[file][label][variable] = default
        end
        if SaveEngine.cache[file][label][variable] == nil then
                SaveEngine.cache[file][label][variable] = default
        end
        if SaveEngine.cache[file][label][variable] == nil then
                return default
        else
                return SaveEngine.cache[file][label][variable]
        end
end

function SaveEngine.getLabelNames(file)
        local temp = {}
        for label in pairs(SaveEngine.cache[file]) do
                temp[#temp+1] = label
        end
        return temp
end

function SaveEngine.getVarNames(file,label)
        local temp = {}
        for label in pairs(SaveEngine.cache[file]) do
                for variable in pairs(SaveEngine.cache[file][label]) do
                        temp[#temp+1] = variable
                end
        end
        return temp
end
