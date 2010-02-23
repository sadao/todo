/*
MXML から 読込まれる ToDo情報を管理するクラスです
*/
import mx.collections.ArrayCollection
import mx.containers.Canvas
import mx.controls.Alert
import mx.core.IDataRenderer
import mx.core.IFlexDisplayObject
import mx.events.CloseEvent
import mx.managers.PopUpManager
import cache.Todo
import cache.Todone
import Important
import sprintf

[Bindable]
public var maximumTodoList:ArrayCollection = new ArrayCollection;
[Bindable]
public var middleTodoList:ArrayCollection = new ArrayCollection;
[Bindable]
public var minimumTodoList:ArrayCollection = new ArrayCollection;
[Bindable]
public var reTodoList:ArrayCollection = new ArrayCollection;
[Bindable]
public var todoneList:ArrayCollection = new ArrayCollection;

// 初期処理です。ページ読込み時に実行されます。
private function creationCompleteHandler() : void {
	// ToDo追加時のイベントを登録します
	createTodo.addEventListener(MouseEvent.CLICK, createTodoHandler)

	// ToDoキャッシュ情報をロードします
	loadToDo()

	// ToDoneキャッシュ情報をロードします
	loadToDone()
}

// Todo項目作成領域を初期化します
private function initCreate() : void {
	// することを初期化
	initTodo()

	// 開始時間を初期化
	StartTimeToNow()

	// 重要度を初期化
	initImportant()
}
// することを初期化します
private static const DEFAULT_TODO_STRING:String = 'すること'
private function initTodo() : void {
	todoItem.text = DEFAULT_TODO_STRING
}
// 重要度を初期化します
private function initImportant() : void {
	importantMiddle.selected = importantMin.selected = false
	importantMax.selected = true
}

// ToDo エリアをクリックしたときの動作を定義します
private function clickToDoHandler(event:MouseEvent) : void {
	// ToDoアイテム作成ボタン押下時のイベント
	todoItem.addEventListener(MouseEvent.CLICK, clickTodoItem)

	// ToDoアイテム作成ボタンから離れた時のイベント
	todoItem.addEventListener(MouseEvent.MOUSE_OUT, mouseOutTodoItem)
}
// ToDoアイテムを押下した時の処理
private function clickTodoItem(event:MouseEvent) : void { if (todoItem.text == DEFAULT_TODO_STRING)  todoItem.text = '' }
// ToDoアイテム入力エリアからマウスアウトしたときの処理
private function mouseOutTodoItem(event:MouseEvent) : void { if (! isTodoItem()) initTodo() }
// 入力値が空か判定します
private function isTodoItem():Boolean { return (todoItem.text == '') ? false : true }
// バリデーター
private var hhExp:RegExp = /^([0-9]|1[0-9]|2[0-3])$/;
private function isStartTimeHH():Boolean { return (hhExp.test(startTimeHH.text) ) ? true : false }
private var mmExp:RegExp = /^([0-9]|[1-5][0-9])$/;
private function isStartTimeMM():Boolean { return (mmExp.test(startTimeMM.text) ) ? true : false }

// 開始時間を現在時間に更新します
private function updateStartTime(event:MouseEvent) : void { StartTimeToNow() }

// 開始時間を現在時間に更新します
private function StartTimeToNow() : void {
	var currentDate:Date = new Date()
	startTimeHH.text = String( currentDate.hours )
	startTimeMM.text = String( currentDate.minutes )
}

// することを作成します
private function createTodoHandler(event:MouseEvent) : void {
	//パラメータチェック => Validatorクラスを使う？
	// http://examples.adobe.com/flex3/componentexplorer/explorer.html
	if (! isTodoItem()) {
		Alert.show( '「ToDo」は必須です' )
		return 
	}

	// 開始時間のフォーマットをチェックする
	// http://www.adobe.com/livedocs/flex/3_jp/langref/mx/formatters/DateFormatter.html
	if (! isStartTimeHH()) {
		Alert.show( '「hh」の値は、0～23 の範囲で設定してください。' )
		return
	}
	if (! isStartTimeMM()) {
		Alert.show( '「mm」の値は、0～59 の範囲で設定してください。' )
		return
	}

	// 重要度に対応したTodo一覧 に項目を追加する
	addTodoItem( {text : todoItem.text, startTime : getStartTime()} )

	// Todo項目を追加するごとに、Create 領域を初期化する
	initCreate()
}

// 開始時間を返却します
private function getStartTime() : String { return sprintf("%02d:%02d", startTimeHH.text, startTimeMM.text) }

// 重要度 Maximum な項目の削除確認です
private function confirmMaximumTodo():void {
	if (maximumData.selectedIndex < 0 ) return
	Alert.show( maximumTodoList.getItemAt( maximumData.selectedIndex ).text, "完了ですか？", Alert.YES | Alert.CANCEL, null, completionMaximumTodo)
}
// Todoアイテムを削除します
private function completionMaximumTodo(event:CloseEvent):void {
	if (event.detail != Alert.YES) return

	// ToDoneリストへ項目を追加する
	addTodoneItem( importantMax.label, maximumTodoList.getItemAt( maximumData.selectedIndex ) )

	// ToDoリストから項目を削除する
	maximumTodoList.removeItemAt( maximumData.selectedIndex )

	// キャッシュ情報を更新します
	var cacheTodo:Todo = new cache.Todo()
	cacheTodo.setMaximumTodo( maximumTodoList )
}

// 重要度 Middleな項目の削除確認です
private function confirmMiddleTodo():void {
	if (middleData.selectedIndex < 0 ) return
	Alert.show( middleTodoList.getItemAt( middleData.selectedIndex ).text, "完了ですか？", Alert.YES | Alert.CANCEL, null, completionMiddleTodo)
}
// Todoアイテムを削除します
private function completionMiddleTodo(event:CloseEvent):void {
	if (event.detail != Alert.YES) return

	// ToDoneリストへ項目を追加する
	addTodoneItem( importantMiddle.label, middleTodoList.getItemAt( middleData.selectedIndex ) )

	// ToDoリストから項目を削除する
	middleTodoList.removeItemAt( middleData.selectedIndex )

	// キャッシュ情報を更新します
	var cacheTodo:Todo = new cache.Todo()
	cacheTodo.setMiddleTodo( middleTodoList )
}

// 重要度 Minimum な項目の削除確認です
private function confirmMinimumTodo():void {
	if (minimumData.selectedIndex < 0 ) return
	Alert.show( minimumTodoList.getItemAt( minimumData.selectedIndex ).text, "完了ですか？", Alert.YES | Alert.CANCEL, null, completionMinimumTodo)
}
// Todoアイテムを削除します
private function completionMinimumTodo(event:CloseEvent):void {
	if (event.detail != Alert.YES) return

	// ToDoneリストへ項目を追加する
	addTodoneItem( importantMin.label, minimumTodoList.getItemAt( minimumData.selectedIndex ) )

	// ToDoリストから項目を削除する
	minimumTodoList.removeItemAt( minimumData.selectedIndex )

	// キャッシュ情報を更新します
	var cacheTodo:Todo = new cache.Todo()
	cacheTodo.setMinimumTodo( minimumTodoList )
}

// 繰り返し項目の削除確認です
private function confirmReTodo():void {
	if (reData.selectedIndex < 0 ) return
	Alert.show( reTodoList.getItemAt( reData.selectedIndex ).text, "完了ですか？", Alert.YES | Alert.CANCEL, null, completionReTodo)
}
// 繰り返しアイテムを削除します
private function completionReTodo(event:CloseEvent):void {
	if (event.detail != Alert.YES) return

	// リストから項目を削除する
	reTodoList.removeItemAt( reData.selectedIndex )

	// キャッシュ情報を更新します
	var cacheTodo:Todo = new cache.Todo()
	cacheTodo.setReTodo( reTodoList )
}

// ToDone 項目を作成します
private function addTodoneItem(importantName:String, todoItem:Object) : void {
	var todoneObject:Object = { text : todoItem.text, important : importantName, startTime : todoItem.startTime, endTime : getCurrentTime()}
	todoneList.addItem( todoneObject )
	var cacheTodone : Todone = new Todone()
	cacheTodone.setTodone( todoneList )
}

// ToDone 情報をポップアップ表示します
private function toTodoneText():void {
    var popupTodoneList : IFlexDisplayObject = PopUpManager.createPopUp( this, ToDoneWindow, true );
	IDataRenderer(popupTodoneList).data = todoneList
    PopUpManager.centerPopUp( popupTodoneList );
}

// したこと情報のみクリアします
private function clearTodone():void {
	// クリア
	todoneList = null
	todoneList = new ArrayCollection

	// キャッシュクリア
	var cacheTodone:Todone = new cache.Todone()
	cacheTodone.clear()
}

// 全ての情報をクリアします
private function clearAll():void {
	// クリア
	maximumTodoList = null
	maximumTodoList = new ArrayCollection
	middleTodoList = null
	middleTodoList = new ArrayCollection
	minimumTodoList = null
	minimumTodoList = new ArrayCollection
	reTodoList = null
	reTodoList = new ArrayCollection
	todoneList = null
	todoneList = new ArrayCollection

	// キャッシュクリア
	var cacheTodo:Todo = new cache.Todo()
	cacheTodo.clear()
	var cacheTodone:Todone = new cache.Todone()
	cacheTodone.clear()
}

// 繰り返し情報のキャッシュを更新します
private function syncAll():void {
	// ToDo を更新
	var cacheTodo:Todo = new cache.Todo()
	cacheTodo.setMaximumTodo( maximumTodoList )
	cacheTodo.setMiddleTodo( middleTodoList )
	cacheTodo.setMinimumTodo( minimumTodoList )
	cacheTodo.setReTodo( reTodoList )

	// ToDone を更新
	var cacheTodone:Todone = new cache.Todone()
	cacheTodone.setTodone( todoneList )

	Alert.show('ToDo/ToDoneをキャッシュに反映しました！')
}

// ヘルプ 情報をポップアップ表示します
private function toHelp():void {
    var popupHelp : IFlexDisplayObject = PopUpManager.createPopUp( this, HelpWindow, true );
    PopUpManager.centerPopUp( popupHelp );
}

// @nifty TimeLine API の設定画面です
private function toTimeLine():void {
    var popupProfile : IFlexDisplayObject = PopUpManager.createPopUp( this, TimeLineWindow, true );
    PopUpManager.centerPopUp( popupProfile );
}

// ToDone 項目の削除確認です
private function confirmTodone():void {
	if (todoneData.selectedIndex < 0 ) return
	Alert.show( todoneList.getItemAt( todoneData.selectedIndex ).text, "削除しますか？", Alert.YES | Alert.CANCEL, null, removeTodone)
}

// Todoneアイテムを削除します
private function removeTodone(event:CloseEvent):void {
	if (event.detail != Alert.YES) return

	// ToDoリストから項目を削除する
	todoneList.removeItemAt( todoneData.selectedIndex )

	var cacheTodone:Todone = new cache.Todone()
	cacheTodone.setTodone( todoneList )
}

// 現在日時を取得します
private function getCurrentTime() : String {
	var currentDate:Date = new Date()
	return sprintf( "%02d:%02d", currentDate.getHours(), currentDate.getMinutes() )
}

// 重要度に対応する ToDoリスト領域にオブジェクトを追加します
private function addTodoItem(todoItem:Object):void {
	var important:Important = new Important( important.selectedValue )
	var cacheTodo:Todo = new cache.Todo()
	if	(important.isImportantMaximum()) {
		maximumTodoList.addItem( todoItem )
		cacheTodo.setMaximumTodo( maximumTodoList )
	} else if (important.isImportantMiddle()) {
		middleTodoList.addItem( todoItem )
		cacheTodo.setMiddleTodo( middleTodoList )
	} else if (important.isImportantMinimum()) {
		minimumTodoList.addItem( todoItem )
		cacheTodo.setMinimumTodo( minimumTodoList )
	} else {
		maximumTodoList.addItem( todoItem )
		cacheTodo.setMaximumTodo( maximumTodoList )
	}
}

// Todoのキャッシュ情報を読込みます
private function loadToDo() : void {
	// ToDo情報をキャッシュから取得
	var cacheTodo:Todo = new cache.Todo()
	maximumTodoList= cacheTodo.getMaximumTodo()
	middleTodoList = cacheTodo.getMiddleTodo()
	minimumTodoList = cacheTodo.getMinimumTodo()
	reTodoList = cacheTodo.getReTodo()
}
// Todoneのキャッシュ情報を読込みます
private function loadToDone() : void {
	// ToDo情報をキャッシュから取得
	var cacheTodone:Todone = new cache.Todone()
	todoneList = cacheTodone.getTodone()
}
