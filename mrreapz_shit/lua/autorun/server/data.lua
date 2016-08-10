mrreapz_spellbook_data = {}

mrreapz_load_data = function()
	if file.Size("mrreaps.txt", "DATA") == 0 then
		file.Write("mrreaps.txt", "{}");
		return
	else
		mrreapz_spellbook_data = util.JSONToTable(file.Read("mrreaps.txt", "DATA"))
	end
end

mrreapz_save_data = function()
	file.Write("mrreaps.txt", util.TableToJSON(mrreapz_spellbook_data));
end

mrreapz_load_data()
