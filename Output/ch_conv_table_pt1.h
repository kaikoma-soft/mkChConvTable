//
// 変換テーブル
//
#define  BS_01  0
#define  BS_03  1
#define  BS_05  2
#define  BS_07  3
#define  BS_09  4
#define  BS_11  5
#define  BS_13  6
#define  BS_15  7
#define  BS_17  8
#define  BS_19  9
#define  BS_21  10
#define  BS_23  11
#define  CS_02  12
#define  CS_04  13
#define  CS_06  14
#define  CS_08  15
#define  CS_10  16
#define  CS_12  17
#define  CS_14  18
#define  CS_16  19
#define  CS_18  20
#define  CS_20  21
#define  CS_22  22
#define  CS_24  23

ISDB_T_FREQ_CONV_TABLE    isdb_t_conv_table[] = {
    { BS_01, CHTYPE_SATELLITE, 0, "151"},  /* BS朝日1 */
    { BS_01, CHTYPE_SATELLITE, 1, "161"},  /* BS-TBS */
    { BS_01, CHTYPE_SATELLITE, 2, "171"},  /* BSテレ東 */
    { BS_01, CHTYPE_SATELLITE, 2, "172"},  /* BSテレ東2 */
    { BS_03, CHTYPE_SATELLITE, 0, "191"},  /* WOWOWプライム */
    { BS_03, CHTYPE_SATELLITE, 1, "103"},  /* NHKBSプレミアム */
    { BS_05, CHTYPE_SATELLITE, 0, "192"},  /* WOWOWライブ */
    { BS_05, CHTYPE_SATELLITE, 1, "193"},  /* WOWOWシネマ */
    { BS_09, CHTYPE_SATELLITE, 0, "211"},  /* BS11イレブン */
    { BS_09, CHTYPE_SATELLITE, 1, "200"},  /* スターチャンネル1 */
    { BS_09, CHTYPE_SATELLITE, 1, "800"},  /* スターチャンネル */
    { BS_09, CHTYPE_SATELLITE, 2, "222"},  /* BS12トゥエルビ */
    { BS_11, CHTYPE_SATELLITE, 1, "241"},  /* BSスカパー！ */
    { BS_11, CHTYPE_SATELLITE, 1, "840"},  /* スカパー！ガイド */
    { BS_11, CHTYPE_SATELLITE, 2, "231"},  /* 放送大学ex */
    { BS_11, CHTYPE_SATELLITE, 2, "232"},  /* 放送大学on */
    { BS_11, CHTYPE_SATELLITE, 2, "531"},  /* 放送大学ラジオ */
    { BS_11, CHTYPE_SATELLITE, 3, "251"},  /* BS釣りビジョン */
    { BS_13, CHTYPE_SATELLITE, 0, "141"},  /* BS日テレ */
    { BS_13, CHTYPE_SATELLITE, 0, "142"},  /* BS日テレ */
    { BS_13, CHTYPE_SATELLITE, 1, "181"},  /* BSフジ・181 */
    { BS_13, CHTYPE_SATELLITE, 2, "236"},  /* BSアニマックス */
    { BS_15, CHTYPE_SATELLITE, 0, "101"},  /* NHKBS1 */
    { BS_15, CHTYPE_SATELLITE, 0, "102"},  /* NHKBS1 */
    { BS_15, CHTYPE_SATELLITE, 1, "201"},  /* スターチャンネル2 */
    { BS_15, CHTYPE_SATELLITE, 1, "202"},  /* スターチャンネル3 */
    { BS_19, CHTYPE_SATELLITE, 0, "245"},  /* J SPORTS 4 */
    { BS_19, CHTYPE_SATELLITE, 1, "242"},  /* J SPORTS 1 */
    { BS_19, CHTYPE_SATELLITE, 2, "243"},  /* J SPORTS 2 */
    { BS_19, CHTYPE_SATELLITE, 3, "244"},  /* J SPORTS 3 */
    { BS_21, CHTYPE_SATELLITE, 0, "252"},  /* WOWOWプラス */
    { BS_21, CHTYPE_SATELLITE, 1, "255"},  /* 日本映画専門ch */
    { BS_21, CHTYPE_SATELLITE, 2, "234"},  /* グリーンチャンネル */
    { BS_23, CHTYPE_SATELLITE, 0, "256"},  /* ディズニーch */
    { BS_23, CHTYPE_SATELLITE, 1, "265"},  /* BSよしもと */
    { BS_23, CHTYPE_SATELLITE, 2, "263"},  /* BSJapanext */
    { BS_23, CHTYPE_SATELLITE, 3, "260"},  /* BS松竹東急 */

    {  12, CHTYPE_SATELLITE, 0, "CS2"},  /* ND2  */
    {  13, CHTYPE_SATELLITE, 0, "CS4"},  /* ND4  */
    {  14, CHTYPE_SATELLITE, 0, "CS6"},  /* ND6  */
    {  15, CHTYPE_SATELLITE, 0, "CS8"},  /* ND8  */
    {  16, CHTYPE_SATELLITE, 0, "CS10"}, /* ND10 */
    {  17, CHTYPE_SATELLITE, 0, "CS12"}, /* ND12 */
    {  18, CHTYPE_SATELLITE, 0, "CS14"}, /* ND14 */
    {  19, CHTYPE_SATELLITE, 0, "CS16"}, /* ND16 */
    {  20, CHTYPE_SATELLITE, 0, "CS18"}, /* ND18 */
    {  21, CHTYPE_SATELLITE, 0, "CS20"}, /* ND20 */
    {  22, CHTYPE_SATELLITE, 0, "CS22"}, /* ND22 */
    {  23, CHTYPE_SATELLITE, 0, "CS24"}, /* ND24 */

    { CS_02, CHTYPE_SATELLITE, 0, "296" },  /* TBSチャンネル1 */
    { CS_02, CHTYPE_SATELLITE, 0, "298" },  /* テレ朝チャンネル1 */
    { CS_02, CHTYPE_SATELLITE, 0, "299" },  /* テレ朝チャンネル2 */
    { CS_02, CHTYPE_SATELLITE, 0, "339" },  /* ディズニージュニア */
    { CS_04, CHTYPE_SATELLITE, 0, "250" },  /* スカイA */
    { CS_04, CHTYPE_SATELLITE, 0, "292" },  /* 時代劇専門ch */
    { CS_04, CHTYPE_SATELLITE, 0, "301" },  /* エンタメ〜テレ */
    { CS_04, CHTYPE_SATELLITE, 0, "323" },  /* MTV */
    { CS_06, CHTYPE_SATELLITE, 0, "294" },  /* ホームドラマCH */
    { CS_06, CHTYPE_SATELLITE, 0, "324" },  /* ミュージック・エア */
    { CS_06, CHTYPE_SATELLITE, 0, "329" },  /* 歌謡ポップス */
    { CS_06, CHTYPE_SATELLITE, 0, "331" },  /* カートゥーン */
    { CS_06, CHTYPE_SATELLITE, 0, "340" },  /* ディスカバリー */
    { CS_06, CHTYPE_SATELLITE, 0, "341" },  /* アニマルプラネット */
    { CS_06, CHTYPE_SATELLITE, 0, "354" },  /* CNNj */
    { CS_06, CHTYPE_SATELLITE, 0, "363" },  /* 囲碁・将棋チャンネル */
    { CS_08, CHTYPE_SATELLITE, 0, "218" },  /* 東映チャンネル */
    { CS_08, CHTYPE_SATELLITE, 0, "318" },  /* Mnet */
    { CS_08, CHTYPE_SATELLITE, 0, "349" },  /* 日テレNEWS24 */
    { CS_08, CHTYPE_SATELLITE, 0, "55"  },  /* ショップチャンネル */
    { CS_10, CHTYPE_SATELLITE, 0, "101" },  /* スカパー！インフォ */
    { CS_10, CHTYPE_SATELLITE, 0, "219" },  /* 衛星劇場 */
    { CS_10, CHTYPE_SATELLITE, 0, "317" },  /* KBS World */
    { CS_10, CHTYPE_SATELLITE, 0, "800" },  /* スポーツライブ＋ */
    { CS_10, CHTYPE_SATELLITE, 0, "801" },  /* スカチャン1 */
    { CS_12, CHTYPE_SATELLITE, 0, "254" },  /* GAORA */
    { CS_12, CHTYPE_SATELLITE, 0, "325" },  /* エムオン！ */
    { CS_12, CHTYPE_SATELLITE, 0, "330" },  /* キッズステーション */
    { CS_12, CHTYPE_SATELLITE, 0, "343" },  /* ナショジオ */
    { CS_14, CHTYPE_SATELLITE, 0, "227" },  /* ザ・シネマ */
    { CS_14, CHTYPE_SATELLITE, 0, "293" },  /* ファミリー劇場 */
    { CS_14, CHTYPE_SATELLITE, 0, "310" },  /* スーパー！ドラマTV */
    { CS_14, CHTYPE_SATELLITE, 0, "342" },  /* ヒストリーチャンネル */
    { CS_16, CHTYPE_SATELLITE, 0, "290" },  /* SKY STAGE */
    { CS_16, CHTYPE_SATELLITE, 0, "311" },  /* AXN 海外ドラマ */
    { CS_16, CHTYPE_SATELLITE, 0, "316" },  /* AXNミステリー */
    { CS_16, CHTYPE_SATELLITE, 0, "321" },  /* スペシャプラス */
    { CS_16, CHTYPE_SATELLITE, 0, "333" },  /* AT−X */
    { CS_16, CHTYPE_SATELLITE, 0, "353" },  /* BBCワールド */
    { CS_18, CHTYPE_SATELLITE, 0, "240" },  /* ムービープラス */
    { CS_18, CHTYPE_SATELLITE, 0, "262" },  /* ゴルフネットワーク */
    { CS_18, CHTYPE_SATELLITE, 0, "305" },  /* 銀河◆歴ドラ・サスペ */
    { CS_18, CHTYPE_SATELLITE, 0, "314" },  /* 女性ch／LaLa */
    { CS_20, CHTYPE_SATELLITE, 0, "307" },  /* フジテレビONE */
    { CS_20, CHTYPE_SATELLITE, 0, "308" },  /* フジテレビTWO */
    { CS_20, CHTYPE_SATELLITE, 0, "309" },  /* フジテレビNEXT */
    { CS_20, CHTYPE_SATELLITE, 0, "322" },  /* スペースシャワーTV */
    { CS_22, CHTYPE_SATELLITE, 0, "161" },  /* QVC */
    { CS_22, CHTYPE_SATELLITE, 0, "297" },  /* TBSチャンネル2 */
    { CS_22, CHTYPE_SATELLITE, 0, "312" },  /* FOX */
    { CS_22, CHTYPE_SATELLITE, 0, "351" },  /* TBS NEWS */
    { CS_24, CHTYPE_SATELLITE, 0, "223" },  /* 映画・chNECO */
    { CS_24, CHTYPE_SATELLITE, 0, "257" },  /* 日テレジータス */
    { CS_24, CHTYPE_SATELLITE, 0, "295" },  /* MONDO TV */
    { CS_24, CHTYPE_SATELLITE, 0, "300" },  /* 日テレプラス */


    {   0, CHTYPE_GROUND, 0,   "1"}, {   1, CHTYPE_GROUND, 0,   "2"},
    {   2, CHTYPE_GROUND, 0,   "3"}, {   3, CHTYPE_GROUND, 0, "C13"},
    {   4, CHTYPE_GROUND, 0, "C14"}, {   5, CHTYPE_GROUND, 0, "C15"},
    {   6, CHTYPE_GROUND, 0, "C16"}, {   7, CHTYPE_GROUND, 0, "C17"},
    {   8, CHTYPE_GROUND, 0, "C18"}, {   9, CHTYPE_GROUND, 0, "C19"},
    {  10, CHTYPE_GROUND, 0, "C20"}, {  11, CHTYPE_GROUND, 0, "C21"},
    {  12, CHTYPE_GROUND, 0, "C22"}, {  13, CHTYPE_GROUND, 0,   "4"},
    {  14, CHTYPE_GROUND, 0,   "5"}, {  15, CHTYPE_GROUND, 0,   "6"},
    {  16, CHTYPE_GROUND, 0,   "7"}, {  17, CHTYPE_GROUND, 0,   "8"},
    {  18, CHTYPE_GROUND, 0,   "9"}, {  19, CHTYPE_GROUND, 0,  "10"},
    {  20, CHTYPE_GROUND, 0,  "11"}, {  21, CHTYPE_GROUND, 0,  "12"},
    {  22, CHTYPE_GROUND, 0, "C23"}, {  23, CHTYPE_GROUND, 0, "C24"},
    {  24, CHTYPE_GROUND, 0, "C25"}, {  25, CHTYPE_GROUND, 0, "C26"},
    {  26, CHTYPE_GROUND, 0, "C27"}, {  27, CHTYPE_GROUND, 0, "C28"},
    {  28, CHTYPE_GROUND, 0, "C29"}, {  29, CHTYPE_GROUND, 0, "C30"},
    {  30, CHTYPE_GROUND, 0, "C31"}, {  31, CHTYPE_GROUND, 0, "C32"},
    {  32, CHTYPE_GROUND, 0, "C33"}, {  33, CHTYPE_GROUND, 0, "C34"},
    {  34, CHTYPE_GROUND, 0, "C35"}, {  35, CHTYPE_GROUND, 0, "C36"},
    {  36, CHTYPE_GROUND, 0, "C37"}, {  37, CHTYPE_GROUND, 0, "C38"},
    {  38, CHTYPE_GROUND, 0, "C39"}, {  39, CHTYPE_GROUND, 0, "C40"},
    {  40, CHTYPE_GROUND, 0, "C41"}, {  41, CHTYPE_GROUND, 0, "C42"},
    {  42, CHTYPE_GROUND, 0, "C43"}, {  43, CHTYPE_GROUND, 0, "C44"},
    {  44, CHTYPE_GROUND, 0, "C45"}, {  45, CHTYPE_GROUND, 0, "C46"},
    {  46, CHTYPE_GROUND, 0, "C47"}, {  47, CHTYPE_GROUND, 0, "C48"},
    {  48, CHTYPE_GROUND, 0, "C49"}, {  49, CHTYPE_GROUND, 0, "C50"},
    {  50, CHTYPE_GROUND, 0, "C51"}, {  51, CHTYPE_GROUND, 0, "C52"},
    {  52, CHTYPE_GROUND, 0, "C53"}, {  53, CHTYPE_GROUND, 0, "C54"},
    {  54, CHTYPE_GROUND, 0, "C55"}, {  55, CHTYPE_GROUND, 0, "C56"},
    {  56, CHTYPE_GROUND, 0, "C57"}, {  57, CHTYPE_GROUND, 0, "C58"},
    {  58, CHTYPE_GROUND, 0, "C59"}, {  59, CHTYPE_GROUND, 0, "C60"},
    {  60, CHTYPE_GROUND, 0, "C61"}, {  61, CHTYPE_GROUND, 0, "C62"},
    {  62, CHTYPE_GROUND, 0, "C63"}, {  63, CHTYPE_GROUND, 0,  "13"},
    {  64, CHTYPE_GROUND, 0,  "14"}, {  65, CHTYPE_GROUND, 0,  "15"},
    {  66, CHTYPE_GROUND, 0,  "16"}, {  67, CHTYPE_GROUND, 0,  "17"},
    {  68, CHTYPE_GROUND, 0,  "18"}, {  69, CHTYPE_GROUND, 0,  "19"},
    {  70, CHTYPE_GROUND, 0,  "20"}, {  71, CHTYPE_GROUND, 0,  "21"},
    {  72, CHTYPE_GROUND, 0,  "22"}, {  73, CHTYPE_GROUND, 0,  "23"},
    {  74, CHTYPE_GROUND, 0,  "24"}, {  75, CHTYPE_GROUND, 0,  "25"},
    {  76, CHTYPE_GROUND, 0,  "26"}, {  77, CHTYPE_GROUND, 0,  "27"},
    {  78, CHTYPE_GROUND, 0,  "28"}, {  79, CHTYPE_GROUND, 0,  "29"},
    {  80, CHTYPE_GROUND, 0,  "30"}, {  81, CHTYPE_GROUND, 0,  "31"},
    {  82, CHTYPE_GROUND, 0,  "32"}, {  83, CHTYPE_GROUND, 0,  "33"},
    {  84, CHTYPE_GROUND, 0,  "34"}, {  85, CHTYPE_GROUND, 0,  "35"},
    {  86, CHTYPE_GROUND, 0,  "36"}, {  87, CHTYPE_GROUND, 0,  "37"},
    {  88, CHTYPE_GROUND, 0,  "38"}, {  89, CHTYPE_GROUND, 0,  "39"},
    {  90, CHTYPE_GROUND, 0,  "40"}, {  91, CHTYPE_GROUND, 0,  "41"},
    {  92, CHTYPE_GROUND, 0,  "42"}, {  93, CHTYPE_GROUND, 0,  "43"},
    {  94, CHTYPE_GROUND, 0,  "44"}, {  95, CHTYPE_GROUND, 0,  "45"},
    {  96, CHTYPE_GROUND, 0,  "46"}, {  97, CHTYPE_GROUND, 0,  "47"},
    {  98, CHTYPE_GROUND, 0,  "48"}, {  99, CHTYPE_GROUND, 0,  "49"},
    { 100, CHTYPE_GROUND, 0,  "50"}, { 101, CHTYPE_GROUND, 0,  "51"},
    { 102, CHTYPE_GROUND, 0,  "52"}, { 103, CHTYPE_GROUND, 0,  "53"},
    { 104, CHTYPE_GROUND, 0,  "54"}, { 105, CHTYPE_GROUND, 0,  "55"},
    { 106, CHTYPE_GROUND, 0,  "56"}, { 107, CHTYPE_GROUND, 0,  "57"},
    { 108, CHTYPE_GROUND, 0,  "58"}, { 109, CHTYPE_GROUND, 0,  "59"},
    { 110, CHTYPE_GROUND, 0,  "60"}, { 111, CHTYPE_GROUND, 0,  "61"},
    { 112, CHTYPE_GROUND, 0,  "62"},
    { 0, 0, 0, NULL} /* terminate */
};


char *helpChList[] = {
	"101 ch : NHKBS1",
	"102 ch : NHKBS1",
	"103 ch : NHKBSプレミアム",
	"141 ch : BS日テレ",
	"142 ch : BS日テレ",
	"151 ch : BS朝日1",
	"161 ch : BS-TBS",
	"171 ch : BSテレ東",
	"172 ch : BSテレ東2",
	"181 ch : BSフジ・181",
	"191 ch : WOWOWプライム",
	"192 ch : WOWOWライブ",
	"193 ch : WOWOWシネマ",
	"200 ch : スターチャンネル1",
	"201 ch : スターチャンネル2",
	"202 ch : スターチャンネル3",
	"211 ch : BS11イレブン",
	"222 ch : BS12トゥエルビ",
	"231 ch : 放送大学ex",
	"232 ch : 放送大学on",
	"234 ch : グリーンチャンネル",
	"236 ch : BSアニマックス",
	"241 ch : BSスカパー！",
	"242 ch : J SPORTS 1",
	"243 ch : J SPORTS 2",
	"244 ch : J SPORTS 3",
	"245 ch : J SPORTS 4",
	"251 ch : BS釣りビジョン",
	"252 ch : WOWOWプラス",
	"255 ch : 日本映画専門ch",
	"256 ch : ディズニーch",
	"260 ch : BS松竹東急",
	"263 ch : BSJapanext",
	"265 ch : BSよしもと",
	"531 ch : 放送大学ラジオ",
	"800 ch : スターチャンネル",
	"840 ch : スカパー！ガイド",
	"",
	" 55 ch : ショップチャンネル",
	"101 ch : スカパー！インフォ",
	"161 ch : QVC",
	"218 ch : 東映チャンネル",
	"219 ch : 衛星劇場",
	"223 ch : 映画・chNECO",
	"227 ch : ザ・シネマ",
	"240 ch : ムービープラス",
	"250 ch : スカイA",
	"254 ch : GAORA",
	"257 ch : 日テレジータス",
	"262 ch : ゴルフネットワーク",
	"290 ch : SKY STAGE",
	"292 ch : 時代劇専門ch",
	"293 ch : ファミリー劇場",
	"294 ch : ホームドラマCH",
	"295 ch : MONDO TV",
	"296 ch : TBSチャンネル1",
	"297 ch : TBSチャンネル2",
	"298 ch : テレ朝チャンネル1",
	"299 ch : テレ朝チャンネル2",
	"300 ch : 日テレプラス",
	"301 ch : エンタメ〜テレ",
	"305 ch : 銀河◆歴ドラ・サスペ",
	"307 ch : フジテレビONE",
	"308 ch : フジテレビTWO",
	"309 ch : フジテレビNEXT",
	"310 ch : スーパー！ドラマTV",
	"311 ch : AXN 海外ドラマ",
	"312 ch : FOX",
	"314 ch : 女性ch／LaLa",
	"316 ch : AXNミステリー",
	"317 ch : KBS World",
	"318 ch : Mnet",
	"321 ch : スペシャプラス",
	"322 ch : スペースシャワーTV",
	"323 ch : MTV",
	"324 ch : ミュージック・エア",
	"325 ch : エムオン！",
	"329 ch : 歌謡ポップス",
	"330 ch : キッズステーション",
	"331 ch : カートゥーン",
	"333 ch : AT−X",
	"339 ch : ディズニージュニア",
	"340 ch : ディスカバリー",
	"341 ch : アニマルプラネット",
	"342 ch : ヒストリーチャンネル",
	"343 ch : ナショジオ",
	"349 ch : 日テレNEWS24",
	"351 ch : TBS NEWS",
	"353 ch : BBCワールド",
	"354 ch : CNNj",
	"363 ch : 囲碁・将棋チャンネル",
	"800 ch : スポーツライブ＋",
	"801 ch : スカチャン1",
	NULL,
};

// created by mkChConvTable.rb (2022-03-09 17:56:14 +0900)
// BS = 37, CS = 55
