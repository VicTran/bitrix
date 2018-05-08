<?

IncludeModuleLangFile($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/classes/general/ratings.php");

class CAllRatings
{
	// get specified rating record
	function GetByID($ID)
	{
		global $DB;
		
		$ID = intval($ID);
		$err_mess = (CRatings::err_mess())."<br>Function: GetByID<br>Line: ";
		
		if($ID<=0)
			return false;
			
		return ($DB->Query("
			SELECT 
				R.*,
				".$DB->DateToCharFunction("R.CREATED")." as CREATED,
				".$DB->DateToCharFunction("R.LAST_MODIFIED")." as LAST_MODIFIED,
				".$DB->DateToCharFunction("R.LAST_CALCULATED")." as	LAST_CALCULATED
			FROM 
				b_rating R
			WHERE 
				ID=".$ID,
			false, $err_mess.__LINE__));
	}

	// get rating record list
	function GetList($aSort=array(), $arFilter=Array())
	{
		global $DB;
		
		$arSqlSearch = Array();
		$strSqlSearch = "";
		$err_mess = (CRatings::err_mess())."<br>Function: GetList<br>Line: ";
		
		if (is_array($arFilter))
		{
			$filter_keys = array_keys($arFilter);
			for ($i=0; $i<count($filter_keys); $i++)
			{
				$val = $arFilter[$filter_keys[$i]];
				if (strlen($val)<=0 || $val=="NOT_REF") continue;
				switch(strtoupper($filter_keys[$i]))
				{
					case "ID":
						$arSqlSearch[] = GetFilterQuery("R.ID",$val,"N");
					break;
					case "ACTIVE":
						if (in_array($val, Array('Y','N')))
							$arSqlSearch[] = "R.ACTIVE = '".$val."'";
					break;
					case "CALCULATED":
						if (in_array($val, Array('Y','N','C')))
							$arSqlSearch[] = "R.CALCULATED = '".$val."'";
					break;
					case "NAME":
						$arSqlSearch[] = GetFilterQuery("R.NAME", $val);
					break;	
					case "ENTITY_ID":
						$arSqlSearch[] = GetFilterQuery("R.ENTITY_ID", $val);
					break;	
				}
			}
		}

		$sOrder = "";
		foreach($aSort as $key=>$val)
		{
			$ord = (strtoupper($val) <> "ASC"? "DESC":"ASC");
			switch (strtoupper($key))
			{
				case "ID":		$sOrder .= ", R.ID ".$ord; break;
				case "NAME":	$sOrder .= ", R.NAME ".$ord; break;
				case "CREATED":	$sOrder .= ", R.CREATED ".$ord; break;
				case "LAST_MODIFIED":	$sOrder .= ", R.LAST_MODIFIED ".$ord; break;
				case "LAST_CALCULATED":	$sOrder .= ", R.LAST_CALCULATED ".$ord; break;
				case "ACTIVE":	$sOrder .= ", R.ACTIVE ".$ord; break;
				case "STATUS":	$sOrder .= ", R.CALCULATED ".$ord; break;
				case "CALCULATED":	$sOrder .= ", R.CALCULATED ".$ord; break;
				case "CALCULATION_METHOD":	$sOrder .= ", R.CALCULATION_METHOD ".$ord; break;
				case "ENTITY_ID":	$sOrder .= ", R.ENTITY_ID ".$ord; break;
			}
		}
		
		if (strlen($sOrder)<=0)
			$sOrder = "R.ID DESC";
			
		$strSqlOrder = " ORDER BY ".TrimEx($sOrder,",");

		$strSqlSearch = GetFilterSqlSearch($arSqlSearch);
		$strSql = "
			SELECT
				R.ID, R.NAME, R.ACTIVE, R.CALCULATED, R.ENTITY_ID,
				".$DB->DateToCharFunction("R.CREATED")." CREATED,
				".$DB->DateToCharFunction("R.LAST_MODIFIED")." LAST_MODIFIED,
				".$DB->DateToCharFunction("R.LAST_CALCULATED")." LAST_CALCULATED
			FROM
				b_rating R
			WHERE
			".$strSqlSearch."
			".$strSqlOrder;
		$res = $DB->Query($strSql, false, $err_mess.__LINE__);
		
		return $res;
	}

	//Addition rating
	function Add($arFields)
	{
		global $DB;

		$err_mess = (CRatings::err_mess())."<br>Function: Add<br>Line: ";
		
		// check only general field
		if(!CRatings::__CheckFields($arFields))
			return false;
			
		$arFields_i = Array(	
			"ACTIVE"				=> $arFields["ACTIVE"] == 'Y' ? 'Y' : 'N',
			"NAME"					=> $arFields["NAME"],
			"ENTITY_ID"		 		=> $arFields["ENTITY_ID"],
			"CALCULATION_METHOD"	=> $arFields["CALCULATION_METHOD"],
			"~CREATED"				=> $DB->GetNowFunction(),
			"~LAST_MODIFIED"		=> $DB->GetNowFunction(),
		);		
		$ID = $DB->Add("b_rating", $arFields_i);
		
		// queries modules and give them to inspect the field settings
		$db_events = GetModuleEvents("main", "OnAfterAddRating");
		while($arEvent = $db_events->Fetch()) 
			$arFields = ExecuteModuleEventEx($arEvent, array($ID, $arFields));

		CRatings::__AddComponents($ID, $arFields);
		
		$arFields_u = Array(	
			"CONFIGS" => "'".serialize($arFields["CONFIGS"])."'",
		);	
		
		$DB->Update("b_rating", $arFields_u, "WHERE ID = ".$ID);

		CAgent::AddAgent("CRatings::Calculate($ID);", "main", "N", 3600, "", "Y", "");
		
		return $ID;
	}

	//Update rating
	function Update($ID, $arFields)
	{
		global $DB;
		
		$ID = intval($ID);
		$err_mess = (CRatings::err_mess())."<br>Function: Update<br>Line: ";
		
		// check only general field
		if(!CRatings::__CheckFields($arFields))
			return false;

		$arFields_u = Array(	
			"ACTIVE"				=> $arFields['ACTIVE'] == 'Y' ? 'Y' : 'N',
			"NAME"					=> $arFields["NAME"],
			"ENTITY_ID"		 		=> $arFields["ENTITY_ID"],
			"CALCULATION_METHOD"	=> $arFields["CALCULATION_METHOD"],			
			"CALCULATED"			=> 'N',
			"~LAST_MODIFIED"		=> $DB->GetNowFunction(),
		);	
		$strUpdate = $DB->PrepareUpdate("b_rating", $arFields_u);
		if($strUpdate!="")
		{
			$strSql = "UPDATE b_rating SET ".$strUpdate." WHERE ID=".$ID;
			if(!$DB->Query($strSql, false, $err_mess.__LINE__))
				return false;
		}
		// queries modules and give them to inspect the field settings
		$db_events = GetModuleEvents("main", "OnAfterUpdateRating");
		while($arEvent = $db_events->Fetch()) 
			$arFields = ExecuteModuleEventEx($arEvent, array($ID, $arFields));

		CRatings::__UpdateComponents($ID, $arFields);
			
		$arFields_u = Array(	
			"CONFIGS" => "'".serialize($arFields["CONFIGS"])."'",
		);	
		
		$DB->Update("b_rating", $arFields_u, "WHERE ID = ".$ID);
		
		if ($arFields['NEW_CALC'] == 'Y')
		{
			$strSql = "
				UPDATE 
					b_rating_results 
				SET 
					PREVIOUS_VALUE = 0 
				WHERE 
					RATING_ID=".$ID." 
				and ENTITY_TYPE_ID='".$DB->ForSql($arFields["ENTITY_ID"])."'";
			$DB->Query($strSql, false, $err_mess.__LINE__);
		}
		
		$strSql = "SELECT COMPLEX_NAME FROM b_rating_component WHERE RATING_ID = $ID and ACTIVE = 'N'";
		$res = $DB->Query($strSql, false, $err_mess.__LINE__);
		$arrRatingComponentId = array();
		while($arRes = $res->Fetch())
			$arrRatingComponentId[] = $arRes['COMPLEX_NAME'];
			
		if (!empty($arrRatingComponentId))
			$DB->Query("DELETE FROM b_rating_component_results WHERE RATING_ID = $ID AND COMPLEX_NAME IN ('".implode('\',\'', $arrRatingComponentId)."')", false, $err_mess.__LINE__);
		
		CRatings::Calculate($ID, true);
		
		CAgent::RemoveAgent("CRatings::Calculate($ID);", "main");
		$AID = CAgent::AddAgent("CRatings::Calculate($ID);", "main", "N", 3600, "", "Y", "");

		return true;
	}

	// delete rating
	function Delete($ID)
	{
		global $DB;
		
		$ID = intval($ID);
		$err_mess = (CRatings::err_mess())."<br>Function: Delete<br>Line: ";
		
		$db_events = GetModuleEvents("main", "OnBeforeDeleteRating");
		while($arEvent = $db_events->Fetch()) 
			ExecuteModuleEventEx($arEvent, array($ID));
			
		$DB->Query("DELETE FROM b_rating WHERE ID=$ID", false, $err_mess.__LINE__);
		$DB->Query("DELETE FROM b_rating_component WHERE RATING_ID=$ID", false, $err_mess.__LINE__);
		$DB->Query("DELETE FROM b_rating_component_results WHERE RATING_ID=$ID", false, $err_mess.__LINE__);
		$DB->Query("DELETE FROM b_rating_results WHERE RATING_ID=$ID", false, $err_mess.__LINE__);
		
		CAgent::RemoveAgent("CRatings::Calculate($ID);", "main");
		
		return true;
	}
	
	// start calculation rating-component
	function Calculate($ID, $bForceRecalc = false)
	{
		global $DB;
		
		$ID = intval($ID);
		$err_mess = (CRatings::err_mess())."<br>Function: Calculate<br>Line: ";
		
		$strSql = "SELECT 
						RC.*,
						".$DB->DateToCharFunction("RC.LAST_MODIFIED")."	LAST_MODIFIED,
						".$DB->DateToCharFunction("RC.LAST_CALCULATED")." LAST_CALCULATED,
						".$DB->DateToCharFunction("RC.NEXT_CALCULATION")." NEXT_CALCULATION
				  FROM 
				  		b_rating_component RC
				  WHERE 
				  		RATING_ID = $ID
				  	and ACTIVE = 'Y' ".($bForceRecalc ? '' : 'AND NEXT_CALCULATION <= '.$DB->GetNowFunction());
		$res = $DB->Query($strSql, false, $err_mess.__LINE__);
		while($arRes = $res->Fetch())
		{
			if(CModule::IncludeModule(strtolower($arRes['MODULE_ID']))) {
				$arRes['CONFIG'] = unserialize($arRes['CONFIG']);
				if (strlen($arRes['EXCEPTION_METHOD']) > 0)
				{
					if (method_exists($arRes['CLASS'], $arRes['EXCEPTION_METHOD']))
					{
						$exceptionText = call_user_func(array($arRes['CLASS'], $arRes['EXCEPTION_METHOD']));
						if ($exceptionText === false) 
							$result = call_user_func(array($arRes['CLASS'], $arRes['CALC_METHOD']), $arRes);
					}
				} 
				else
				{
					if (method_exists($arRes['CLASS'],  $arRes['CALC_METHOD']))
						$result = call_user_func(array($arRes['CLASS'], $arRes['CALC_METHOD']), $arRes);
				}
			}
		}	
				
		CRatings::BuildRating($ID);
		
		return "CRatings::Calculate($ID);";
	}
	
	// building rating on computed components
	function BuildRating($ID) 
	{
		global $DB;
		
		$ID = intval($ID);
		$err_mess = (CRatings::err_mess())."<br>Function: BuildRating<br>Line: ";
		
		$resRating = CRatings::GetByID($ID);
		$arRating = $resRating->Fetch();
		if ($arRating && $arRating['ACTIVE'] == 'Y') {
			$DB->Query("UPDATE b_rating SET CALCULATED = 'C' WHERE id = ".$ID, false, $err_mess.__LINE__);
	
			$arRating['CONFIGS'] = unserialize($arRating['CONFIGS']);
			// Sum rating-components 
			$sqlFunc = ($arRating['CALCULATION_METHOD'] == 'SUM') ? 'SUM' : 'AVG';
			$strSql  = "
				SELECT 
					ENTITY_TYPE_ID, 
					ENTITY_ID, 
					".$sqlFunc."(CURRENT_VALUE) as CURRENT_VALUE
				FROM 
					b_rating_component_results RC
				WHERE 
					RATING_ID = $ID 
				and ENTITY_TYPE_ID = '".$arRating['ENTITY_ID']."'
				GROUP 
					BY ENTITY_ID, ENTITY_TYPE_ID";
			$res = $DB->Query($strSql, false, $err_mess.__LINE__);
			$arNewRating = array();
			$arNewEntityId = array();
			while($arRes = $res->Fetch())
			{
				$arNewRating[$arRes['ENTITY_ID']] = $arRes;
				$arNewEntityId[] = $arRes['ENTITY_ID'];
			}
			
			// get result of previous rating
			$strSql  = "
				SELECT 
					RR.ENTITY_TYPE_ID, 
					RR.ENTITY_ID, 
					RR.PREVIOUS_VALUE, 
					RR.CURRENT_VALUE
				FROM 
					b_rating_results RR
				WHERE 
					RR.RATING_ID = '".$ID."'
				and RR.ENTITY_TYPE_ID = '".$arRating['ENTITY_ID']."'
				GROUP 
					BY RR.ENTITY_ID, ENTITY_TYPE_ID, PREVIOUS_VALUE, CURRENT_VALUE";
			$res = $DB->Query($strSql, false, $err_mess.__LINE__);
			$arOldRating = array();
			$arOldEntityId = array();
			while($arRes = $res->Fetch())
			{
				$arOldRating[$arRes['ENTITY_ID']] = $arRes;
				$arOldEntityId[] = $arRes['ENTITY_ID'];
			}

			// find out what records the rating will need to add, only for with past rating value equal to current
			$arInsertId		= array_diff($arNewEntityId, $arOldEntityId);
			$arUpdateId		= array_intersect($arNewEntityId, $arOldEntityId);
			$arOutRatingId  = array_diff($arOldEntityId, $arNewEntityId);
			
			$arInsertResult = array();
			foreach($arInsertId as $entityId)
			{
				
				$arInsertResult[] = array(
					'RATING_ID'		 => $ID,
					'ENTITY_TYPE_ID' => $arRating['ENTITY_ID'],
					'ENTITY_ID' 	 => $entityId,
					'CURRENT_VALUE'  => $arNewRating[$entityId]['CURRENT_VALUE'],
					'PREVIOUS_VALUE' => 0,
				);
			}
			CRatings::AddResults($arInsertResult);		
			
			// update existing record rating, only for with past rating value equal to current
			foreach ($arUpdateId as $entityId)
			{
				if ($arNewRating[$entityId]['CURRENT_VALUE'] != $arOldRating[$entityId]['CURRENT_VALUE']) 
				{
					$strSql  = "
						UPDATE 
							b_rating_results 
						SET 
							CURRENT_VALUE = '".$arNewRating[$entityId]['CURRENT_VALUE']."', 
							PREVIOUS_VALUE = ".$arOldRating[$entityId]['CURRENT_VALUE']." 
						WHERE 
							RATING_ID = '".$ID."' 
						and ENTITY_TYPE_ID = '".$arRating['ENTITY_ID']."' 
						and ENTITY_ID = '".$entityId."'";
					$DB->Query($strSql, false, $err_mess.__LINE__);
				}
			}
			
			// reset value for non-existent record in new rankings, only for with past rating value equal to current
			foreach ($arOutRatingId as $entityId)
			{
				if ($arOldRating[$entityId]['CURRENT_VALUE'] != 0) 
				{
					$strSql  = "
						UPDATE 
							b_rating_results 
						SET 
							CURRENT_VALUE = '0', 
							PREVIOUS_VALUE = ".$arOldRating[$entityId]['CURRENT_VALUE']." 
						WHERE 
							RATING_ID = '".$ID."' 
						and ENTITY_TYPE_ID = '".$arRating['ENTITY_ID']."' 
						and ENTITY_ID = '".$entityId."'";
					$DB->Query($strSql, false, $err_mess.__LINE__);
				}
			}
			
			$DB->Query("UPDATE b_rating SET CALCULATED = 'Y', LAST_CALCULATED = ".$DB->GetNowFunction()." WHERE id = ".$ID, false, $err_mess.__LINE__);
		}
		return true;
	}
	
	// queries modules and get all the available objects
	function GetRatingObjects()
	{
		$arObjects = array();
		
		$db_events = GetModuleEvents("main", "OnGetRatingsObjects");
		while($arEvent = $db_events->Fetch()) 
		{
			$arConfig = ExecuteModuleEventEx($arEvent);
			foreach ($arConfig as $OBJ_TYPE)
				if (!in_array($OBJ_TYPE, $arObjects)) 
					$arObjects[] = $OBJ_TYPE;
		}
		return $arObjects;
	}
	
	// queries modules and get all the available entity types
	function GetRatingEntityTypes($objectType = null)
	{
		$arEntityTypes = array();
		
		$db_events = GetModuleEvents("main", "OnGetRatingsConfigs");
		while($arEvent = $db_events->Fetch()) 
		{
			$arConfig = ExecuteModuleEventEx($arEvent);
			if (is_null($objectType)) 
			{
				foreach ($arConfig as $OBJ_TYPE => $OBJ_VALUE)
					foreach ($OBJ_VALUE['VOTE'] as $VOTE_VALUE)
					{
						$EntityTypeId = $VOTE_VALUE['MODULE_ID'].'_'.$VOTE_VALUE['ID'];
						if (!in_array($arEntityTypes[$OBJ_TYPE], $EntityTypeId)) 
							$arEntityTypes[$OBJ_TYPE][] = $EntityTypeId; 
					}
			}
			else 
			{
				foreach ($arConfig[$objectType]['VOTE'] as $VOTE_VALUE) 
				{
					$EntityTypeId = $VOTE_VALUE['MODULE_ID'].'_'.$VOTE_VALUE['ID'];
					$arEntityTypes[$EntityTypeId] = $EntityTypeId; 
				}
			}
		}
		
		return $arEntityTypes;
	}
	
	// queries modules and assemble an array of settings
	function GetRatingConfigs($objectType = null, $withRatingType = true)
	{
		$arConfigs = array();
	
		$db_events = GetModuleEvents("main", "OnGetRatingsConfigs");
		while($arEvent = $db_events->Fetch()) 
		{
			$arConfig = ExecuteModuleEventEx($arEvent);
			if (is_null($objectType)) 
			{
				foreach ($arConfig["COMPONENT"] as $OBJ_TYPE => $TYPE_VALUE)
					foreach ($TYPE_VALUE as $RAT_TYPE => $RAT_VALUE)
					   foreach ($RAT_VALUE as $VALUE)
					   		if ($withRatingType)
					   			$arConfigs[$OBJ_TYPE][$arConfig['MODULE_ID']][$RAT_TYPE][$arConfig['MODULE_ID']."_".$RAT_TYPE."_".$VALUE['ID']] = $VALUE;
					   		else
					   			$arConfigs[$OBJ_TYPE][$arConfig['MODULE_ID']][$arConfig['MODULE_ID']."_".$RAT_TYPE."_".$VALUE['ID']] = $VALUE; 
			}
			else 
			{
				foreach ($arConfig["COMPONENT"][$objectType] as $RAT_TYPE => $RAT_VALUE)
				{
					$arConfigs[$arConfig['MODULE_ID']]['MODULE_ID'] = $arConfig['MODULE_ID'];
					$arConfigs[$arConfig['MODULE_ID']]['MODULE_NAME'] = $arConfig['MODULE_NAME'];
					foreach ($RAT_VALUE as $VALUE)
						if ($withRatingType)
							$arConfigs[$arConfig['MODULE_ID']][$RAT_TYPE][$arConfig['MODULE_ID']."_".$RAT_TYPE."_".$VALUE['ID']] = $VALUE;
						else
							$arConfigs[$arConfig['MODULE_ID']][$arConfig['MODULE_ID']."_".$RAT_TYPE."_".$VALUE['ID']] = $VALUE;
				}
			}
		}

		return $arConfigs;
	}	
	
	
	function GetRatingVoteResult($arEntityTypeId, $entityId, $user_id = false)
	{
		global $DB;
		$arResults = array();
		$arVotingIds = array();
		$arVotingEntityIds = array();
		$sqlEntityId = "";
		$bReturnEntityArray = true;
		$user_id = intval($user_id);
		if ($user_id == 0)
			$user_id = $GLOBALS["USER"]->GetID();
		
		$err_mess = (CRatings::err_mess())."<br>Function: GetRatingVoteResult<br>Line: ";
			
		if (empty($entityId))
			return $arRating;
		
		if (is_array($entityId)) 
		{
			foreach ($entityId as $key=>$value)
				$entityId[$key] = IntVal($value);			
			$sqlEntityId = " AND ENTITY_ID IN (".implode(',', $entityId).") ";
			$bReturnEntityArray = true;
		} 
		else 
		{
			$sqlEntityId = " AND ENTITY_ID = ".$entityId;
			$bReturnEntityArray = false;
		}
		
		$sql_str = "SELECT 
						ID, 
						ENTITY_ID, 
						TOTAL_VALUE, 
						TOTAL_VOTES, 
						TOTAL_POSITIVE_VOTES, 
						TOTAL_NEGATIVE_VOTES
					FROM 
						b_rating_voting
					WHERE 
						ENTITY_TYPE_ID = '".$DB->ForSql($arEntityTypeId)."' ".$sqlEntityId."
					and ACTIVE = 'Y'";
		$z = $DB->Query($sql_str, false, $err_mess.__LINE__);
		while($r = $z->Fetch())
		{
			$arVotingIds[] = $r['ID'];
			$arVotingEntityIds[$r['ID']] = $r['ENTITY_ID'];
			
			$arResult = array(
				'USER_HAS_VOTED' => "N",
				'TOTAL_VALUE' => $r['TOTAL_VALUE'],
				'TOTAL_VOTES' => $r['TOTAL_VOTES'],
				'TOTAL_POSITIVE_VOTES' => $r['TOTAL_POSITIVE_VOTES'],
				'TOTAL_NEGATIVE_VOTES' => $r['TOTAL_NEGATIVE_VOTES'],
			);
			if ($bReturnEntityArray)
				$arResults[$r['ENTITY_ID']] = $arResult;
			else
			    $arResults = $arResult;
		}
		
		if (!empty($arVotingIds) && IntVal($user_id) > 0) 
		{
			$sql_str = "SELECT RATING_VOTING_ID FROM b_rating_vote WHERE RATING_VOTING_ID IN (".implode(',', $arVotingIds).") AND USER_ID = ".$user_id;	
			$z = $DB->Query($sql_str, false, $err_mess.__LINE__);
			while($r = $z->Fetch())
			{
				if ($bReturnEntityArray)
					$arResults[$arVotingEntityIds[$r['RATING_VOTING_ID']]]['USER_HAS_VOTED'] = "Y";
				else
			    	$arResults['USER_HAS_VOTED'] = "Y";
				
			}	
		}
		
		return $arResults;
	}
	
	function GetRatingResult($ID, $entityId)
	{
		global $DB;
		$ID = IntVal($ID);
		
		$arRating = array();
		$sqlEntityId = "";
		$bReturnEntityArray = true;
		
		if (empty($entityId))
			return $arRating;
			
		if (is_array($entityId)) 
		{
			foreach ($entityId as $key=>$value)
				$entityId[$key] = IntVal($value);			
			$sqlEntityId = " AND ENTITY_ID IN (".implode(',', $entityId).") ";
			$bReturnEntityArray = true;
		} 
		else 
		{
			$sqlEntityId = " AND ENTITY_ID = ".$entityId;
			$bReturnEntityArray = false;
		}
		
		// get data on the previous counted rating
		$strSql  = "
			SELECT ENTITY_TYPE_ID, ENTITY_ID, PREVIOUS_VALUE, CURRENT_VALUE
			FROM b_rating_results
			WHERE RATING_ID = '".$ID."' ".$sqlEntityId
		;
		$res = $DB->Query($strSql, false, $err_mess.__LINE__);
		
		while($arRes = $res->Fetch())
		{
			if ($bReturnEntityArray)
				$arRating[$arRes['ENTITY_ID']] = $arRes;
			else
			    $arRating = $arRes;
		}
			
		return $arRating;
	}
	

	function AddRatingVote($arParam)
	{
		global $DB;
		$err_mess = (CRatings::err_mess())."<br>Function: AddRatingVote<br>Line: ";
		$votePlus = $arParam['VALUE'] < 0 ? false : true;
		
		$arFields = array(
			'ACTIVE' => "'Y'",
			'TOTAL_VOTES' => "TOTAL_VOTES+1",
			'TOTAL_VALUE' => "TOTAL_VALUE".($votePlus ? '+' : '').intval($arParam['VALUE']),
			'LAST_CALCULATED' => $DB->GetNowFunction(),
		);
		$arFields[($votePlus ? 'TOTAL_POSITIVE_VOTES' : 'TOTAL_NEGATIVE_VOTES')] = ($votePlus ? 'TOTAL_POSITIVE_VOTES+1' : 'TOTAL_NEGATIVE_VOTES+1');
		
		$rowAffected = $DB->Update("b_rating_voting", $arFields, "WHERE ENTITY_TYPE_ID='".$DB->ForSql($arParam['ENTITY_TYPE_ID'])."' AND ENTITY_ID='".intval($arParam['ENTITY_ID'])."'" , $err_mess.__LINE__);
        if ($rowAffected > 0) 
        {
			$rsRV = $DB->Query("SELECT ID FROM b_rating_voting WHERE ENTITY_TYPE_ID='".$DB->ForSql($arParam['ENTITY_TYPE_ID'])."' AND ENTITY_ID='".intval($arParam['ENTITY_ID'])."'", false, $err_mess.__LINE__);
			$arRV = $rsRV->Fetch();
			$votingId = $arRV['ID'];
        } 
        else 
        {
			$arFields = array(
				"ENTITY_TYPE_ID"		=> "'".$DB->ForSql($arParam["ENTITY_TYPE_ID"])."'",
				"ENTITY_ID"				=> intval($arParam['ENTITY_ID']),
				"ACTIVE"				=> "'Y'",
				"CREATED"				=> $DB->GetNowFunction(),
				"LAST_CALCULATED"		=> $DB->GetNowFunction(),
				"TOTAL_VOTES"			=> 1,
				"TOTAL_VALUE"			=> intval($arParam['VALUE']),
				"TOTAL_POSITIVE_VOTES"	=> ($votePlus ? 1 : 0),
				"TOTAL_NEGATIVE_VOTES"	=> ($votePlus ? 0 : 1)
			);
			$votingId = $DB->Insert("b_rating_voting", $arFields, $err_mess.__LINE__);	
        }
		
	    $arFields = array(
			"RATING_VOTING_ID"	=> $votingId,
			"VALUE"				=> intval($arParam['VALUE']),
			"ACTIVE"			=> "'Y'",
			"CREATED"			=> $DB->GetNowFunction(),
			"USER_ID"			=> intval($arParam['USER_ID']),
			"USER_IP"			=> "'".$DB->ForSql($arParam["USER_IP"])."'"
		);
		$DB->Insert("b_rating_vote", $arFields, $err_mess.__LINE__);	
		
		return true;
	}
	
	// check only general field
	function __CheckFields($arFields) 
	{
		$aMsg = array();
		
		if(is_set($arFields, "NAME") && trim($arFields["NAME"])=="")
			$aMsg[] = array("id"=>"NAME", "text"=>GetMessage("RATING_GENERAL_ERR_NAME"));
		if(is_set($arFields, "ACTIVE") && !($arFields["ACTIVE"] == 'Y' || $arFields["ACTIVE"] == 'N'))
			$aMsg[] = array("id"=>"ACTIVE", "text"=>GetMessage("RATING_GENERAL_ERR_ACTIVE"));
		if(is_set($arFields, "ENTITY_ID"))
		{
			$arObjects = CRatings::GetRatingObjects();
			if(!in_array($arFields['ENTITY_ID'], $arObjects))
				$aMsg[] = array("id"=>"ENTITY_ID", "text"=>GetMessage("RATING_GENERAL_ERR_ENTITY_ID"));
		}
		if(is_set($arFields, "CALCULATION_METHOD") && trim($arFields["CALCULATION_METHOD"])=="")
			$aMsg[] = array("id"=>"CALCULATION_METHOD", "text"=>GetMessage("RATING_GENERAL_ERR_CAL_METHOD"));

		if(!empty($aMsg))
		{
			$e = new CAdminException($aMsg);
			$GLOBALS["APPLICATION"]->ThrowException($e);
			return false;
		}
		
		return true;
	}	
	
	// creates a configuration record for each item rating
	function __AddComponents($ID, $arFields)
	{	
		global $DB;
		
		$arRatingConfigs = CRatings::GetRatingConfigs($arFields["ENTITY_ID"], false);		

		$ID = intval($ID);
		$err_mess = (CRatings::err_mess())."<br>Function: __AddComponents<br>Line: ";
		foreach ($arFields['CONFIGS'] as $MODULE_ID => $RAT_ARRAY)
			foreach ($RAT_ARRAY as $RAT_TYPE => $COMPONENT)
				foreach ($COMPONENT as $COMPONENT_NAME => $COMPONENT_VALUE) 
				{		
					$arFields_i = Array(	
						"RATING_ID"			=> $ID,
						"ACTIVE"			=> isset($COMPONENT_VALUE["ACTIVE"]) && $COMPONENT_VALUE["ACTIVE"] == 'Y' ? 'Y' : 'N',
						"ENTITY_ID"			=> $arFields["ENTITY_ID"],
						"MODULE_ID"			=> $MODULE_ID,
						"RATING_TYPE"		=> $RAT_TYPE,
						"NAME"				=> $COMPONENT_NAME,
						"COMPLEX_NAME"		=> $arFields["ENTITY_ID"].'_'.$MODULE_ID.'_'.$RAT_TYPE.'_'.$COMPONENT_NAME,
						"CLASS"				=> $arRatingConfigs[$MODULE_ID][$MODULE_ID."_".$RAT_TYPE."_".$COMPONENT_NAME]["CLASS"],
						"CALC_METHOD"		=> $arRatingConfigs[$MODULE_ID][$MODULE_ID."_".$RAT_TYPE."_".$COMPONENT_NAME]["CALC_METHOD"],
						"EXCEPTION_METHOD"	=> $arRatingConfigs[$MODULE_ID][$MODULE_ID."_".$RAT_TYPE."_".$COMPONENT_NAME]["EXCEPTION_METHOD"],
						"REFRESH_INTERVAL"	=> $arRatingConfigs[$MODULE_ID][$MODULE_ID."_".$RAT_TYPE."_".$COMPONENT_NAME]["REFRESH_TIME"],
						"~LAST_MODIFIED"	=> $DB->GetNowFunction(),
					    "~NEXT_CALCULATION" => $DB->GetNowFunction(),
						"IS_CALCULATED"		=> "N",
						"~CONFIG"			=> "'".serialize($COMPONENT_VALUE)."'",
					);	
					
					$DB->Add("b_rating_component", $arFields_i, array(), "", false, $err_mess.__LINE__);
				}


		return true;
	}
	 
	function __UpdateComponents($ID, $arFields)
	{	
		global $DB;
		
		$ID = intval($ID);
		$err_mess = (CRatings::err_mess())."<br>Function: __UpdateComponents<br>Line: ";
		
		$DB->Query("DELETE FROM b_rating_component WHERE RATING_ID=$ID", false, $err_mess.__LINE__);
		
		CRatings::__AddComponents($ID, $arFields, $arConfigs);
		
		return true;
	}
	
	function err_mess()
	{
		return "<br>Class: CRatings<br>File: ".__FILE__;
	}
}
?>