return table.freeze({
    ["GetActiveTeam"] = function(p1)
        if p1 == "Counter-Terrorists" or p1 == "Terrorists" then
            return p1
        else
            return nil
        end
    end,
    ["IsFreeForAllGamemode"] = function(_)
        return true
    end,
    ["GetVoteMode"] = function(_)
        return "FFA"
    end,
    ["GetParticipantLabel"] = function(p2)
        return p2 == "FFA" and "players" or "teammates"
    end
})