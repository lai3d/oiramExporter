fn oiram_install plugin_name =
(
	-- ���Ҳ���Ƿ��Ѵ���
	pluginExists = false
	pluginCount = pluginPaths.count()
	for n = 1 to pluginCount do
	(
		path = pluginPaths.get(n)
		if findString path plugin_name != undefined do
		(
			pluginExists = true
			exit
		)
	)
	
	-- �õ�plugin.ini��·��
	pluginIniFile = (GetDir #maxData)
	-- plugin.ini��Max2010��ʼ����ΪPlugin.UserSettings.ini
	if ((maxVersion())[1]) > 11000 then
		pluginIniFile += "Plugin.UserSettings.ini"
	else
		pluginIniFile += "plugin.ini"

	-- �������Ѵ���
	if pluginExists then
	(
		-- �����·����plugin.ini��ȥ��
		delIniSetting pluginIniFile "Directories" plugin_name

		callbacks.removeScripts #preSystemShutdown id:#oiram_install
	)
	-- ���������
	else
	(
		pluginPath = GetDir #maxroot + "plugins\\" + plugin_name
		-- ������·���Ѵ��ڵĻ�, �����������
		if doesFileExist pluginPath do
		(
			pluginBackupPath = pluginPath + timeStamp() as string
			renameFile pluginPath pluginBackupPath
		)
		
		-- �����·�����ӵ�plugin.ini��
		setINISetting pluginIniFile "Directories" plugin_name pluginPath
		
		-- ����װ·������Ϊִ��·��
		renameFile (pluginPath + "_install") pluginPath
		
		files = getFiles (pluginPath + "\\bin\\*.*")
		for f in files do
		(
			copyFile (f) (GetDir #maxroot)
		)
	)

	-- ����3dsmax
	ShellLaunch (GetDir #maxroot + "3dsmax.exe") ""
	quitMAX #noPrompt
)


fn oiram_clean =
(
	deleteFile (GetDir #startupScripts + "\\oiram.ms")
	deleteFile (GetDir #startupScripts + "\\oiram_startup.ms")
)