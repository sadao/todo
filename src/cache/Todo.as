/*
すること情報を管理するクラスです
*/
package cache {
    public class Todo extends cache.Base {
		import mx.collections.ArrayCollection

        // コンストラクタ
        private static const TODO_PATH:String = 'memory__todoList'
		public function Todo () { super(TODO_PATH) }

		// ToDoアイテムを追加登録
		public function setMaximumTodo (todoCollection:ArrayCollection) : void { getCache().data.todoList.maximum = todoCollection }
		public function setMiddleTodo (todoCollection:ArrayCollection) : void { getCache().data.todoList.middle = todoCollection }
		public function setMinimumTodo (todoCollection:ArrayCollection) : void { getCache().data.todoList.minimum = todoCollection }
		public function setReTodo (todoCollection:ArrayCollection) : void { getCache().data.todoList.replay = todoCollection }

		// ToDoアイテムを削除します
		public function getMaximumTodo () : ArrayCollection { return (getCache().data.todoList.maximum) ? getCache().data.todoList.maximum : new ArrayCollection }
		public function getMiddleTodo () : ArrayCollection { return (getCache().data.todoList.middle) ? getCache().data.todoList.middle : new ArrayCollection }
		public function getMinimumTodo () : ArrayCollection { return (getCache().data.todoList.minimum) ? getCache().data.todoList.minimum : new ArrayCollection }
		public function getReTodo () : ArrayCollection { return (getCache().data.todoList.replay) ? getCache().data.todoList.replay : new ArrayCollection }
	}
}