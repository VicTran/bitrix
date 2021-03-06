function OnYandexMapSettingsEdit(arParams)
{
	if (null != window.jsYandexCEOpener)
	{
		try {window.jsYandexCEOpener.Close();}catch (e) {}
		window.jsYandexCEOpener = null;
	}

	window.jsYandexCEOpener = new JCEditorOpener(arParams);	
}

function JCEditorOpener(arParams)
{
	var _this = this;

	var jsOptions = arParams.data.split('||');

	var obButton = document.createElement('BUTTON');
	arParams.oCont.appendChild(obButton);
	
	obButton.innerHTML = jsOptions[1];
	obButton.onclick = function ()
	{
		_this.arElements = arParams.getElements();
		if (!_this.arElements)
			return false;

		var map_key = _this.arElements.KEY.value;
		
		if (BX.util.trim(map_key) == '')
		{
			alert(jsOptions[2]);
			return false;
		}

		if (null == window.jsPopup_yandex_map)
		{
			var strUrl = '/bitrix/components/bitrix/map.yandex.view/settings/settings.php?lang=' + jsOptions[0] + 
				'&bxpiheight=430' + 
				'&KEY=' + BX.util.urlencode(map_key) + 
				'&INIT_MAP_TYPE=' + BX.util.urlencode(_this.arElements.INIT_MAP_TYPE.value) + 
				'&MAP_DATA=' + BX.util.urlencode(arParams.oInput.value);
				
			window.jsPopup_yandex_map = new BX.CDialog({
				'content_url': strUrl,
				'width':800, 'height':550, 
				'resizable':false
			});
		}
		
		window.jsPopup_yandex_map.Show();
		window.jsPopup_yandex_map.PARAMS.content_url = '';

		return false;
	}
	
	this.saveData = function(strData, view)
	{
		arParams.oInput.value = strData;
		if (null != arParams.oInput.onchange)
			arParams.oInput.onchange();
		
		if (view)
		{
			_this.arElements.INIT_MAP_TYPE.value = view;
			if (null != _this.arElements.INIT_MAP_TYPE.onchange)
				_this.arElements.INIT_MAP_TYPE.onchange();
		}
		
		_this.Close(false);
	}
}

JCEditorOpener.prototype.Close = function(e)
{
	if (false !== e)
		BX.util.PreventDefault(e);

	if (null != window.jsPopup_yandex_map)
	{
		window.jsPopup_yandex_map.Close();
	}
}