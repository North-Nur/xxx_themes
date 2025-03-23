Config = {}

-- รายการธีม
Config.Themes = {
    "default", -- ธีมเริ่มต้น
    "dark",    -- ธีมสีเข้ม
    "light",   -- ธีมสีอ่อน
    "blue",    -- ธีมสีน้ำเงิน
    "red",     -- ธีมสีแดง
    "green"    -- ธีมสีเขียว
}

Config.ThemePermissions = {
    ["dark"] = { "admin", "superadmin" }, -- ธีม "dark" สามารถใช้ได้เฉพาะ admin และ superadmin
    ["red"] = { "vip" } -- ธีม "red" สามารถใช้ได้เฉพาะผู้เล่นที่มี "vip"
}

Config.DefaultTheme = "default"

Config.AllowThemeChange = true

Config.AllowAddingThemes = false

Config.AllowRemovingThemes = false

Config.OpenMenuKey = "F5" -- คีย์ F5 ใช้สำหรับเปิดเมนูธีม

Config.Messages = {
    noPermission = "คุณไม่มีสิทธิ์ในการใช้ธีมนี้", -- ข้อความเมื่อผู้เล่นไม่มีสิทธิ์ใช้ธีม
    themeChanged = "เปลี่ยนธีมเป็น: ~b~%s", -- ข้อความเมื่อเปลี่ยนธีม
    themeNotFound = "ไม่พบธีม: ~r~%s", -- ข้อความเมื่อไม่พบธีม
    themeAdded = "เพิ่มธีม: ~b~%s", -- ข้อความเมื่อเพิ่มธีม
    themeRemoved = "ลบธีม: ~b~%s" -- ข้อความเมื่อลบธีม
}