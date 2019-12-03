package utils {
	import flash.utils.ByteArray;

	public class BinaryUtil {
		public static function generateNonce(): ByteArray {
			var nonce:ByteArray = new ByteArray();
			for (var i: int = 0; i < 16; i++) {
				nonce.writeByte(Math.round(Math.random() * 0xFF));
			}
			nonce.position = 0;
			return nonce;
		}

	}

}