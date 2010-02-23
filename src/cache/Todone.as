/*
したこと情報を管理するクラスです
*/
package cache {
    public class Todone extends cache.Base {
		import mx.collections.ArrayCollection

        // コンストラクタ
        private static const TODONE_PATH:String = 'memory__todoneList'
		public function Todone () { super(TODONE_PATH) }

		// ToDoアイテムを追加登録
		public function setTodone (todoCollection:ArrayCollection) : void { getCache().data.todoneList = todoCollection }

		// ToDoアイテムを削除します
		public function getTodone () : ArrayCollection { return (getCache().data.todoneList) ? getCache().data.todoneList : new ArrayCollection() }
	}
}