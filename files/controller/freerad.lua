module("luci.controller.freerad", package.seeall)

function index()
        if not nixio.fs.access("/etc/config/freeradius") then
                return
        end

        entry({"admin", "services", "freeradius"},
                alias("admin", "services", "freeradius", "users"),
                _("Freeadius"), 70)

        entry({"admin", "services", "freeradius", "users"},
                cbi("freeradius/users"), _("Users"), 10).leaf = true

        entry({"admin", "services", "freeradius", "clients"},
                cbi("freeradius/clients"), _("Clients"), 20).leaf = true
end
