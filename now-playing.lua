-- writes the current track to $XDG_RUNTIME_DIR/music-now for the dwm status bar,
-- with the time into the track and its length on a second line, like 1:23/4:05
local dir = os.getenv("XDG_RUNTIME_DIR") or "/tmp"
local out = dir .. "/music-now"

local function clock(seconds)
    seconds = math.floor(seconds or 0)
    return string.format("%d:%02d", math.floor(seconds / 60), seconds % 60)
end

local function write()
    local title = mp.get_property("media-title") or ""
    local artist = mp.get_property("metadata/by-key/artist")
    local pos = mp.get_property_number("playlist-pos-1", 1)
    local count = mp.get_property_number("playlist-count", 1)
    local icon = mp.get_property_native("pause") and "⏸" or "♪"

    local line = icon .. " "
    if artist and artist ~= "" and not title:find(artist, 1, true) then
        line = line .. artist .. " - "
    end
    line = line .. title
    if count > 1 then
        line = line .. string.format(" [%d/%d]", pos, count)
    end

    local f = io.open(out, "w")
    if f then
        f:write(line, "\n")
        local length = mp.get_property_number("duration")
        if length then
            f:write(clock(mp.get_property_number("time-pos")), "/", clock(length), "\n")
        end
        f:close()
    end
end

mp.register_event("file-loaded", write)
mp.observe_property("pause", "native", write)
mp.observe_property("metadata", "native", write)
-- once a second for the time, which also covers seeking
mp.add_periodic_timer(1, write)
mp.register_event("shutdown", function() os.remove(out) end)
