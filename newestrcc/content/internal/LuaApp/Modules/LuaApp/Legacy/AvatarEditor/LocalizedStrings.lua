local LocalizationService = game:GetService("LocalizationService")
local HttpService = game:GetService("HttpService")

local this = {}

local function createLocalizationTable(contents)
	local localTable = Instance.new("LocalizationTable")
	localTable.DevelopmentLanguage = LocalizationService.SystemLocaleId
	localTable:SetContents(HttpService:JSONEncode(contents))
	return localTable
end

local AvatarEditorStringsTable = createLocalizationTable({
	-- Console button indicators
	[1] =
	{
		key = "FullViewWord"; -- The 'expressionKey' to be used with GetString
		values =
		{	-- A dictionary of keys corresponding to IETF language tags, and their translations.
			["en-us"] = "Full View";		-- English
			["es"] = "Vista completa";			-- Spanish
		}
	};
	[2] =
	{
		key = "SwitchToR6Word";
		values =
		{
			["en-us"] = "Switch to R6";
			["es"] = "Cambiar a R6";
		}
	};
	[3] =
	{
		key = "SwitchToR15Word";
		values =
		{
			["en-us"] = "Switch to R15";
			["es"] = "Cambiar a R15";
		}
	};

	-- Categories and tab pages
	[4] =
	{
		key = "RecentWord";
		values =
		{
			["en-us"] = "Recent";
			["es"] = "Recientes";
		}
	};
	[5] =
	{
		key = "ClothingWord";
		values =
		{
			["en-us"] = "Clothing";
			["es"] = "Ropa";
		}
	};
	[6] =
	{
		key = "BodyWord";
		values =
		{
			["en-us"] = "Body";
			["es"] = "Cuerpo";
		}
	};
	[7] =
	{
		key = "AnimationWord";
		values =
		{
			["en-us"] = "Animation";
			["es"] = "Animación";
		}
	};
	[8] =
	{
		key = "AnimationsWord";
		values =
		{
			["en-us"] = "Animations";
			["es"] = "Animaciones";
		}
	};
	[9] =
	{
		key = "CostumeWord";
		values =
		{
			["en-us"] = "Costume";
			["es"] = "Disfraz";
		}
	};
	[10] =
	{
		key = "OutfitsWord";
		values =
		{
			["en-us"] = "Outfits";
			["es"] = "Conjuntos";
		}
	};

	[11] =
	{
		key = "RecentAllWord";
		values =
		{
			["en-us"] = "Recent All";
			["es"] = "Todos los recientes";
		}
	};
	[12] =
	{
		key = "AllWord";
		values =
		{
			["en-us"] = "All";
			["es"] = "Todos";
		}
	};
	[13] =
	{
		key = "RecentClothingWord";
		values =
		{
			["en-us"] = "Recent Clothing";
			["es"] = "Ropa reciente";
		}
	};
	[14] =
	{
		key = "RecentBodyWord";
		values =
		{
			["en-us"] = "Recent Body";
			["es"] = "Cuerpos recientes";
		}
	};
	[15] =
	{
		key = "RecentAnimationWord";
		values =
		{
			["en-us"] = "Recent Animation";
			["es"] = "Animaciones recientes";
		}
	};
	[16] =
	{
		key = "RecentCostumesWord";
		values =
		{
			["en-us"] = "Recent Costumes";
			["es"] = "Disfraces recientes";
		}
	};

	[17] =
	{
		key = "HatsWord";
		values =
		{
			["en-us"] = "Hats";
			["es"] = "Sombreros";
		}
	};
	[18] =
	{
		key = "HatWord";
		values =
		{
			["en-us"] = "Hat";
			["es"] = "Sombrero";
		}
	};
	[19] =
	{
		key = "HairWord";
		values =
		{
			["en-us"] = "Hair";
			["es"] = "Pelo";
		}
	};
	[20] =
	{
		key = "FaceAccessoriesWord";
		values =
		{
			["en-us"] = "Face Accessories";
			["es"] = "Accesorios para la cara";
		}
	};
	[21] =
	{
		key = "FaceWord";
		values =
		{
			["en-us"] = "Face";
			["es"] = "Cara";
		}
	};
	[22] =
	{
		key = "NeckAccessoriesWord";
		values =
		{
			["en-us"] = "Neck Accessories";
			["es"] = "Accesorios para el cuello";
		}
	};
	[23] =
	{
		key = "NeckWord";
		values =
		{
			["en-us"] = "Neck";
			["es"] = "Cuello";
		}
	};
	[24] =
	{
		key = "ShoulderAccessoriesWord";
		values =
		{
			["en-us"] = "Shoulder Accessories";
			["es"] = "Accesorios para el hombro";
		}
	};
	[25] =
	{
		key = "ShoulderWord";
		values =
		{
			["en-us"] = "Shoulder";
			["es"] = "Hombro";
		}
	};
	[26] =
	{
		key = "FrontAccessoriesWord";
		values =
		{
			["en-us"] = "Front Accessories";
			["es"] = "Accesorios frontales";
		}
	};
	[27] =
	{
		key = "FrontWord";
		values =
		{
			["en-us"] = "Front";
			["es"] = "Frontal";
		}
	};
	[28] =
	{
		key = "BackAccessoriesWord";
		values =
		{
			["en-us"] = "Back Accessories";
			["es"] = "Accesorios traseros";
		}
	};
	[29] =
	{
		key = "BackWord";
		values =
		{
			["en-us"] = "Back";
			["es"] = "Trasero";
		}
	};
	[30] =
	{
		key = "WaistAccessoriesWord";
		values =
		{
			["en-us"] = "Waist Accessories";
			["es"] = "Accesorios para la cintura";
		}
	};
	[31] =
	{
		key = "WaistWord";
		values =
		{
			["en-us"] = "Waist";
			["es"] = "Cintura";
		}
	};
	[32] =
	{
		key = "ShirtsWord";
		values =
		{
			["en-us"] = "Shirts";
			["es"] = "Camisas";
		}
	};
	[33] =
	{
		key = "ShirtWord";
		values =
		{
			["en-us"] = "Shirt";
			["es"] = "Camisa";
		}
	};
	[34] =
	{
		key = "PantsWord";
		values =
		{
			["en-us"] = "Pants";
			["es"] = "Pantalones";
		}
	};

	[35] =
	{
		key = "FacesWord";
		values =
		{
			["en-us"] = "Faces";
			["es"] = "Caras";
		}
	};
	[36] =
	{
		key = "FaceWord";
		values =
		{
			["en-us"] = "Face";
			["es"] = "Cara";
		}
	};
	[37] =
	{
		key = "HeadsWord";
		values =
		{
			["en-us"] = "Heads";
			["es"] = "Cabezas";
		}
	};
	[38] =
	{
		key = "HeadWord";
		values =
		{
			["en-us"] = "Head";
			["es"] = "Cabeza";
		}
	};
	[39] =
	{
		key = "TorsosWord";
		values =
		{
			["en-us"] = "Torsos";
			["es"] = "Torsos";
		}
	};
	[40] =
	{
		key = "TorsoWord";
		values =
		{
			["en-us"] = "Torso";
			["es"] = "Torso";
		}
	};
	[41] =
	{
		key = "RightArmsWord";
		values =
		{
			["en-us"] = "Right Arms";
			["es"] = "Brazos derechos";
		}
	};
	[42] =
	{
		key = "RightArmWord";
		values =
		{
			["en-us"] = "Right Arm";
			["es"] = "Brazo derecho";
		}
	};
	[43] =
	{
		key = "LeftArmsWord";
		values =
		{
			["en-us"] = "Left Arms";
			["es"] = "Brazos izquierdos";
		}
	};
	[44] =
	{
		key = "LeftArmWord";
		values =
		{
			["en-us"] = "Left Arm";
			["es"] = "Brazo izquierdo";
		}
	};
	[45] =
	{
		key = "RightLegsWord";
		values =
		{
			["en-us"] = "Right Legs";
			["es"] = "Piernas derechas";
		}
	};
	[46] =
	{
		key = "RightLegWord";
		values =
		{
			["en-us"] = "Right Leg";
			["es"] = "Pierna derecha";
		}
	};
	[47] =
	{
		key = "LeftLegsWord";
		values =
		{
			["en-us"] = "Left Legs";
			["es"] = "Piernas izquierdas";
		}
	};
	[48] =
	{
		key = "LeftLegWord";
		values =
		{
			["en-us"] = "Left Leg";
			["es"] = "Pierna izquierda";
		}
	};
	[49] =
	{
		key = "GearWord";
		values =
		{
			["en-us"] = "Gear";
			["es"] = "Equipamiento";
		}
	};
	[50] =
	{
		key = "SkinToneWord";
		values =
		{
			["en-us"] = "Skin Tone";
			["es"] = "Tono de piel";
		}
	};
	[51] =
	{
		key = "ScaleWord";
		values =
		{
			["en-us"] = "Scale";
			["es"] = "Escala";
		}
	};

	[52] =
	{
		key = "ClimbAnimationsWord";
		values =
		{
			["en-us"] = "Climb Animations";
			["es"] = "Animaciones de escalada";
		}
	};
	[53] =
	{
		key = "JumpAnimationsWord";
		values =
		{
			["en-us"] = "Jump Animations";
			["es"] = "Animaciones de salto";
		}
	};
	[54] =
	{
		key = "FallAnimationsWord";
		values =
		{
			["en-us"] = "Fall Animations";
			["es"] = "Animaciones de caída";
		}
	};
	[55] =
	{
		key = "IdleAnimationsWord";
		values =
		{
			["en-us"] = "Idle Animations";
			["es"] = "Animaciones de inactividad";
		}
	};
	[56] =
	{
		key = "WalkAnimationsWord";
		values =
		{
			["en-us"] = "Walk Animations";
			["es"] = "Animaciones de marcha";
		}
	};
	[57] =
	{
		key = "RunAnimationsWord";
		values =
		{
			["en-us"] = "Run Animations";
			["es"] = "Animaciones de carrera";
		}
	};
	[58] =
	{
		key = "SwimAnimationsWord";
		values =
		{
			["en-us"] = "Swim Animations";
			["es"] = "Animaciones de nado";
		}
	};

	[59] =
	{
		key = "ClimbWord";
		values =
		{
			["en-us"] = "Climb";
			["es"] = "Escalada";
		}
	};
	[60] =
	{
		key = "JumpWord";
		values =
		{
			["en-us"] = "Jump";
			["es"] = "Salto";
		}
	};
	[61] =
	{
		key = "FallWord";
		values =
		{
			["en-us"] = "Fall";
			["es"] = "Caída";
		}
	};
	[62] =
	{
		key = "IdleWord";
		values =
		{
			["en-us"] = "Idle";
			["es"] = "Inactividad";
		}
	};
	[63] =
	{
		key = "WalkWord";
		values =
		{
			["en-us"] = "Walk";
			["es"] = "Marcha";
		}
	};
	[64] =
	{
		key = "RunWord";
		values =
		{
			["en-us"] = "Run";
			["es"] = "Carrera";
		}
	};
	[65] =
	{
		key = "SwimWord";
		values =
		{
			["en-us"] = "Swim";
			["es"] = "Nado";
		}
	};

	-- Category menu and tab list
	[66] =
	{
		key = "ErrorDisplayTitle";
		values =
		{
			["en-us"] = "[errdisplay]";
			["es"] = "[errdisplay]";
		}
	};

	-- Page
	[67] =
	{
		key = "NoAssetsPhrase";
		values =
		{
			["en-us"] = "You don't have any %s";
			["es"] = "No tienes %s";
		}
	};
	[68] =
	{
		key = "RecommendedWord";
		values =
		{
			["en-us"] = "Recommended";
			["es"] = "Recomendado";
		}
	};

	--Scale slider titles
	[69] =
	{
		key = "HeightWord";
		values =
		{
			["en-us"] = "Height";
			["es"] = "Altura";
		}
	};
	[70] =
	{
		key = "WidthWord";
		values =
		{
			["en-us"] = "Width";
			["es"] = "Anchura";
		}
	};
	[71] =
	{
		key = "HeadWord";
		values =
		{
			["en-us"] = "Head";
			["es"] = "Cabeza";
		}
	};

	-- Detail page
	[72] =
	{
		key = "WearWord";
		values =
		{
			["en-us"] = "Wear";
			["es"] = "Vestir";
		}
	};
	[73] =
	{
		key = "TakeOffWord";
		values =
		{
			["en-us"] = "Take Off";
			["es"] = "Quitar";
		}
	};
	[74] =
	{
		key = "ViewDetailsWord";
		values =
		{
			["en-us"] = "View details";
			["es"] = "Ver detalles";
		}
	};

	-- Spins
	[75] =
	{
		key = "SpinsWord";
		values =
		{
			["en-us"] = "spins%s";
			["es"] = "giros %s";
		}
	};

	-- Error message
	[76] =
	{
		key = "ErrorMessagePhrase";
		values =
		{
			["en-us"] = "Error: %s";
			["es"] = "Error: %s";
		}
	};
	[77] =
	{
		key = "GetAssetInfoFailPhrase";
		values =
		{
			["en-us"] = "failed to get asset info %s";
			["es"] = "no se ha podido obtener la información del recurso %s";
		}
	};
	[78] =
	{
		key = "GetPhrase";
		values =
		{
			["en-us"] = "Get %s";
			["es"] = "Obtener %s";
		}
	};
	[79] =
	{
		key = "SetPhrase";
		values =
		{
			["en-us"] = "Set %s";
			["es"] = "Fijar %s";
		}
	};

	-- Warnings
	[80] =
	{
		key = "ScalingForR15Phrase";
		values =
		{
			["en-us"] = "Scaling only works\nfor R15 avatars";
			["es"] = "El escalado solo funciona\ncon avatares R15";
		}
	};
	[81] =
	{
		key = "AnimationsForR15Phrase";
		values =
		{
			["en-us"] = "Animations only work\nfor R15 avatars";
			["es"] = "Las animaciones solo funcionan\ncon avatares R15";
		}
	};
	[82] =
	{
		key = "R15OnlyPhrase";
		values =
		{
			["en-us"] = "This feature is only available for R15";
			["es"] = "Esta función solo está disponible con R15";
		}
	};
	[83] =
	{
		key = "DefaultClothingAppliedPhrase";
		values =
		{
			["en-us"] = "Default clothing has been applied to your avatar - wear something from your wardrobe";
			["es"] = "Se le ha aplicado la ropa predeterminada a tu avatar. Viste algo de tu guardarropa";
		}
	};
	[84] =
	{
		key = "ErrorWarningPhrase";
		values =
		{
			["en-us"] = "errtext";
			["es"] = "errtext";
		}
	};
	[85] =
	{
		key = "RecentItemsWord";
		values =
		{
			["en-us"] = "recent items";
		}
	};
	[86] =
	{
		key = "ReturnToEditWord";
		values =
		{
			["en-us"] = "Return to edit";
		}
	}
})


function this:GetLocale()
	return game:GetService("LocalizationService").SystemLocaleId
end

function this:GetAvatarEditorString(locale, stringKey)
	local success, result = pcall(function()
		return AvatarEditorStringsTable:GetString(locale, stringKey)
	end)

	if success and result then
		return result
	end

	return nil
end

function this:LocalizedString(stringKey)
	local locale = self:GetLocale()
	local localeLanguage = locale and string.sub(locale, 1, 2)
	local result = locale and self:GetAvatarEditorString(locale, stringKey) or
		self:GetAvatarEditorString(localeLanguage, stringKey)
	if not result then
		print("LocalizedString: Could not find string for:" , stringKey , "using locale:" , locale)
		result = self:GetAvatarEditorString("en-us", stringKey) or stringKey
	end
	return result
end

return this
