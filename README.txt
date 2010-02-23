Todo管理Flashについて説明します。

■フォルダ階層
Root/			- 本フォルダを解凍した場所
	assets/		- 画像ファイル
	bin/			- swfファイル
	src/			- ActionScript および MXML ソースファイル

■ファイル説明
Root/
	assets/
		black.jpg						- 背景画像
		check.jpg						- 背景画像
		createButton.jpg			- Todo作成ボタン画像
		favicon.jpg						- ハシビロコウなヘルプ画像
	bin/
		Todo.swf						- Todo Flash
	src/
		cache/
			Todo.as						- ToDo 項目のキャッシュ管理ライブラリ
			Todo.as						- ToDone 項目のキャッシュ管理ライブラリ
		HelpWindow.mxml			- ヘルプ画面
		Important.as					- 重要度クラス
		Main.as							- メインな処理たち
		sprintf.as						- いわゆる sprintf ライブラリ
		TodaysToDo.mxml			- メイン画面
		TodaysToDo-config.xml	- コンパイルオプションの定義
		ToDoneWindow.mxml		- ToDoneリスト画面
	__CompileLibrary.bat			- ライブラリをコンパイル
	Compile.bat						- コンパイル用シェルスクリプト
	README.txt						- いま開いているファイルですよ

■Todo Flash の作り方
	1. Flex 3 SDK をインストールする
		http://www.adobe.com/support/documentation/jp/flex/3/releasenotes_flex3_sdk.html#installation
	2. 1.でインストールしたコンパイラ(mxmlc)を利用できるように、Path環境変数に追加する
		2-1. コントロールパネル > システム > 詳細設定タブ > 環境変数 を開く
		2-2. システム環境変数内の変数Path の値に、 1. のパスを追加して OK
	3. Compile.bat をダブルクリックする
	4. bin/Todo.swf が出来ました☆

■参照
・Adobe Flex 3.2 リファレンスガイド
http://livedocs.adobe.com/flex/3_jp/langref/index.html

・Adobe リファレンスまで楽にいけるように
http://www.tonbi.jp/Flash/ActionScript3/

・mxml
http://kozy.heteml.jp/pukiwiki/index.php?Flex%20MXML%BD%F1%A4%AD%CA%FD#v1ac8fa2

・テスト
http://digitechlog.com/2009/05/07/flexunit-flex-actionscript-application-unit-test-tool-framework.html

・AS3.0 で GoogleMap
http://ushio-labo.jp/freestyle/2008/06/actionscript30googlemaps.html

・エクスプローラー
http://examples.adobe.com/flex3/componentexplorer/explorer.html

・ラジオボタンの処理
http://livedocs.adobe.com/flex/201_jp/html/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_Book_Parts&file=controls_059_12.html

・Alertで Confirm
http://www.tt-house.com/2009/02/confirm-close-on-air.html

・その他
http://kozy.heteml.jp/pukiwiki/Flex%2520MXML%25BD%25F1%25A4%25AD%25CA%25FD/index.html
http://examples.adobe.com/flex3/componentexplorer/explorer.html
http://www.tonbi.jp/Flash/ActionScript3/ui.html
http://www.adobe.com/support/documentation/jp/flex/1_5/asdocs_jp/index.html?mx/controls/RadioButton.html
http://d.hatena.ne.jp/morningmist7/20081218/1229584771

http://wiki.reirou.jp/doku.php?id=mxml:controls

・SharedObject
http://satt.jp/tech/std/movies/shared_object/
http://www.adobe.com/jp/support/kb/ts/228/ts_228630_ja-jp.html
http://1art.jp/flash/le/lesson41/lesson41.htm
http://mamnag.org/prmx/flash/sharedobject.html

・エフェクトソースサンプル
http://www.designwalker.com/2009/06/flash-effect.html

