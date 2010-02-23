/*
ToDo(ne)キャッシュ情報を管理するスーパークラスです
*/
package cache {
    public class Base {
		import flash.net.SharedObject

        // コンストラクタ
        private var __cacheSO:SharedObject
		public function Base (cachePath:String) { initSO(cachePath) }

		// 初期化処理
		private function initSO (cachePath:String) : void {
			__cacheSO = SharedObject.getLocal(cachePath)
			if  (__cacheSO.data.todoList == undefined) {
				// 空のObjectクラスを設定
				__cacheSO.data.todoList = new Object

				// 即時保存
				__cacheSO.flush()
			}
		}

		// キャッシュ領域を取得します
		public function getCache () : SharedObject { return __cacheSO }
		
		// キャッシュを全て削除します
		public function clear () : void { __cacheSO.clear() }
	}
}