-- Licensed under the Open Software License version 3.0

return {
    name = "role",
    description = "return info about a role",
    hidden = false,
    command = function(message)
        local role
        if message.mentionedRoles.first then
            role = message.mentionedRoles.first
        elseif message.guild:getRole(args) then
            role = message.guild:getRole(args)
        elseif args then
            role = message.guild.roles:find(function(r) return r.name == args end)
        end
        if not role then return message:reply(err) end
        local embedColor
        if discordia.Color(role.color).value == 0 then embedColor = botColor else embedColor = discordia.Color(role.color).value end
        local imageColor = discordia.Color(discordia.Color(role.color).value):toHex():sub(2):lower()
        message:reply({
            embed = {
                thumbnail = {
                    url = "https://dummyimage.com/200x200/" .. imageColor .. "/" .. imageColor .. ".png"
                },
                fields = {
                    {
                        name = "ID",
                        value = role.id,
                        inline = true
                    },
                    {
                        name = "name",
                        value = role.name,
                        inline = true
                    },
                    {
                        name = "color",
                        value = tostring(discordia.Color(role.color):toHex()):lower(),
                        inline = true
                    },
                    {
                        name = "hoisted",
                        value = tostring(role.hoisted):lower(),
                        inline = true
                    },
                    {
                        name = "mentionable",
                        value = tostring(role.mentionable):lower(),
                        inline = true
                    },
                    {
                        name = "managed",
                        value = tostring(role.managed):lower(),
                        inline = true
                    },
                    {
                        name = "position",
                        value = role.position,
                        inline = false
                    },
                    {
                        name = "members",
                        value = role.members:count(),
                        inline = false
                    },
                    {
                        name = "perms",
                        value = utils.tableToString(role:getPermissions():toArray()),
                        inline = false
                    }
                },
                color = embedColor,
                footer = {
                    text = "role created"
                    -- text = "ID: "..role.id.." • created at "..os.date("%d %B %Y", role.createdAt)
                },
                timestamp = role.timestamp
            }
        })
    end
}
