shared_script "@bt_defender/module/shared.lua"



fx_version 'adamant'

game 'gta5'

description 'xxx_gachapon'

version '1.0.0'

lua54 'yes'
server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'config.lua',
	'config_sv.lua',

	'server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client.lua',
	
}
ui_page('ui/ui.html')

files {
    'ui/ui.html',
    'ui/*',
	'ui/img/*',
    'ui/js/*',
	'ui/sound/*',

	-- 'ui/sound/*.mp3'
	
}
