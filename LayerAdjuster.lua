--- Script Info ---
script_name = 'Layer Adjust'
script_description = 'Increase and Decrease the layers of selected lines without ruining them.'
script_author = 'OHIOXOIHO'
script_version = '1.2'



-- Function to adjust layers for selected lines --
function adjustLayers(subtitles, selected_lines, layer_adjustment)
    for _, i in ipairs(selected_lines) do
        local line = subtitles[i]
        line.layer = math.max(0, line.layer + layer_adjustment) -- Ensure the smallest layer is 0 --
        subtitles[i] = line
    end
end

-- Function to prompt the user for layer adjustment value --
function promptForLayerAdjustment()
    local button, values = aegisub.dialog.display(
        {
            {class = "label", label = "Layer Adjustment:", x = 0, y = 0},
            {class = "edit", name = "layers", hint = "You can enter negative value to subtract", value = "0", x = 1, y = 0 }
        },
        {"OK", "Cancel"}
    )

    if button == "OK" then
        return tonumber(values.layers)
    else
        aegisub.cancel()
    end
end

-- Main function --
function adjustLayersMain(subtitles, selected_lines)
    local layer_adjustment = promptForLayerAdjustment()

    if layer_adjustment ~= nil then
        adjustLayers(subtitles, selected_lines, layer_adjustment)
        aegisub.set_undo_point("Adjust Layers")
    else
        aegisub.cancel()
    end
end

-- Register macro --
aegisub.register_macro("Adjust Layers", "Adjust selected lines layers", adjustLayersMain)
