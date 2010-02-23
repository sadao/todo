/*
タイムライン 情報を管理するクラスです
*/
package cache {
    public class TimeLine extends cache.Base {
	import flash.net.SharedObject

        // コンストラクタ
        private static const TIMELINE_PATH:String = 'memory__timeline'
		public function TimeLine () { super(TIMELINE_PATH) }

		// [登録] タイムラインID
		public function setID (timeline_id:String) : void { getCache().data.timeline_id = timeline_id }

		// [取得] タイムラインID
		public function getID () : String { return (getCache().data.timeline_id) ? getCache().data.timeline_id : new String }

		// [登録] タイムラインAPI KEY
		public function setApiKey (timeline_api_key:String) : void { getCache().data.timeline_api_key = timeline_api_key }

		// [取得] タイムラインAPI KEY
		public function getApiKey () : String { return (getCache().data.timeline_id) ? getCache().data.timeline_api_key : new String }
	}
}