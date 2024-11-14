-- https://ngabbs.com/read.php?&tid=42399961

local BLZCommunitiesGuildNewsFrame_OnEvent = CommunitiesGuildNewsFrame_OnEvent
local newsRequireUpdate, newsTimer, i

i = 0

CommunitiesFrameGuildDetailsFrameNews:SetScript(
    "OnEvent",
    function(frame, event)
        if event == "GUILD_NEWS_UPDATE" then
            i = i + 1
            print(i, " | Got event:", event)

            -- If there is newsTimer alive, wait for it to be executed.
            -- else, update the guildNewsFrame and regisiter the new newsTimer.
            if newsTimer then
                newsRequireUpdate = true
                print("Set newsRequireUpdate flag")
            else
                BLZCommunitiesGuildNewsFrame_OnEvent(frame, event)
                print("Updated CommunitiesGuildNewsFrame_OnEvent with", frame, event)
                -- 1秒后, 如果还需要更新公会新闻, 再次更新
                newsTimer =
                    C_Timer.NewTimer(
                    1,
                    function()
                        if newsRequireUpdate then
                            BLZCommunitiesGuildNewsFrame_OnEvent(frame, event)
                            print("Again, updated CommunitiesGuildNewsFrame_OnEvent with", frame, event)
                        end
                        newsTimer = nil
                        print("Set newsTimer into nil")
                    end
                )
                print("Register next newsTimer as", newsTimer)
            end
        else
            BLZCommunitiesGuildNewsFrame_OnEvent(frame, event)
        end
    end
)

print("Hello World!")
