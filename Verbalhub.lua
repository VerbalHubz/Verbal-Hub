-- Script to kick player with custom anti-cheat message

-- Function to display the kick message and kick the player
local function antiCheatKick()
    local player = game.Players.LocalPlayer -- Get the local player
    local message = "Horomori Anti-Cheat has kicked you, please stop hacking"
    
    -- Display the message
    warn(message) -- Logs the message in the developer console (you can use print() as well)
    
    -- Kick the player
    player:Kick(message) -- Kicks the player with the custom message
end

-- Call the function when the script is executed
antiCheatKick()
