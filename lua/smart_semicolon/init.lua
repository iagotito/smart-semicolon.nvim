local last_char = nil
local last_ending = nil
local valid_endings= { "')", '")', "'", '"', ")", "]", "}", ")}", "]}", "')}",
                    '")}', '("")', "('')"}

local function get_word()
    return vim.fn.expand("<cword>")
end

local function get_line()
    return vim.fn.getline(".")
end

local function has_valid_ending(word)
    for index, value in ipairs(valid_endings) do
        if word:sub(-string.len(value)) == value then
            last_ending = value
            return true
        end
    end
    last_ending = nil
    return false
end

local function word_at_end_line(word, line)
    return line:sub(-string.len(word)) == word
end

local function t(str)
    print(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function smart_semicolon(char)
    word = get_word()
    line = get_line()

    if has_valid_ending(word) then
        last_char = char
    else
        last_char = nil
    end

    return last_char ~= nil and word_at_end_line(word, line) and t("<c-o>A" .. char) or char
end

function undo_smart_semicolon()
    if last_ending == nil then
        return t"<BS>"
    else
        word_len = string.len(last_ending) - 1
        if word_len == 3 then
            word_len = 1
        end

        last_ending = nil

        return t("<BS><c-o>" .. word_len .. "h" .. last_char)
    end
end

local function setup()
    local map = vim.api.nvim_set_keymap
    map("i", ";", "v:lua.smart_semicolon(';')", { noremap=true, expr=true })
    map("i", "<c-h>", "v:lua.undo_smart_semicolon()", { noremap=true, expr=true })
end

return { setup=setup }
