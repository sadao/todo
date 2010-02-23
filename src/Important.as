/*
重要度を管理するクラスです
*/
package {
	public class Important {
		import mx.controls.RadioButton

		// 定数
		private static const IMPORTANT_MAXIMUM:String = 'maximum' 
		private static const IMPORTANT_MIDDLE:String  = 'middle' 
		private static const IMPORTANT_MINIMUM:String = 'minimum' 

		// コンストラクタ
		private var _importantString:Object
		public function Important (importantString:Object) { _importantString = importantString }

		// 重要度を判定します
		public function isImportantMaximum():Boolean	{ return (_importantString == IMPORTANT_MAXIMUM)	?	true : false }
		public function isImportantMiddle():Boolean		{ return (_importantString == IMPORTANT_MIDDLE)		?	true : false }
		public function isImportantMinimum():Boolean	{ return (_importantString == IMPORTANT_MINIMUM) 	?	true : false }
	}
}