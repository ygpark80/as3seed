package kr.reflexion.crypto.symmetric
{
	import com.hurlant.crypto.symmetric.IPad;
	
	import flash.utils.ByteArray;

	public class X923Padding implements IPad
	{
		private var blockSize:uint;
		
		public function X923Padding(blockSize:uint)
		{
			this.blockSize = blockSize;
		}

		public function pad(a:ByteArray):void
		{
			var paddingCnt:uint = a.length % this.blockSize;
			if (paddingCnt != 0) {
				var addPaddingCnt:uint = this.blockSize - paddingCnt;
				for (var i:int=0; i<addPaddingCnt; i++) {
					a[a.length] = 0x00;
				}
				
				a[a.length - 1] = addPaddingCnt;
			}
		}
		
		public function unpad(a:ByteArray):void
		{
			var isPadding:Boolean = false;
			
			var lastValue:int = a[a.length - 1];
			if (lastValue < (this.blockSize - 1)) {
				var zeroPaddingCount:uint = lastValue - 1;
				
				for (var i:int=2; i<(zeroPaddingCount + 2); i++) {
					if (a[a.length - i] != 0x00) {
						isPadding = false;
						break;
					}
				}
				
				isPadding = true;
			}
			
			if (isPadding) {
				for (var j:int=0; j<lastValue; j++) {
					a.length--;
				}
			}
		}
		
		public function setBlockSize(bs:uint):void
		{
			this.blockSize = bs;
		}
		
	}
}