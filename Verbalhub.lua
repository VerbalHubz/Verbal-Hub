-- Define the message to display when the player is kicked
local message = "Horomori Anti-Cheat has kicked you. Please stop hacking."

-- Get the local player (the player executing the script)
local player = game.Players.LocalPlayer

-- Function to display the message and kick the player
local function kickPlayer()
    -- Display the message
    print(message)
    
    -- Kick the player with the message
    player:Kick(message)
end

-- Execute the function to kick the player
kickPlayer()
