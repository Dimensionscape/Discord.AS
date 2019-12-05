//Web Socket Frame Structure
// +-+-+-+-+-------+-+-------------+-------------------------------+
//  0                   1                   2                   3
//  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
// +-+-+-+-+-------+-+-------------+-------------------------------+
// |F|R|R|R| opcode|M| Payload len |    Extended payload length    |
// |I|S|S|S|  (4)  |A|     (7)     |             (16/64)           |
// |N|V|V|V|       |S|             |   (if payload len==126/127)   |
// | |1|2|3|       |K|             |                               |
// +-+-+-+-+-------+-+-------------+ - - - - - - - - - - - - - - - +
// |     Extended payload length continued, if payload len == 127  |
// + - - - - - - - - - - - - - - - +-------------------------------+
// |                               | Masking-key, if MASK set to 1 |
// +-------------------------------+-------------------------------+
// | Masking-key (continued)       |          Payload Data         |
// +-------------------------------- - - - - - - - - - - - - - - - +
// :                     Payload Data continued ...                :
// + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
// |                     Payload Data continued ...                |
// +---------------------------------------------------------------+

package discordAS.client.ws {
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.IDataInput;

	public class Payload {
		internal static const READING: String = "reading";
		internal static const WAITING: String = "waiting";
		internal static const WRITING: String = "writing";
		internal static const COMPLETE: String = "complete";
		internal static const CONTINUE_PAYLOAD: uint = 0x00;
		internal static const UTF_PAYLOAD: uint = 0x01;
		internal static const BINARY_PAYLOAD: uint = 0x02;
		internal static const CLOSE_CONNECTION: uint = 0x08;
		internal static const PING: uint = 0x09;
		internal static const PONG: uint = 0x0a;
		internal static var _frameState: String = COMPLETE;
		internal static var _incomingBytes: ByteArray;
		internal static var _outgoingBytes: ByteArray;
		internal static var _incominglength: int;
		public static const INCOMING_PAYLOAD: String = "incomingPayload";
		public static const OUTGOING_PAYLOAD: String = "outgoingPayload";

		private var _frameBytes: ByteArray;
		private var _fin: Boolean = true;
		private var _rsv1: Boolean = false;
		private var _rsv2: Boolean = false;
		private var _rsv3: Boolean = false;
		private var _mask: Boolean = true;
		private var _length: int;

		private var _tempMask: Vector.<uint> = new Vector.<uint>(4);

		public function get frameBytes(): ByteArray {
			return _frameBytes;
		}
		public function Payload(type: String, iDataInput: IDataInput, data: ByteArray = null, op: uint = -1) {

			if (type == INCOMING_PAYLOAD) {
				if (_frameState === COMPLETE) _incomingBytes = new ByteArray();
				parseFrame(iDataInput);
			} else if (type == OUTGOING_PAYLOAD) {
				_frameBytes = new ByteArray();
				_length = data.length;
				data.endian = Endian.BIG_ENDIAN;
				data.position = 0;


				var firstByte: int = 0x00;
				var secondByte: int = 0x00;
				if (_fin) {
					firstByte |= 0x80;
				}
				if (_rsv1) {
					firstByte |= 0x40;
				}
				if (_rsv2) {
					firstByte |= 0x20;
				}
				if (_rsv3) {
					firstByte |= 0x10;
				}
				if (_mask) {
					secondByte |= 0x80;
				}

				firstByte |= (op & 0x0F);

				if (_length <= 125) {
					secondByte |= (_length & 0x7F);
				} else if (_length > 125 && _length <= 0xFFFF) {
					secondByte |= 126;
				} else if (_length > 0xFFFF) {
					secondByte |= 127;
				}
				_frameBytes.writeByte(firstByte);
				_frameBytes.writeByte(secondByte);


				if (_length > 125 && _length <= 65535) {
					_frameBytes.writeShort(_length);
				} else if (_length > 65535) {
					_frameBytes.writeUnsignedInt(0x00000000);
					_frameBytes.writeUnsignedInt(_length);
				}

				var maskKey: uint = Math.ceil(Math.random() * 0xFFFFFFFF);
				_tempMask[0] = (maskKey >> 24) & 0xFF;
				_tempMask[1] = (maskKey >> 16) & 0xFF;
				_tempMask[2] = (maskKey >> 8) & 0xFF;
				_tempMask[3] = maskKey & 0xFF;

				_frameBytes.writeUnsignedInt(maskKey);

				var j: int = 0;

				var remaining: uint = data.bytesAvailable;
				while (remaining >= 4) {
					_frameBytes.writeUnsignedInt(data.readUnsignedInt() ^ maskKey);
					remaining -= 4;
				}
				while (remaining > 0) {
					_frameBytes.writeByte(data.readByte() ^ _tempMask[j]);
					j += 1;
					remaining -= 1;
				}
				_frameBytes.position = 0;
			}

		}


		private function parseFrame(data: IDataInput): void {
			if (_frameState == COMPLETE) {
				var packetLength: int = 7;
				var firstByte: int = data.readByte();
				var secondByte: int = data.readByte();

				var fin = Boolean(firstByte & 0x80);
				var rsv1 = Boolean(firstByte & 0x40);
				var rsv2 = Boolean(firstByte & 0x20);
				var rsv3 = Boolean(firstByte & 0x10);
				var mask = Boolean(secondByte & 0x80);

				var opcode = firstByte & 0x0F;
				_incominglength = secondByte & 0x7F;

				if (_incominglength == 126) packetLength = 16;
				else if (_incominglength == 127) packetLength = 64;


				if (packetLength == 16) {
					if (data.bytesAvailable >= 2) {
						_incominglength = data.readUnsignedShort();
					}
				} else if (packetLength == 64) {
					if (data.bytesAvailable >= 8) {
						print("AS3 doesn't support 64 bit Integers");
						//Discord doesnt send frames this large. 
						//If this somehow becomes a necessity, I will add BigNums.
					}
				}

			}

			if (data.bytesAvailable >= _incominglength) {
				_frameState = COMPLETE;
				_incomingBytes.endian = Endian.BIG_ENDIAN;
				data.readBytes(_incomingBytes, 0, _incominglength);
				_incomingBytes.position = 0;
				return;
			}

			if (data.bytesAvailable < _incominglength) {
				_frameState = WAITING;
			}


		}

	}

}