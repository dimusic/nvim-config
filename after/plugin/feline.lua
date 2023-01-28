local line_ok, feline = pcall(require, "feline")

if not line_ok then
    return
end

local my_theme = {
    oceanblue = "#1F1F23",
}

feline.setup({
    theme = my_theme,
})
