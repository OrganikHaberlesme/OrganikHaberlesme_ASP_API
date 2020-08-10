<!--#include file="organikapi.asp"-->
<%
	LUTFEN_OKUYUN = "Bu uygulama Organik API v.2 için geliştirilmiştir. Diğer versiyonlarla uyumluluğu yoktur."
	LUTFEN_OKUYUN = "Organik API ASP kütüphanesinin kullanılabilmesi için 1. satırdaki organikapi.asp sayfasının incluedilmiş olması gerekir."
	LUTFEN_OKUYUN = "Aşağıdaki uygualam basit bir anlatım için querystring ile çalışacak şekilde ayarlanmıştır. Kendi algoritmanıza göre kütüphanenin istediğiniz metodunu kullanabilirsiniz."	
	
	dim d
	LUTFEN_OKUYUN = "d değişkeni query string ile gelen 'd' değerine eşitlenir. d, data'yı temsil eder. Kütüphanenin size hangi veri tipiyle dönüş yapmasını istiyorsanız burada belirtirsiniz. json ve xml değerlerini alabilir."
	
	LUTFEN_OKUYUN = "Kendi uygulamanızda bu değer olmayacağı için siz manuel olarak bu değeri yazabilirsiniz, örneğin:"
	'   oapi.headers("json")
	'   oapi.groups("xml")
	if not isnull(request.querystring("d")) then 
		d = request.querystring("d") ' 
	else
		d = "json" ' bu uygulama için varsayılan dönüş tipi json olarak ayarlanmıştır.
	end if
	
	dim p
	LUTFEN_OKUYUN = "p değişkeni query string ile gelen 'p' değerine eşitlenir. p, process'i temsil eder. Kütüphanenin çalıştırmak istediğiniz metodu bununla belirlenir."
	LUTFEN_OKUYUN = "Bu yapı, örnek olması için geliştirilmiştir. Siz kendi uygulamanızda metotları direkt yazarak çalıştırabilirsiniz. Örneğin: "
	'   oapi.blacklist("json")	
	'   oapi.balance("json")	

	if not isnull(request.querystring("p")) then
		p = request.querystring("p")
	else
		p = "groups" ' bu uygulama için varsayılan işlem tipi rehber gruplarını getirme olarak ayarlanmıştır.
	end if	
	
	LUTFEN_OKUYUN = "Bu uygulamanın query stringlere bağlı olarak çalışabileceği değerler: "
	
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=groups&d=json" ' JSON formatında grup verilerini alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=groups&d=xml"  ' XML formatında grup verilerini almadsdsffd
	
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=groupcontent&d=json" ' JSON formatında rehber grubu kişilerini alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=groupcontent&d=xml" ' XML formatında rehber grubu kişilerini alma
	
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=headers&d=json" ' JSON formatında başlık verilerini alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=headers&d=xml" ' XML formatında başlık verilerini alma
	
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=balance&d=json" ' JSON formatında bakiye verilerini alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=balance&d=xml" ' XML formatında bakiye verilerini alma
	
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=blacklist&d=json" ' JSON formatında kara liste verilerini alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=blacklist&d=xml" ' XML formatında kara liste verilerini alma

	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=blacklistadd&d=json" ' Kara listeye kayıt ekeyerek cevabı JSON olarak alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=blacklistadd&d=xml" ' Kara listeye kayıt ekeyerek cevabı XML olarak alma

	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=blacklistremove&d=json" ' Kara listeden kayıt silerek cevabı JSON olarak alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=blacklistremove&d=xml" '  Kara listeden kayıt silerek cevabı JSON olarak alma

	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=sendsms&d=json" ' POST ile SMS göndererek cevabı JSON olarak alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=sendsms&d=xml" ' POST ile SMS göndererek cevabı XML olarak alma

	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=smsviaget&d=json" ' GET ile SMS göndererek cevabı JSON olarak alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=smsviaget&d=xml" ' GET ile SMS göndererek cevabı XML olarak alma
	

	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=basicreport&d=json" ' JSON formatında basit rapor alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=basicreport&d=xml" ' XML formatında basit rapor alma
	
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=detailedreport&d=json" ' JSON formatında detaylı rapor alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=detailedreport&d=xml" ' XML formatında detaylı rapor alma	
	
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=cancelscheduledtasks&d=json" ' İleri tarihli gönderimi iptal ederek yanıtı JSON olarak alma
	LUTFEN_OKUYUN = "http://localhost/organikapi/oapi.asp?p=cancelscheduledtasks&d=xml" ' İleri tarihli gönderimi iptal ederek yanıtı XML olarak alma
	
	dim oapi
	set oapi = new Organikapi.init("4d652ee2afc95cae324c294fce2ff8af") ' nesne bu şekilde de create edilebilir. Gönderilen parmetre API_KEY değeridir. Bu anahtar Organik API test kuıllanıcısının anahtarıdır. kendi anahtarınızla değiştirmeniz gerekir.	
	
	'organik api nesnesinin aşağıdaki syntax'ları kullanarak da oluşturabilirsiniz.
	'-----------------------------------------------------------------
	'set oapi = (new Organikapi)("4d652ee2afc95cae324c294fce2ff8af") 
	'-----------------------------------------------------------------
	'set oapi = new Organikapi.init(null)
	'oapi.SET_API_KEY = "4d652ee2afc95cae324c294fce2ff8af"
	'-----------------------------------------------------------------
	'set oapi = (new Organikapi)(null)
	'oapi.SET_API_KEY = "4d652ee2afc95cae324c294fce2ff8af"	
	'-----------------------------------------------------------------
	
	oapi.SET_CONTENT_TYPE = true ' bu örnekte API'den dönen veriyi ekrana doğru içerik tipiyle basabilmek için bu değer true yapıldı
	LUTFEN_OKUYUN = "SET_CONTENT_TYPE değerini false yaparak sayfa content_type değerinin değiştirilmesini engelleyebilrisniz. varsyılan değeri false olarak ayarlanmıştır."
	LUTFEN_OKUYUN = "Metotlardan dönen verileri değişkenlere aktararak çalışacaksanız buı değerin false olması gerekir"
	
	
	
	if (p = "groups") or (p = "headers") or (p = "balance") or (p = "blacklist") then
		response.write Eval("oapi." & p & "(""" & d & """)")						' Query string'den gelen dinamik metot adını almak için bu şekilde yazıldı. sınıfın metotlarını oapi.groups("json") şeklinde çağırabilirsiniz.
	elseif (p = "smsviaget") or (p = "sendsms") then
		
		LUTFEN_OKUYUN =  "SMS gönderme işlemi için aşağıdaki değişkenleri oapi nesnesine göndermelisiniz. Hangilerinin zorunlu olduğu bilgileri yanlarında açıklama olarak yazılmıştır"
		
		'*****************************************************************************************************************************************************************
		'* HEADER_NAME		// Gönderim yapmak istediğiniz gönderen kimliği. ZORUNLU.
		'* MESSAGE 			// Göndermek istediğiniz mesaj. base64 formatında olmalıdır. ZORUNLU.
		'* GROUPIDS 		// Gönderim yapılacak grupların ID'leri bu değişkende saklanır. ZORUNLU / OPSİYONEL.
		'* GSMS 			// Gönderim yapılacak grupların içine dahil olmayan GSM numaraları bu değişkende saklnır. ZORUNLU / OPSYİONEL.
		'* TIMEOUT 			// Gönderim işlemine başlandıktan sonra iletilmeyen iletilerin ne kadar zaman sonra iadesi gerçekleştiğini belirtir. Saat cinsindendir. OPSYİONEL.
		'* DELIVERY_TIME 	// Gönderim işleminin ileri bir tarihte ypaılması isteniyorsa YYYY-AA-GG SS:DD formatında buraya yazılır. OPSYİONEL.
		'* TRACK_ID 		// Bu gönderim için kendi tarafınızda saklayabileceğiniz benzersiz ID değeridir. Zorunlu değildir. OPSYİONEL.
		'* REPORT_URL 		// Gönderiminizin raporunun POST edileceği URL. JSON formatında gönderilir. OPSYİONEL
		'* IS_UNIQUE / oapi.HEADER gönderim yapılacak başlığın adı ya da ID'sidir. ZORUNLU
		'* MESSAGE_FORMAT 	// Gönderilecek möesaj metninin tipini belirler. 0 ise normal mesaj, 1 ise Türkçe, 2 ise unicode mesajdır. ZORUNLU
		'*****************************************************************************************************************************************************************

		'*****************************************************************************************************************************************************************
		LUTFEN_OKUYUN = "* Aşağıdaki değerler API'nin TEST kullanıcısı için set edilmiştir. Lütfen kendi bilgilerinizle güncellemeyi unutmayın !!!!"
		'*****************************************************************************************************************************************************************
		
		oapi.HEADER_NAME = 21319
		oapi.TIMEOUT = 24
		oapi.MESSAGE = oapi.b64("deneme mesajıdır") ' bu fonksiyon mesajı base64 olarak encode eder
		oapi.GROUPIDS = "1,2,3," ' gönderim yapmak istediğiniz rehber grubu ID'lerini virgülle ayırarak yazabilirsiniz.
		oapi.GSMS = "05551112233,05551112234" ' Bu değer girildiği için oapi.GROUPIDS değişkeni artık zorunlu değil.
		oapi.MESSAGE_FORMAT = 1 ' Türkçe karakterli gönderim için bu değer 1 yapılır.

		if p = "smsviaget" then
			LUTFEN_OKUYUN = "******* GET İLE SMS GÖNDERİMİ ******"
			response.write oapi.smsviaget(d)
		else
			LUTFEN_OKUYUN = "******* POST İLE SMS GÖNDERİMİ ******"
			response.write oapi.sendsms(d)
		end if
	
	elseif p="basicreport" or p="detailedreport" then
		
		LUTFEN_OKUYUN = "Basit ve detaylı rapor alma işlemi için aşağıdaki değişkenleri oapi nesnesine göndermelisiniz. "
		LUTFEN_OKUYUN = "Aşağıdaki değişkenlerden EN AZ 1 TANESİ gönderilmelidir."
		
		'*****************************************************************************************************************************************************************
		'* TRANSACTION_ID		// SMS gönderme işlemlerinde sistem tarafından döndürülen Transaction ID değerleridir.
		'* DELIVERY_TRACK_IDS 	// SMS gönderme işlemlerinde işlem için tarafınızca yazılan izleme ID'leridir.
		'* GSM_TRACK_IDS 		// SMS gönderme işlemlerinde sistem tarafından her GSM için döndürülen izleme ID'leridir.
		'*****************************************************************************************************************************************************************	
		
		oapi.TRANSACTION_IDS = "18171320-5706-28581936,18171320-5706-49714367"
		oapi.DELIVERY_TRACK_IDS = "18171320-5706-28581936,18171320-5706-49714367"
		oapi.GSM_TRACK_IDS = "18171320-5706-28581936,18171320-5706-49714367"
		
		if p = "basicreport" then
			LUTFEN_OKUYUN = "******* BASİT RAPOR ALMA ******"
			response.write oapi.basicreport(d)
		else
			LUTFEN_OKUYUN = "******* DETAYLI RAPOR ALMA ******"
			response.write oapi.detailedreport(d)
		end if
	
	elseif p="groupcontent" then
		LUTFEN_OKUYUN = "******* REHBER GRUPLARININ KİŞİLERİNİ LİSELEME ******"
		LUTFEN_OKUYUN = "Örnekte, grup içeriklerini yüklemek için test kullancısına ait rehber gruplarının ID'leri yaızlmıştır. Kendi verilerinizle güncellemeniz gerekmektedir."
		
		oapi.GROUPIDS = "987883,987884,987885"
		response.write oapi.groupcontent(d)
		
	elseif p="blacklistadd" then
		LUTFEN_OKUYUN = "******* KARA LİSTEYE KAYIT EKLEME ******"
		LUTFEN_OKUYUN = "Örnekte rastgele GSM numarları kara listeye eklenmiştir. Kendi verilerinizle güncellemeniz gerekmektedir."
		
		oapi.GSMS = "05553332211,05553332210,05553332209"
		response.write oapi.blacklistadd(d)	

	elseif p="blacklistremove" then
		LUTFEN_OKUYUN = "******* KARA LİSTEDEN KAYIT SİLME ******"
		LUTFEN_OKUYUN = "Örnekte rastgele GSM numarları kara listeye eklenmiştir. Kendi verilerinizle güncellemeniz gerekmektedir."
		
		oapi.GSMS = "05553332211,05553332210,05553332209"
		response.write oapi.blacklistremove(d)	
		
	elseif p="cancelscheduledtasks" then 
		LUTFEN_OKUYUN = "******* İLERİ TARİHLİ GÖNDERİMLERİ İPTAL ETME ******"
		LUTFEN_OKUYUN = "Örnekte rastgele GSM numarları kara listeye eklenmiştir. Kendi verilerinizle güncellemeniz gerekmektedir."
		oapi.TRANSACTION_IDS = "18171320-5706-28581936,18171320-5706-49714367"
		response.write oapi.cancelscheduledtasks(d)
	
	end if
%>