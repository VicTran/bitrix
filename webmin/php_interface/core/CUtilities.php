<?
class CUtilities{
	function conver_utf8_latin($text) {
	   $text = str_replace(
	    array(' ','&quot;','%',"/"," - ",":",'<','>','?',"#","^","`","'","=","!",":",".","..","*","&","__","- "," -","  ",',','`','“','”','"'),
	    array(' ','','' ,''," "," "," ","","","",""," ",""," "," "," ","","","","",""," "," "," ",'','','','',''),
	    $text);
	   
	    $chars = array("a","A","e","E","o","O","u","U","i","I","d", "D","y","Y");
	   
	    $uni[0] = array("á","à","ạ","ả","ã","â","ấ","ầ", "ậ","ẩ","ẫ","ă","ắ","ằ","ặ","ẳ","ẵ");
	    $uni[1] = array("Á","À","Ạ","Ả","Ã","Â","Ấ","Ầ", "Ậ","Ẩ","Ẫ","Ă","Ắ","Ằ","Ặ","Ẳ","Ẵ");
	    $uni[2] = array("é","è","ẹ","ẻ","ẽ","ê","ế","ề" ,"ệ","ể","ễ");
	    $uni[3] = array("É","È","Ẹ","Ẻ","Ẽ","Ê","Ế","Ề" ,"Ệ","Ể","Ễ");
	    $uni[4] = array("ó","ò","ọ","ỏ","õ","ô","ố","ồ", "ộ","ổ","ỗ","ơ","ớ","ờ","ợ","ở","ỡ");
	    $uni[5] = array("Ó","Ò","Ọ","Ỏ","Õ","Ô","Ố","Ồ", "Ộ","Ổ","Ỗ","Ơ","Ớ","Ờ","Ợ","Ở","Ỡ");
	    $uni[6] = array("ú","ù","ụ","ủ","ũ","ư","ứ","ừ", "ự","ử","ữ");
	    $uni[7] = array("Ú","Ù","Ụ","Ủ","Ũ","Ư","Ứ","Ừ", "Ự","Ử","Ữ");
	    $uni[8] = array("í","ì","ị","ỉ","ĩ");
	    $uni[9] = array("Í","Ì","Ị","Ỉ","Ĩ");
	    $uni[10] = array("đ");
	    $uni[11] = array("Đ");
	    $uni[12] = array("ý","ỳ","ỵ","ỷ","ỹ");
	    $uni[13] = array("Ý","Ỳ","Ỵ","Ỷ","Ỹ");
	   
	    for($i=0; $i<=13; $i++) {
	        $text = str_replace($uni[$i],$chars[$i],$text);
	    }
	    return $text;
	}
	
	function get_sef_url_from_name($text){
		$sef_url = CUtilities::conver_utf8_latin($text);
		$sef_url = str_replace(" ","-",$sef_url);
		$sef_url = strtolower($sef_url);
		return $sef_url;
	}
		
	function get_section_id_by_section_code($ib,$sectioncode){
		$arFilter = Array('IBLOCK_ID'=>$ib,
	                      'GLOBAL_ACTIVE'=>'Y',
						  'CODE'=>$sectioncode
	                      );
	    $db_list = CIBlockSection::GetList(Array($by=>$order), $arFilter, true);
		while($ar_result = $db_list->GetNext())
	    {
	    	return $ar_result['ID'];
	    }	
	}
	
	function get_sections_from_ib($ib,$level=null){
		$arFilter = Array('IBLOCK_ID'=>$ib,
	                      'GLOBAL_ACTIVE'=>'Y'
	                      );
	    if($level!=null){
	    	$arFilter['DEPTH_LEVEL']=$level;
	    }
	    $db_list = CIBlockSection::GetList(Array($by=>$order), $arFilter, true);
	    $_sections = array();
	    while($ar_result = $db_list->GetNext())
	    {
	        $_sections[$ar_result['ID']] = $ar_result['NAME'];
	    }
	    return $_sections;
	}
	
	function get_sections_full_from_ib($ib,$level=null){
		$arFilter = Array('IBLOCK_ID'=>$ib,
	                      'GLOBAL_ACTIVE'=>'Y',
	                      );
	    if($level!=null){
	    	$arFilter['DEPTH_LEVEL']=$level;
	    }
	    $db_list = CIBlockSection::GetList(Array('SORT'=>'ASC'), $arFilter, true);
	    $_sections = array();
	    while($ar_result = $db_list->GetNext())
	    {
	        $_sections[] = $ar_result;
	    }
	    return $_sections;
	}
	
	function get_count_sections($ib,$_parent_section=null){
		$arFilter = Array(
	        "IBLOCK_ID"=>$ib
        );
        if($_parent_section!=null){
			$arFilter["SECTION_ID"]=$_parent_section;
        }
    	return CIBlockSection::GetCount($arFilter);
	}
	
	function get_section_random_from_ib($ib){
		$arFilter = Array('IBLOCK_ID'=>$ib,
	                      'GLOBAL_ACTIVE'=>'Y'
	                      );
	    $db_list = CIBlockSection::GetList(Array($by=>$order), $arFilter, true);
	    $SECTIONS = array();
	    while($ar_result = $db_list->GetNext())
	    {
	        $SECTIONS[] = $ar_result['ID'];
	    }
	    if(count($SECTIONS)>0){
	    	$index = rand(0,count($SECTIONS)-1);
			$_section_id = $SECTIONS[$index];
	    }
	    return $_section_id;
	}
	
	function get_section_code_by_sectionId($ID){
		$res = CIBlockSection::GetByID($ID);
		if ($ar_res = $res->GetNext())
		    return $ar_res['CODE'];
	}
	
    function get_list_sections($ib,$arFilter){
        $arFilter["IBLOCK_ID"] = $ib;
    	$db_list = CIBlockSection::GetList(Array('SORT'=>'ASC'), $arFilter, true);
        while($ar_result = $db_list->GetNext())
	    {        
            
            $_sections[] =  $ar_result;
	    }
	    return $_sections;
	}
    
	function get_ibid_from_ibcode($code){
		global $_GFUNC;
		$res = CIBlock::GetList(
	    Array(), 
	    Array(
	        'TYPE'=>$_GFUNC['IB_TYPE_CODE'], 
	        'SITE_ID'=>SITE_ID, 
	        'ACTIVE'=>'Y', 
	        "CNT_ACTIVE"=>"Y", 
	        "CODE"=>$code
	    ), true
		);
		while($ar_res = $res->Fetch())
		{
		    return $ar_res['ID'];
		}
	}
	function get_ibcode_from_ibid($id){
		$res = CIBlock::GetList(
	    Array(), 
	    Array(
	        'ACTIVE'=>'Y', 
	        "CNT_ACTIVE"=>"Y", 
	        "ID"=>$id
	    ), true
		);
		while($ar_res = $res->Fetch())
		{
		    return $ar_res['CODE'];
		}
	}
	function get_first_section_id($iBlock_id){
		$arFilter = Array('IBLOCK_ID'=>$iBlock_id,
	                      'GLOBAL_ACTIVE'=>'Y'
	                      );
	    $db_list = CIBlockSection::GetList(Array($by=>$order), $arFilter, true);
	    $_sections = array();
	    while($ar_result = $db_list->GetNext())
	    {
	        $_sections[] = $ar_result['ID'];
	    }
		$_SECTION_ID = @$_sections[0];
		return $_SECTION_ID;
	}
	
	function get_element_name_by_elementId($ID){
		$res = CIBlockElement::GetByID($ID);
		if ($ar_res = $res->GetNext())
	    	return $ar_res['NAME'];
	}
	
	function get_section_name_by_sectionId($ID){
		$res = CIBlockSection::GetByID($ID);
		if ($ar_res = $res->GetNext())
		    return $ar_res['NAME'];
				
	}
	
	function get_ib_name_by_ibId($ID){
		$res = CIBlock::GetByID($ID);
		if ($ar_res = $res->GetNext()){
		  return $ar_res['NAME'];
		}	    
	}
	function get_ib_type_list(){
		$db_iblock_type = CIBlockType::GetList();
		while($ar_iblock_type = $db_iblock_type->Fetch())
		{
		   if ($arIBType = CIBlockType::GetByIDLang($ar_iblock_type["ID"], LANG))
		   {
		   	$rs[$ar_iblock_type["ID"]] = htmlspecialcharsex($arIBType["NAME"]);
		   }
		}
		return $rs;
	}
	
	function get_ib_type_id_by_ibId($ID){
		$res = CIBlock::GetByID($ID);
		if ($ar_res = $res->GetNext()){
			$iblock_type_id = $ar_res['IBLOCK_TYPE_ID'];
			return $iblock_type_id;
		}
		return null;
	}
	
	function get_ib_type_name_by_ibID($ID){
		$ibtypeid 		= CUtilities::get_ib_type_id_by_ibId($ID);
		if(strlen($ibtypeid)>0){
			$ibtype_name	= CUtilities::get_ib_type_name_by_ibtypeId($ibtypeid);
			return $ibtype_name;
		}
	}

	function get_ib_type_name_by_ibtypeId($ibtypeid){
		$rs = CUtilities::get_ib_type_list();
		if(key_exists($ibtypeid,$rs)){
			return $rs[$ibtypeid];
		}
		return null;
	}
	
	function get_ib_code_by_ibId($ID){
		$res = CIBlock::GetByID($ID);
		if ($ar_res = $res->GetNext())
		    return $ar_res['CODE'];
	}
	
	function get_ib_id_from_ibcode($code,$catalog_type){
		$res = CIBlock::GetList(
		    Array(), 
		    Array(
		        'TYPE'=>$catalog_type, 
		        'SITE_ID'=>SITE_ID, 
		        'ACTIVE'=>'Y', 
		        "CNT_ACTIVE"=>"Y", 
		        "CODE"=>$code
		    ), true
		);
		while($ar_res = $res->Fetch())
		{
		    return $ar_res['ID'];
		}
	}
	
	function get_ib_id_from_ibcode_only($code){
		$res = CIBlock::GetList(
		    Array(), 
		    Array(
		        'SITE_ID'=>SITE_ID, 
		        'ACTIVE'=>'Y', 
		        "CNT_ACTIVE"=>"Y", 
		        "CODE"=>$code
		    ), true
		);
		while($ar_res = $res->Fetch())
		{
		    return $ar_res['ID'];
		}
	}
	
	function get_ib_id_by_sectionId($sectionid){
		$res = CIBlockSection::GetByID($sectionid);
		if ($ar_res = $res->GetNext()){
			return $ar_res['IBLOCK_ID'];
		}
		return null;
	}

	function get_ib_id_from_element_id($elementid){
		$res = CIBlockElement::GetByID($elementid);
		if ($ar_res = $res->GetNext())
			return $ar_res['IBLOCK_ID'];
	}
	
	function get_properties_from_element_id($elementid,$iblock_id,$arrSelect=null,$arrFilter=null){
		$_properties = array();
		$arSelect = Array("ID");
		if(is_array($arrSelect)){
			foreach($arrSelect as $key=>$value){
				$arSelect[] = $value;
			}
		}
		$arFilter = Array("IBLOCK_ID"=>IntVal($iblock_id), 
		                  "ACTIVE_DATE"=>"Y",
						  "ID"=>IntVal($elementid),
		                  "ACTIVE"=>"Y");
		
		if(is_array($arrFilter)){
			foreach($arrFilter as $key=>$value){
				$arFilter[] = $value;
			}
		}
		
		$res = CIBlockElement::GetList(Array("SORT"=>"DESC"), $arFilter, 
		                               false, 
		                               Array("nPageSize"=>50), 
		                               $arSelect);
		while ($ob = $res->GetNextElement())
		{
		  $arFields = $ob->GetFields();
		  $_properties = $arFields;
		}
		return $_properties;
	}
	
	function get_properties_from_ib_id($ib){
		$properties = CIBlockProperty::GetList(Array("sort"=>"asc", 
		                                             "name"=>"asc"), 
		                                       Array("ACTIVE"=>"Y", 
		                                             "IBLOCK_ID"=>$ib));
		$rsResult = array();
		while($prop_fields = $properties->GetNext())
		{
			$rsResult[$prop_fields["ID"]]= array("NAME"=>$prop_fields["NAME"], "CODE"=>$prop_fields["CODE"]);
		}
		return $rsResult;
	}
	
	function get_ib_properties($iblock_id){
		$properties = CIBlockProperty::GetList(Array("sort"=>"asc", 
	                                             "name"=>"asc"), 
	                                       Array("ACTIVE"=>"Y", 
	                                             "IBLOCK_ID"=>$iblock_id));
	    $result = array();
		while($prop_fields = $properties->GetNext())
		{
		    $result[$prop_fields["CODE"]] = $prop_fields;
		}
		return $result;
	}
	
	function get_ib_properties_all($iblock_id){
		$properties = CIBlockProperty::GetList(Array("sort"=>"asc", 
	                                             "name"=>"asc"), 
	                                       Array("IBLOCK_ID"=>$iblock_id));
	    $result = array();
		while($prop_fields = $properties->GetNext())
		{
		    $result[$prop_fields["CODE"]] = $prop_fields;
		}
		return $result;
	}
	
	function get_section_id_from_element_id($elementid){
		$res = CIBlockElement::GetByID($elementid);
		if ($ar_res = $res->GetNext())
			return $ar_res['IBLOCK_SECTION_ID'];
	}
	
	function get_parent_sectionid_from_sectionid($sectionchildID){
		$res = CIBlockSection::GetByID($sectionchildID);
		if ($ar_res = $res->GetNext()){
			return $ar_res['IBLOCK_SECTION_ID'];
		}
		return null;
	}
	
	function get_sections_chain_from_sectionlast($section_last,&$rs){
		$pre_section = CUtilities::get_parent_sectionid_from_sectionid($section_last);
		if($pre_section!=null){
			$rs[]=$pre_section;
			CUtilities::get_sections_chain_from_sectionlast($pre_section,$rs);
		}
		return $rs;
	}
	
	function get_sections_chain_from_sectionid($sectionid){
		$rs[] = $sectionid;
		return CUtilities::get_sections_chain_from_sectionlast($sectionid,$rs);
	}
	
	function get_sections_chain_from_elementid($elementid){
		$first_section = CUtilities::get_section_id_from_element_id($elementid);
		$rs[] = $first_section;
		return CUtilities::get_sections_chain_from_sectionlast($first_section,$rs);
	}
	
	function get_items_from_ibId($ID,$limit = 50){
		$arSelect = Array("ID", "NAME", "DATE_ACTIVE_FROM");
		$arFilter = Array("IBLOCK_ID"=>IntVal($ID), 
		                  "ACTIVE_DATE"=>"Y", 
		                  "ACTIVE"=>"Y");
		$res = CIBlockElement::GetList(Array(), $arFilter, 
		                               false, 
		                               Array("nPageSize"=>$limit), 
		                               $arSelect);
		$arReturn = array();
		while ($ob = $res->GetNextElement())
		{
		  $arFields = $ob->GetFields();
		  $arReturn[$arFields['ID']] =$arFields['NAME']; 
		}
		return $arReturn;
	}
	
	function get_items_from_SectionId($IBLOCK_ID,$SECTION_ID,$limit = 50){
		$arSelect = Array("ID", "NAME", "DATE_ACTIVE_FROM", "IBLOCK_SECTION_ID");
		$arFilter = Array("IBLOCK_ID"=>IntVal($IBLOCK_ID), 
						"SECTION_ID"=>IntVal($SECTION_ID),
		                  "ACTIVE_DATE"=>"Y", 
		                  "ACTIVE"=>"Y");
		$res = CIBlockElement::GetList(Array(), $arFilter, 
		                               false, 
		                               Array("nPageSize"=>$limit), 
		                               $arSelect);
		$arReturn = array();
		while ($ob = $res->GetNextElement())
		{
		  $arFields = $ob->GetFields();
		  $arReturn[$arFields['ID']] =$arFields;
		}
		return $arReturn;
	}
	
	function get_sections_from_ibid_sectionid($ib,$parent_section){
		$arFilter = Array('IBLOCK_ID'=>$ib,
						  'SECTION_ID'=>$parent_section,
	                      'GLOBAL_ACTIVE'=>'Y'
	                      );
	    $db_list = CIBlockSection::GetList(Array('SORT'=>'ASC'), $arFilter, true);
	    $_sections = array();
	    while($ar_result = $db_list->GetNext())
	    {
	        $_sections[$ar_result['ID']] = $ar_result['NAME'];
	    }
	    return $_sections;
	}
	
	function get_files_in_folder($folder){
		$d = dir($_SERVER["DOCUMENT_ROOT"].$folder);
		$results = array();
		while (false !== ($entry = $d->read())) {
			if(($entry!=".")&&($entry!=".."))
		   		$results[] = $entry;
		}
		$d->close();
		return $results;
	}
	
	function clear_special_character($text){
		$text = str_replace(
	    array('\n'),
	    array(''),
	    $text);
	    return $text;
	}
	
	function get_items($iblock_id,$arrSelect=null,$arrFilter=null,$nPageSize=50,$arSort=null){
		global $USER;
		$_properties = array();
		$arSelect = Array("ID","NAME");
		if(is_array($arrSelect)){
			foreach($arrSelect as $key=>$value){
				$arSelect[] = $value;
			}
		}
		$arFilter = Array("IBLOCK_ID"=>IntVal($iblock_id), 
		                  "ACTIVE_DATE"=>"Y",
		                  "ACTIVE"=>"Y");
		
		if(is_array($arrFilter)){
			foreach($arrFilter as $key=>$value){
				$arFilter[$key] = $value;
			}
		}
		if($arSort==null){
			$arSort=Array("ID"=>"DESC");
		}
		$res = CIBlockElement::GetList($arSort, $arFilter, 
		                               false, 
		                               Array("nPageSize"=>$nPageSize), 
		                               $arSelect);
		while ($ob = $res->GetNextElement())
		{
		  if($ob){
		  	$arFields = $ob->GetFields();
		  	$_properties[$arFields['ID']] = $arFields;
		  }
		}
		return $_properties;
	}
	
	function get_item_ids($iblock_id,$arrFilter=null,$nPageSize=50,$arSort=null){
		global $USER;
		$_properties = array();
		$arSelect = Array("ID");
		$arFilter = Array("IBLOCK_ID"=>IntVal($iblock_id), 
		                  "ACTIVE_DATE"=>"Y",
		                  "ACTIVE"=>"Y");
		if(is_array($arrFilter)){
			foreach($arrFilter as $key=>$value){
				$arFilter[$key] = $value;
			}
		}
		if($arSort==null){
			$arSort=Array("ID"=>"DESC");
		}
		$res = CIBlockElement::GetList($arSort, $arFilter, 
		                               false, 
		                               Array("nPageSize"=>$nPageSize), 
		                               $arSelect);
		while ($ob = $res->GetNextElement())
		{
		  if($ob){
		  	$arFields = $ob->GetFields();
		  	$_properties[$arFields['ID']] = $arFields['ID'];
		  }
		}
		return $_properties;
	}
	
	function get_first_item($iblock_id,$arrSelect=null,$arrFilter=null){
		$items = CUtilities::get_items($iblock_id,$arrSelect,$arrFilter,1);
		if(count($items)>0){
			$item = current($items);
			return $item;
//			return $items[0];
		}
	}
	
	function get_ib_property_ids($iblock_id){
		$properties = CIBlockProperty::GetList(Array("sort"=>"asc", 
	                                             "name"=>"asc"), 
	                                       Array("ACTIVE"=>"Y", 
	                                             "IBLOCK_ID"=>$iblock_id));
	    $result = array();
		while($prop_fields = $properties->GetNext())
		{
		    $result[$prop_fields["CODE"]] = $prop_fields["ID"];
		}
		return $result;
	}
	
	function get_properties_select_array($ib){
		$props = CUtilities::get_ib_property_ids($ib);
		foreach($props as $code=>$id){
			$arSelect[]='PROPERTY_'.$code;
		} 
		return $arSelect;
	}
	
	function add_new_element($ib,$name='default',$pro_values=array(),$other_values=array()){
		$el = new CIBlockElement;
		$PROP = array();
		$PROP_IDS = CUtilities::get_ib_property_ids($ib);
		if(count($pro_values)>0){
			foreach($pro_values as $key=>$value){
					$PROP[$PROP_IDS[$key]] 	= $value;
			}
		}
		//"MODIFIED_BY"    => $USER->GetID(),
		global $USER;
		if($USER){
			$user_id = $USER->GetID();
		}else{
			$user_id = 1;
		}
		$arLoadProductArray = Array(
		  "MODIFIED_BY"    => $user_id,	
		  "IBLOCK_SECTION" => false,
		  "IBLOCK_ID"      => $ib,
		  "PROPERTY_VALUES"=> $PROP,
		  "NAME"           => $name,
		  "ACTIVE"         => "Y"
		  );
		 if(is_array($other_values)){
		 	foreach($other_values as $key=>$value){
		 		$arLoadProductArray[$key] = $value;
		 	}
		 }
		if($id=$el->Add($arLoadProductArray))
			return $id;
		else
            echo $el->LAST_ERROR;
			return false;
            
	}
	
	function update_element($ib,$element_id,$pro_values=array(),$other_values=array()){
		$el = new CIBlockElement;
		$PROP = array();
		$PROP_IDS = CUtilities::get_ib_property_ids($ib);
		if(count($pro_values)>0){
			foreach($pro_values as $key=>$value){
					$PROP[$PROP_IDS[$key]] 	= $value;
			}
		}
		//"MODIFIED_BY"    => $USER->GetID(),
		global $USER;
		if($USER){
			$user_id = $USER->GetID();
		}else{
			$user_id = 1;
		}
		$arLoadProductArray = Array(
		  "MODIFIED_BY"    => $user_id,	
		  "IBLOCK_SECTION" => false,
		  "IBLOCK_ID"      => $ib,
		  "PROPERTY_VALUES"=> $PROP,
		  "ACTIVE"         => "Y"
		  );
		 if(is_array($other_values)){
		 	foreach($other_values as $key=>$value){
		 		$arLoadProductArray[$key] = $value;
		 	}
		 }
		if($id=$el->Update($element_id,$arLoadProductArray))
			return $id;
		else
			return false;
	}

	function get_property_values_enum($IB,$ELEMENT_ID,$PROPERTY_NAME ){
		$rsElementProperties = CIBlockElement::GetProperty($IB, $ELEMENT_ID, $by="sort", $order="asc");
		$arResult["ELEMENT_PROPERTIES"] = array();

		while ($arElementProperty = $rsElementProperties->Fetch())
			{
				if(!array_key_exists($arElementProperty["ID"], $arResult["ELEMENT_PROPERTIES"]))
					$arResult["ELEMENT_PROPERTIES"][$arElementProperty["ID"]] = array();
				if(is_array($arElementProperty["VALUE"]))
				{
					$htmlvalue = array();
					foreach($arElementProperty["VALUE"] as $k => $v)
					{
						if(is_array($v))
						{
							$htmlvalue[$k] = array();
							foreach($v as $k1 => $v1)
								$htmlvalue[$k][$k1] = htmlspecialchars($v1);
						}
						else
						{
							$htmlvalue[$k] = htmlspecialchars($v);
						}
					}
				}
				else
				{
					$htmlvalue = htmlspecialchars($arElementProperty["VALUE"]);
				}

				$arResult["ELEMENT_PROPERTIES"][$arElementProperty["ID"]][] = array(
					"ID" => htmlspecialchars($arElementProperty["ID"]),
					"VALUE" => $htmlvalue,
					"~VALUE" => $arElementProperty["VALUE"],
					"VALUE_ID" => htmlspecialchars($arElementProperty["PROPERTY_VALUE_ID"]),
					"VALUE_ENUM" => htmlspecialchars($arElementProperty["VALUE_ENUM"]),
				);
			}
		$pro_keys = CUtilities::get_ib_property_ids($IB);
		$_VALUES = array();
		foreach($arResult["ELEMENT_PROPERTIES"][$pro_keys[$PROPERTY_NAME]] as $obj){
			if(strlen($obj['VALUE'])>0)
			$_VALUES[$obj['VALUE_ID']] = $obj['VALUE'];
		}
		return $_VALUES;
	}
	
	
	function get_property_id_from_property_code($property_code,$iblock_id){
		$arProps = CUtilities::get_ib_property_ids($iblock_id);
		if(array_key_exists($property_code,$arProps)){
			return $arProps[$property_code];
		}
	}
	
	function get_property_enums($IBLOCK_ID,$PROPERTY_CODE){
		$property_enums = CIBlockPropertyEnum::GetList(Array("DEF"=>"DESC", 
		                                                     "SORT"=>"ASC"), 
		                                               Array("IBLOCK_ID"=>$IBLOCK_ID, 
		                                                     "CODE"=>$PROPERTY_CODE));
		while($enum_fields = $property_enums->GetNext())
		{
			$rs[] = array('key'=>$enum_fields["ID"],'value'=>$enum_fields["VALUE"]);
		}
		return $rs;
	}
	
	function get_property_enum_key_value($IBLOCK_ID,$PROPERTY_CODE){
		$property_enums = CIBlockPropertyEnum::GetList(Array("DEF"=>"DESC", 
		                                                     "SORT"=>"ASC"), 
		                                               Array("IBLOCK_ID"=>$IBLOCK_ID, 
		                                                     "CODE"=>$PROPERTY_CODE));
		while($enum_fields = $property_enums->GetNext())
		{
			$rs[$enum_fields["ID"]] =$enum_fields["VALUE"];
		}
		return $rs;
	}
	
	function get_property_enum_xml_id($IBLOCK_ID,$PROPERTY_CODE,$STRING_VALUE){
		$enum_values = CUtilities::get_property_enum_key_value($arParams['IBLOCK_ID'],$PROPERTY_CODE);
		foreach($enum_values as $key=>$value){
			if($STRING_VALUE==$value){
				return $key;
			}
		}
		return null;
	}
	
	function getCurrentURL() {
		 $pageURL = 'http';
		 if ($_SERVER["HTTPS"] == "on") {$pageURL .= "s";}
		 $pageURL .= "://";
		 if ($_SERVER["SERVER_PORT"] != "80") {
		  $pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
		 } else {
		  $pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];
		 }
		 return $pageURL;
	}
	
	function getCurrentFile(){
		$sRealFilePath = CUtilities::getCurrentURL();
		if (strlen($sRealFilePath) > 0)
			{
				$slash_pos = strrpos($sRealFilePath, "/");
				$sFilePath = substr($sRealFilePath, 0, $slash_pos+1);
				$sFileName = substr($sRealFilePath, $slash_pos+1);
				$sFileName = substr($sFileName, 0, strlen($sFileName)-4);
				return $sFileName;
			}
		return null;
	}

	function is_empty($var, $allow_false = false, $allow_ws = false) {
	    if (!isset($var) || is_null($var) || ($allow_ws == false && trim($var) == "" && !is_bool($var)) || ($allow_false === false && is_bool($var) && $var === false) || (is_array($var) && empty($var))) {
	        return true;
	    } else {
	        return false;
	    }
	}
	
	function strip_slashes($str)
	{
	    if (get_magic_quotes_gpc()){return stripslashes($str);}
	    return $str;
	}
	
	function f_display_text($text){
		if (is_null($text)) echo "&nbsp;";
		elseif (CUtilities::is_empty($text)){
			echo "&nbsp;";
		}else 
			echo $text;
	}

	//------------------------Trungnt---------------------------------------------
	function get_record_from_element_id($element_id, $arrSelect=null, $arrFilter=null){
		$element_name = CUtilities::get_element_name_by_elementId($element_id);
		$iblock_id = CUtilities::get_ib_id_from_element_id($element_id);
		$ibname = CUtilities::get_ib_name_by_ibId($iblock_id);
		$properties = CIBlockProperty::GetList(Array("sort"=>"asc", "name"=>"asc"),  Array("ACTIVE"=>"Y", "IBLOCK_ID"=>$iblock_id));
		//$DATA_TABLE['RECORD_NAME']['NAME']='Record Name';
		//$DATA_TABLE['RECORD_NAME']['VALUE']=$element_name;
		while($prop_fields = $properties->GetNext())
		{
		    if ($arrSelect!=null){
		    	if(in_array($prop_fields['CODE'],$arrSelect)){
					$arProps[$prop_fields["CODE"]]=$prop_fields;	
				}
		    }
			else{
				$arProps[$prop_fields["CODE"]]=$prop_fields;
			}
				
		}
		$arSelect = Array("ID");
		$original = $arProps;
		if(count($arProps)>0){
			foreach($arProps as $code=>$name){
					$arSelect[] = "PROPERTY_".$code;
			}
		}
		//if($arrSelect) $arSelect = $arrSelect;
        //CDebug::dump($arSelect);
        //CDebug::dump($arProps);
		$arFilter = Array("IBLOCK_ID"=>IntVal($iblock_id),"ID"=> $element_id,"ACTIVE"=>"Y");
		$res = CIBlockElement::GetList(Array(), $arFilter, false, Array("nPageSize"=>1), $arSelect);
		while ($ob = $res->GetNextElement())
		{
		  if($ob){
		  	$arFields = $ob->GetFields();
		  	$element = $arFields;
		  }
		}
		$DATA_TABLE["ID"]["NAME"] = "Element id";
		$DATA_TABLE["ID"]["VALUE"] = $element['ID'];
		foreach($original as $code=>$property){
			$DATA_TABLE[$property['CODE']]['NAME'] = $property['NAME'];
			if($property['MULTIPLE']=='Y'){
				$prop_value = CUtilities::get_property_values_enum($iblock_id, $element_id, $property['CODE']);
				if($property['PROPERTY_TYPE']=='E'){
					foreach($prop_value as $key => $value)
					{
						$DATA_TABLE[$property['CODE']]['VALUE'][]= CUtilities::get_element_name_by_elementId($value);
                        $DATA_TABLE[$property['CODE']]['VALUE2'][] = $value;
					}
				}
				else{
					$DATA_TABLE[$property['CODE']]['VALUE'][]= $value;
				}
			}
			else{
				if($property['PROPERTY_TYPE']=='E'){
					$DATA_TABLE[$property['CODE']]['VALUE'] = CUtilities::get_element_name_by_elementId($element['PROPERTY_'.$code.'_VALUE']);
                    $DATA_TABLE[$property['CODE']]['VALUE2'] = $element['PROPERTY_'.$code.'_VALUE'];
				}
				else{
					$DATA_TABLE[$property['CODE']]['VALUE'] = $element['PROPERTY_'.$code.'_VALUE'];
				}
			}
		}
		return $DATA_TABLE;
	}	
	//--------------------Trungnt---------------------------------------------------
	function get_record_detail_from_element_id($element_id, $property_code_link){
		$iblock_id = CUtilities::get_ib_id_from_element_id($element_id);
		$res = CIBlockProperty::GetByID($property_code_link, $iblock_id);
		if($property = $res->GetNext()){
			if($property['MULTIPLE']=='Y'){
				$prop_value = CUtilities::get_property_values_enum($iblock_id, $element_id, $property['CODE']);
				foreach($prop_value as $key => $value){
					$DATA_TABLE[] = CUtilities::get_record_from_element_id($value);
				}
			}
			else{
				$prop_value = CUtilities::get_properties_from_element_id($element_id, $iblock_id,array('PROPERTY_'.$property_code_link));
				$DATA_TABLE = CUtilities::get_record_from_element_id($prop_value['PROPERTY_'.$property_code_link.'_VALUE']);
			}
		}
		return $DATA_TABLE;
	}
	//----------------------Trungnt-----------------------------------------------
	function get_list_record($iblock_id, $arrSelect=null, $arrFilter=null,$arSort=null,$nPageSize=10000){
		$arSelect = Array("ID");
		if(is_array($arrSelect)){
			foreach($arrSelect as $key=>$value){
				$arSelect[] = $value;
			}
		}
        if($iblock_id==null) return;
		$arFilter = Array(
            "IBLOCK_ID"=>IntVal($iblock_id),
            "ACTIVE"=>"Y"
        );
		//CDebug::dump($arSelect);
		$res = CIBlockElement::GetList($arSort, array_merge($arFilter,$arrFilter), false, Array("nPageSize"=>$nPageSize),$arSelect);
		while ($ob = $res->GetNextElement())
		{
		  if($ob){
		  	$arFields = $ob->GetFields();
		  	$DATA_TABLE[] = CUtilities::get_record_from_element_id($arFields['ID']);
		  }
		}
		return $DATA_TABLE;
	}
    function get_record_detail_from_element_id_master($element_id, $iblock_id_detail, $property_code_link, $arrSelect=null, $arrFilter=null){
		$arSelect = Array("ID");
		if(is_array($arrSelect)){
			foreach($arrSelect as $key=>$value){
				$arSelect[] = $value;
			}
		}
		$arFilter = Array("IBLOCK_ID"=>IntVal($iblock_id_detail),"PROPERTY_".$property_code_link => $element_id,"ACTIVE"=>"Y");
		if(is_array($arrFilter)){
			foreach($arrFilter as $key=>$value){
				$arFilter[$key] = $value;
			}
		}
		//CDebug::dump($arSelect);
		$res = CIBlockElement::GetList(Array(), $arFilter, false, Array("nPageSize"=>50),$arSelect);
		while ($ob = $res->GetNextElement())
		{
		  if($ob){
		  	$arFields = $ob->GetFields();
		  	$DATA_TABLE[] = CUtilities::get_record_from_element_id($arFields['ID']);
		  }
		}
        //CDebug::dump($DATA_TABLE);
		return $DATA_TABLE;
	}
	//----------------------Trungnt-----------------------------------------------
	function sum_by_element_id($element_id, $iblock_id_detail, $property_code_link, $arrSumFields, $arrFilter=null){
		$arSelect = Array("ID");//,$arrSumFields,"PROPERTY_ADD_FEE");
		if(is_array($arrSumFields)){
			foreach($arrSumFields as $key=>$value){
				$arSelect[] = 'PROPERTY_'.$value;
			}
		}
		//CDebug::dump($arSelect);
		$arFilter = Array("IBLOCK_ID"=>IntVal($iblock_id_detail),"PROPERTY_".$property_code_link => $element_id,"ACTIVE"=>"Y");
		if(is_array($arrFilter)){
			foreach($arrFilter as $key=>$value){
				$arFilter[$key] = $value;
			}
		}
		//$arFilter['PHIEU_ID'] = $element_id;
		$arrRecords=null;
		$arrRecords = CUtilities::get_items($iblock_id_detail, $arSelect, $arFilter, SYS_MAX_ITEM);
		//CDebug::dump($arrRecords);
		if(count($arrRecords)>0){
			$arResult['TOTAL_ELEMENT'] = count($arrRecords);
			foreach($arrSumFields as $code){
				$arResult[$code] = 0;
			}
			foreach($arrRecords as $record){
				foreach($arrSumFields as $code){
					$arResult[$code] += $record['PROPERTY_'.$code.'_VALUE'];
				}
			}
		}
		return $arResult;
	}
	//----------------------Trungnt-----------------------------------------------
	function sum_by_fields($iblock_id, $arrSumFields, $arrFilter=null){
		$arSelect = Array("ID");//,$arrSumFields,"PROPERTY_ADD_FEE");
		if(is_array($arrSumFields)){
			foreach($arrSumFields as $key=>$value){
				$arSelect[] = 'PROPERTY_'.$value;
			}
		}
		//CDebug::dump($arSelect);
		$arFilter = Array("IBLOCK_ID"=>IntVal($iblock_id),"ACTIVE"=>"Y");
		$arrRecords=null;
		$arrRecords = CUtilities::get_items($iblock_id, $arSelect, array_merge($arFilter,$arrFilter), SYS_MAX_ITEM);
		//CDebug::dump($arrRecords);
		if(count($arrRecords)>0){
			$arResult['TOTAL_ELEMENT']['NAME'] = 'Tổng số phần tử';
			$arResult['TOTAL_ELEMENT']['VALUE'] = count($arrRecords);
			foreach($arrSumFields as $key=>$code){
				$arResult[$code]['NAME'] = $key;
				$arResult[$code]['VALUE'] = 0;
			}
			foreach($arrRecords as $record){
				foreach($arrSumFields as $key=>$code){
					$arResult[$code]['VALUE'] += $record['PROPERTY_'.$code.'_VALUE'];
				}
			}
		}
		return $arResult;
	}
    //------------------------------Trungnt----------------------------------------
	function prepare_show($content){
		if(is_numeric($content)) $content = number_format($content,2);
		return $content;
	}
	//-----------------------------------------------------------------------------
	function get_ib_list($ibtype){
			$res = CIBlock::GetList(
		    Array(), 
		    Array(
		        'TYPE'=>strval($ibtype), 
		        'SITE_ID'=>SITE_ID, 
		        'ACTIVE'=>'Y', 
		        "CNT_ACTIVE"=>"Y"
		    ), true
		);
		while($ar_res = $res->Fetch())
		{
		   $ar[$ar_res['CODE']]=$ar_res['NAME'];
		}
		return $ar;
	}
	
	
	function is_exits_ib($ibtype,$ibcode){
		$ib_list = CUtilities::get_ib_list($ibtype);
		return array_key_exists($ibcode,$ib_list);
	}
	
	function is_exits_ib_type($ibtype_code){
		$ib_types = CUtilities::get_ib_type_list();
		return array_key_exists($ibtype_code,$ib_types);
	}
    
    function get_ib_properties_code_name($iblock_id){
		$properties = CIBlockProperty::GetList(Array("sort"=>"asc", 
	                                             "name"=>"asc"), 
	                                       Array("IBLOCK_ID"=>$iblock_id));
	    $result = array();
		while($prop_fields = $properties->GetNext())
		{
		    $result[$prop_fields["CODE"]] = $prop_fields['NAME'];
		}
		return $result;
	}

	/*Manh add more*/
	function remove_items($IBLOCK_ID,$FILTER){
		global $DB;
		$items = CUtilities::get_items($IBLOCK_ID,array("ID"),$FILTER);
		if(count($items)>0){
			$DB->StartTransaction();
			foreach($items as $item){
			    if(!CIBlockElement::Delete($item["ID"]))
			    {
			        $strWarning .= 'Error!';
			        $DB->Rollback();
			        return false;
			    }
			    else
			        $DB->Commit();
			}
		}
		return true;
	}
	
	function remove_item($ELEMENT_ID){
		global $DB;
		$DB->StartTransaction();
		    if(!CIBlockElement::Delete($ELEMENT_ID))
		    {
		        $strWarning .= 'Error!';
		        $DB->Rollback();
		        return false;
		    }
		    else
		        $DB->Commit();
		return true;
	}

	function get_property_value($PRODUCT_ID,$IBLOCK_ID,$PROPERTY_CODE){
		$db_props = CIBlockElement::GetProperty($IBLOCK_ID, 
	                                        $PRODUCT_ID, "sort", 
	                                        "asc", 
	                                        Array("CODE"=>$PROPERTY_CODE));
		if ($ar_props = $db_props->Fetch())
	    	$return = $ar_props["VALUE"];
		else
	    	$return = "";
	    return $return;
	}
	
	function set_property_value($ELEMENT_ID,$PROPERTY_CODE,$PROPERTY_VALUE){
		$IBLOCK_ID = CUtilities::get_ib_id_from_element_id($ELEMENT_ID);
		 CIBlockElement::SetPropertyValues($ELEMENT_ID, 
                                    $IBLOCK_ID, 
                                    $PROPERTY_VALUE, 
                                    $PROPERTY_CODE);
		return true;
	}
	function truncate_string($str,$length){
		$end_pos = $length;
		while(substr($str,$end_pos,1)!=" " && $end_pos<strlen($str))
			$end_pos++;
		if($end_pos<strlen($str))
			$str = substr($str, 0, $end_pos);
		return $str;
	}
    
    	function send_mail($mail_template,$arFields){
		/*Example*/
		/*$arFields = Array(
			"BCC" => 'manhdn@vivicorp.com',
			"EMAIL" => 'manhdn@vivicorp.com',
			"FROM_EMAIL" => 'contactn@vivicorp.com',
			"NAME"=>"Manh",
			"CONTENT"=>"ABC",
	        "SUBJECT"=>"Title"
		);
		* $mail_template = CONTACT_EMAIL
		*/
		$event = new CEvent;
		$event->Send($mail_template, SITE_ID, $arFields);
	}
    // LongNTX add
    	function get_full_properties_of_element_by_elementID($IBLOCK_ID,$ELEMENT_ID){
	$arrSelect1=array("ID","IBLOCK","NAME","PREVIEW_TEXT","PREVIEW_PICTURE","~PREVIEW_TEXT","~DETAIL_TEXT");
	$arrSelectProps=CUtilities::get_properties_code_array($IBLOCK_ID);
	$arrSelect=array_merge($arrSelect1,$arrSelectProps);
	$rsElement = CIBlockElement::GetList(array(),array("ID"=>$ELEMENT_ID), false, false, $arSelect);
	
	if($obElement = $rsElement->GetNextElement())
	{
		$arResult = $obElement->GetFields();
		if(isset($arResult["PREVIEW_PICTURE"]))
			$arResult["PREVIEW_PICTURE"] = CFile::GetFileArray($arResult["PREVIEW_PICTURE"]);
		if(isset($arResult["DETAIL_PICTURE"]))
			$arResult["DETAIL_PICTURE"] = CFile::GetFileArray($arResult["DETAIL_PICTURE"]);

		$arResult["FIELDS"] = array();
		foreach($arrSelect1 as $code)
			if(array_key_exists($code, $arResult))
				$arResult["FIELDS"][$code] = $arResult[$code];
			$arResult["PROPERTIES"] = $obElement->GetProperties();
		$arResult["DISPLAY_PROPERTIES"]=array();
		foreach($arrSelectProps as $pid)
		{
			$prop = &$arResult["PROPERTIES"][$pid];
			if((is_array($prop["VALUE"]) && count($prop["VALUE"])>0) ||
			   (!is_array($prop["VALUE"]) && strlen($prop["VALUE"])>0))
			{
				$arResult["DISPLAY_PROPERTIES"][$pid] = CIBlockFormatProperties::GetDisplayValue($arResult, $prop, "news_out");
			}
		}
	}
	$item[$ELEMENT_ID]['FIELDS']=$arResult["FIELDS"];
	$item[$ELEMENT_ID]['PROPERTIES']=$arResult["PROPERTIES"];
	$item[$ELEMENT_ID]['DISPLAY_PROPERTIES']=$arResult["DISPLAY_PROPERTIES"];
	return $item;
	}
    function get_properties_code_array($ib){
		$props = CUtilities::get_ib_property_ids($ib);
		foreach($props as $code=>$id){
			$arSelect[]=$code;
		} 
		return $arSelect;
	}
    function tinnyCode($in, $to_num = false, $pad_up = false, $passKey = null,$type_key=null)
	{
	  $index = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	  if($type_key=='NO_NUM'){
	  	$index = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";	
	  }elseif($type_key=='LOWER'){
	  	$index = "abcdefghijklmnopqrstuvwxyz";
	  }elseif($type_key=='UPPER'){
	  	$index = "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	  }
	  
	  if ($passKey !== null) {
	    // Although this function's purpose is to just make the
	    // ID short - and not so much secure,
	    // with this patch by Simon Franz (http://blog.snaky.org/)
	    // you can optionally supply a password to make it harder
	    // to calculate the corresponding numeric ID
	 
	    for ($n = 0; $n<strlen($index); $n++) {
	      $i[] = substr( $index,$n ,1);
	    }
	 
	    $passhash = hash('sha256',$passKey);
	    $passhash = (strlen($passhash) < strlen($index))
	      ? hash('sha512',$passKey)
	      : $passhash;
	 
	    for ($n=0; $n < strlen($index); $n++) {
	      $p[] =  substr($passhash, $n ,1);
	    }
	 
	    array_multisort($p,  SORT_DESC, $i);
	    $index = implode($i);
	  }
	 
	  $base  = strlen($index);
	 
	  if ($to_num) {
	    // Digital number  <<--  alphabet letter code
	    $in  = strrev($in);
	    $out = 0;
	    $len = strlen($in) - 1;
	    for ($t = 0; $t <= $len; $t++) {
	      $bcpow = pow($base, $len - $t);
	      $out   = $out + strpos($index, substr($in, $t, 1)) * $bcpow;
	    }
	 
	    if (is_numeric($pad_up)) {
	      $pad_up--;
	      if ($pad_up > 0) {
	        $out -= pow($base, $pad_up);
	      }
	    }
	    $out = sprintf('%F', $out);
	    $out = substr($out, 0, strpos($out, '.'));
	  } else {
	    // Digital number  -->>  alphabet letter code
	    if (is_numeric($pad_up)) {
	      $pad_up--;
	      if ($pad_up > 0) {
	        $in += pow($base, $pad_up);
	      }
	    }
	 
	    $out = "";
	    for ($t = floor(log($in, $base)); $t >= 0; $t--) {
	      $bcp = pow($base, $t);
	      $a   = floor($in / $bcp) % $base;
	      $out = $out . substr($index, $a, 1);
	      $in  = $in - ($a * $bcp);
	    }
	    $out = strrev($out); // reverse
	  }
	 
	  return $out;
	}
    function truncateString_($str, $len, $charset="UTF-8"){ 
        $str = html_entity_decode($str, ENT_QUOTES, $charset);    
        if(mb_strlen($str, $charset)> $len){ 
            $arr = explode(' ', $str); 
            $str = mb_substr($str, 0, $len, $charset); 
            $arrRes = explode(' ', $str); 
            $last = $arr[count($arrRes)-1]; 
            unset($arr); 
            if(strcasecmp($arrRes[count($arrRes)-1], $last))   unset($arrRes[count($arrRes)-1]); 
          return implode(' ', $arrRes)."...";    
       } 
        return $str; 
    } 
    function covert_price_format($price)
    {
        return str_replace(",",".",number_format($price));
    }
    function HTML2TEXT($Document) {
            $Rules = array ('@<script[^>]*?>.*?</script>@si', // Strip out javascript
                            '@<[\/\!]*?[^<>]*?>@si',          // Strip out HTML tags
                            '@([\r\n])[\s]+@',                // Strip out white space
                            '@&(quot|#34);@i',                // Replace HTML entities
                            '@&(amp|#38);@i',                 //   Ampersand &
                            '@&(lt|#60);@i',                  //   Less Than <
                            '@&(gt|#62);@i',                  //   Greater Than >
                            '@&(nbsp|#160);@i',               //   Non Breaking Space
                            '@&(iexcl|#161);@i',              //   Inverted Exclamation point
                            '@&(cent|#162);@i',               //   Cent 
                            '@&(pound|#163);@i',              //   Pound
                            '@&(copy|#169);@i',               //   Copyright
                            '@&(reg|#174);@i',                //   Registered
                            '@&#(d+);@e');                   // Evaluate as php
            $Replace = array ('',
                              '',
                              '',
                              '"',
                              '&',
                              '<',
                              '>',
                              ' ',
                              chr(161),
                              chr(162),
                              chr(163),
                              chr(169),
                              chr(174),
                              'chr()');
              return preg_replace($Rules, $Replace, $Document);
            }
}
?>