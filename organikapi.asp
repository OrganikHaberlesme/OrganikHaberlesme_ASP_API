<%
    '**********************************************************************************
    '* Aşağıdaki uygulama Organik API v.2 üzerinde geliştirilmiş bir uygulamadır.     *
    '* Literal yapının istediğiniz prosedürlerini bağımsız olarak kullanabilir,       *
    '* ihtiyacınıza göre gerekli şekilde uygulayabilirsiniz.                          *
    '* API hakkında bilgi almak için: http://www.organikapi.com adresini ziyaret edin.*
    '* Yazar: Özgür GÜRÇKAYA / Organik Haberleşme Teknolojileri                       *
    '* Organik Haberleşme Teknolojileri © 2017. Her hakkı saklıdır                    *
    '**********************************************************************************
	Class Organikapi
		private API_VERSION, API_URL, Q_S
		private HTTP, R_TYPE, API_RESPOND, DATA_TYPE
		private Base64Chars		
		public API_KEY, HEADER_NAME, MESSAGE, d_HEADERS, d_GROUPS, GROUPIDS, _
		GSMS, TIMEOUT, DELIVERY_TIME, TRACK_ID, REPORT_URL, IS_UNIQUE, MESSAGE_FORMAT, _
		CREDIT_BALANCE, TL_BALANCE, IS_TEST, SET_CONTENT_TYPE, TRANSACTION_IDS, _
		DELIVERY_TRACK_IDS, GSM_TRACK_IDS

		private property get set_R_TYPE(method)
			  select case method
				case "balance", "headers", "smsviaget", "groups", "blacklist"
					set_R_TYPE = "GET"
				case else
					set_R_TYPE = "POST"
			  end select
		End Property

		public property let SET_API_KEY(a_key)
			if (a_key<>"") and (not isnull(a_key)) then
				API_KEY = a_key
				API_URL= "https://organikapi.com/" & API_VERSION & API_KEY & "/"	
			end if
		End Property
		
		private property get SET_Q_S(v_key, val)
			if isnull(Q_S) then
				Q_S = v_key & "=" & cstr(val)
			else
				Q_S = Q_S & "&" & v_key & "=" & cstr(val)
			end if
		end property		
		
		private property get DYN_POST(d)
			dim data, result, target
			result = ""
			if d = "blacklistadd" or d = "blacklistremove" then
				obj = GSMS
				target = "gsms"
			else
				obj = TRANSACTION_IDS
				target = "transaction_ids"
			end if
			if vartype(obj)=8 then
				if not isnull(obj) then
					arr = split(obj, ",")
					for i=0 to ubound(arr)
						if result = "" then
							result = chr(34) & arr(i) & chr(34)
						else
							result = result & "," & chr(34) & arr(i) & chr(34)
						end if
					next
				end if
			elseif vartype(obj)=8192 then
				for i=0 to ubound(obj)
					if result = "" then
						result = chr(34) & obj(i) & chr(34)
					else
						result = result & "," & chr(34) & obj(i) & chr(34)
					end if
				next
			else
				result = ""
			end if
			data = "{""data"": {"
			data = 	data &  	"""" & target & """: [" & result & "]" 
			data = 	data &  "}" 
			data = 	data &  "}"	
			response.write DYN_POST
			DYN_POST = data			
		end property	
		
		private property get REPORT_POST
			dim data
			data = "{""data"": {"
			data = 	data &  	"""transaction_ids"": [""" & TRANSACTION_IDS & """]," 
			data = 	data &  	"""delivery_track_ids"": [""" & DELIVERY_TRACK_IDS & """]," 
			data = 	data &  	"""gsm_track_ids"": [""" & GSM_TRACK_IDS & """]" 
			data = 	data &  "}" 
			data = 	data &  "}"	
			REPORT_POST = data				
		end property
		
		private property get GROUP_POST
			dim data
			data = "{""data"": {"
			data = 	data &  	"""group_ids"": [""" & GROUPIDS & """]" 
			data = 	data &  "}" 
			data = 	data &  "}"	
			GROUP_POST = data				
		end property		
		
		private property get SENDSMS_POST
			dim data
			data = "{""data"": {"
			data = 	data &  """deliveries"": [" 
			data = 	data &   "{" 
			data = 	data &  	"""options"": {" 
			data = 	data &  	   """header"": """ & HEADER_NAME & ""","
			data = 	data &  	   """delivery_time"": """ & DELIVERY_TIME & """," 
			data = 	data &  	   """timeout"": " & TIMEOUT & "," 
			data = 	data &  	   """message_format"": " & MESSAGE_FORMAT & "," 
			data = 	data &  	   """gsm_isUnique"": " & IS_UNIQUE & "," 
			data = 	data &  	   """track_id"": """ & TRACK_ID & """," 
			data = 	data &  	   """report_url"": """ & REPORT_URL & """}," 
			data = 	data &  	"""recipients"": {" 
			data = 	data &  	   """groups"": [""" & GROUP_IDS & """]," 
			data = 	data &  	   """gsms"": [""" & GSMS & """]" 
			data = 	data &  	"}," 
			data = 	data &  	"""message"": """ & MESSAGE & """" 
			data = 	data &   "}" 
			data = 	data &  "]" 
			data = 	data &  "}" 
			data = 	data &  "}"	
			SENDSMS_POST = data			
		end property

		private property get set_API_URL(method)
			 select case method
				case "smsviaget"
					if not isnull(HEADER_NAME) then SET_Q_S "header", HEADER_NAME
					if not isnull(MESSAGE) then SET_Q_S "message", MESSAGE
					if not isnull(GROUPIDS) then SET_Q_S "groupids", GROUPIDS
					if not isnull(GSMS) then SET_Q_S "gsms", GSMS
					if not isnull(TIMEOUT) then call SET_Q_S("timeout", TIMEOUT)
					if not isnull(DELIVERY_TIME) then SET_Q_S "deliverytime", DELIVERY_TIME
					if not isnull(TRACK_ID) then SET_Q_S "track_id", TRACK_ID
					if not isnull(REPORT_URL) then SET_Q_S "report_url", REPORT_URL
					if not isnull(IS_UNIQUE) then SET_Q_S "gsm_isunique", IS_UNIQUE
					if not isnull(MESSAGE_FORMAT) then SET_Q_S "message_format", MESSAGE_FORMAT
					set_API_URL = API_URL & method & "/" & DATA_TYPE & "/?" & Q_S
				case else
					set_API_URL = API_URL & method & "/" & DATA_TYPE & "/"
			  end select		
		End Property

		private property get set_DATA_TYPE(d_type)
			if SET_CONTENT_TYPE then
				if d_type="xml" then
					response.contentType = "text/xml"
				else
					response.contentType = "application/json"
				end if
				set_DATA_TYPE = response.contentType
			else
				set_DATA_TYPE = "text/xml"
			end if
		End Property		
		            
		private sub Class_Initialize ' nesne oluşturulurken varsayılan ayarlar burada yüklenir.
			response.codepage 	= 65001
			response.charset	= "utf-8"
			API_VERSION 		= "v2/"
		end sub	

		public default function init(a_key)
			API_KEY 			= a_key
			API_URL 			= "https://organikapi.com/" & API_VERSION & API_KEY & "/"
			IS_TEST 			= false
			HEADER_NAME			= null
			MESSAGE				= null
			GROUPIDS			= null
			GSMS				= null
			TIMEOUT				= 48
			DELIVERY_TIME		= null
			TRACK_ID			= null
			REPORT_URL			= null
			IS_UNIQUE			= 1
			MESSAGE_FORMAT		= 0
			SET_CONTENT_TYPE 	= false ' API'den dönen veriyi direkt kullanmak istiyorsanız sayfanın yanıt tipinin değiştirilmemesi için bu değer false olmalı
			Q_S					= null
			Base64Chars 		=	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"			
			set init		 	= me
		end function
				
		private sub Connect_to_API(method, d_type, data)
			DATA_TYPE = d_type
			Set http = server.createobject("Microsoft.XMLHTTP")
			http.open set_R_TYPE(method) , set_API_URL(method) , false ' İstek tipinin GET ya da POST olduğu set_R_TYPE property'sinden anlaşılır.
			http.setRequestHeader "Content-Type", set_DATA_TYPE(d_type)
			http.send(data)	
			API_RESPOND = http.responseText
		end sub

		public function groups(d_type)
			Connect_to_API "groups", d_type, null
			groups = API_RESPOND
		end function
		
		public function headers(d_type)
			Connect_to_API "headers", d_type, null
			headers = API_RESPOND
		end function	

		public function balance(d_type)
			Connect_to_API "balance", d_type, null
			balance = API_RESPOND
		end function

		public function blacklist(d_type)
			Connect_to_API "blacklist", d_type, null
			blacklist = API_RESPOND
		end function

		public function smsviaget(d_type)
			Connect_to_API "smsviaget", d_type, null
			smsviaget = API_RESPOND
		end function

		public function sendsms(d_type)
			Connect_to_API "sendsms", d_type, SENDSMS_POST
			sendsms = API_RESPOND
		end function

		public function basicreport(d_type)
			Connect_to_API "basicreport", d_type, REPORT_POST
			basicreport = API_RESPOND
		end function	

		public function detailedreport(d_type)
			Connect_to_API "detailedreport", d_type, REPORT_POST
			detailedreport = API_RESPOND
		end function	

		public function groupcontent(d_type)
			Connect_to_API "groupcontent", d_type, GROUP_POST
			groupcontent = API_RESPOND
		end function

		public function blacklistadd(d_type)
			Connect_to_API "blacklistadd", d_type, DYN_POST("blacklistadd")
			blacklistadd = API_RESPOND
		end function	

		public function blacklistremove(d_type)
			Connect_to_API "blacklistremove", d_type, DYN_POST("blacklistremove")
			blacklistremove = API_RESPOND
		end function	

		public function cancelscheduledtasks(d_type)
			Connect_to_API "cancelscheduledtasks", d_type, DYN_POST("cancelscheduledtasks")
			cancelscheduledtasks = API_RESPOND
		end function			
		
		Private Function mimeencode( byVal intIn )
			If intIn >= 0 Then 
				mimeencode = Mid( Base64Chars, intIn + 1, 1 ) 
			Else 
				mimeencode = ""
			End If
		End Function
		
		public function b64( byVal strIn)
			Dim c1, c2, c3, w1, w2, w3, w4, n, strOut
			For n = 1 To Len( strIn ) Step 3
				c1 = Asc( Mid( strIn, n, 1 ) )
				c2 = Asc( Mid( strIn, n + 1, 1 ) + Chr(0) )
				c3 = Asc( Mid( strIn, n + 2, 1 ) + Chr(0) )
				w1 = Int( c1 / 4 ) : w2 = ( c1 And 3 ) * 16 + Int( c2 / 16 )
				If Len( strIn ) >= n + 1 Then 
					w3 = ( c2 And 15 ) * 4 + Int( c3 / 64 ) 
				Else 
					w3 = -1
				End If
				If Len( strIn ) >= n + 2 Then 
					w4 = c3 And 63 
				Else 
					w4 = -1
				End If
				strOut = strOut + mimeencode( w1 ) + mimeencode( w2 ) + mimeencode( w3 ) + mimeencode( w4 )
			Next
			b64 = strOut	
		end function
	end class
%>