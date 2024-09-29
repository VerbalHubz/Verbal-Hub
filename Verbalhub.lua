-- Function to kick the player with a message
local function kickPlayer()
    -- Display the kick message
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "Horomori Anti-Cheat has kicked you, please stop hacking";
        Color = Color3.fromRGB(255, 0, 0); -- Red text for the warning
        Font = Enum.Font.SourceSansBold;
        TextSize = 18;
    })
    
    -- Wait 3 seconds before kicking for the player to see the message
    wait(3)
    
    -- Kick the player
    local player = game.Players.LocalPlayer
    player:Kick("Horomori Anti-Cheat has detected hacking activities. Please stop hacking.")
end

-- Execute the kick function
kickPlayer()
