package discordAS.client.ws {

	import flash.net.SecureSocket;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.Endian;
	import com.adobe.net.URI;
	import flash.events.ProgressEvent;
	import utils.BinaryUtil;
	import flash.utils.ByteArray;
	import com.hurlant.crypto.tls.TLSSocket;
	import com.hurlant.util.Base64;
	import com.hurlant.crypto.tls.TLSSecurityParameters;
	import com.hurlant.crypto.tls.TLSConfig;
	import com.hurlant.crypto.tls.TLSEngine;
	import flash.events.Event;
	import discordAS.client.Client;
	import discordAS.event.WebSocketEvent;
	import flash.events.EventDispatcher;
	import flash.events.OutputProgressEvent;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;


	public class WebSocket extends EventDispatcher {
		
		private var _webSocket: WebSocket;
		private var _ver: String = "6";
		private var _enc = "json";
		private var _socket: Socket;
		private var _httpSocket: Socket;
		private var _secureWebSocket: TLSSocket;
		private var _cfg: TLSConfig;
		private var _u: URI;
		private var _secureSocket: SecureSocket;
		private var _res: String;
		private var _host: String;
		private var _port: int = 443;
		private var _b64n: String;
		private var _ve: String;
		private var _connected: Boolean = false;
		public function get connected(): Boolean {
			return _connected;
		}

		public function WebSocket(wws: String) {
			_u = new URI(wws + (_ve = "?v=" + _ver + "&" + "&encoding=" + _enc) + ":" + _port.toString());
			_host = _u.authority;
			_socket = new Socket();
			_cfg = new TLSConfig(TLSEngine.CLIENT);
			_cfg.trustAllCertificates = true;
			_cfg.ignoreCommonNameMismatch = true;

			_httpSocket = _socket = new Socket();
			_socket = _secureWebSocket = new TLSSocket();

			_httpSocket.addEventListener(Event.CONNECT, onConnect);
			_httpSocket.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			_httpSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);

			_socket.addEventListener(Event.CLOSE, handleSocketClose);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, incomingData);

			_httpSocket.connect(_host, _port);

			var query: String = "?" + _u.queryRaw;

			_res = "/" + query;
			var nonce: ByteArray = BinaryUtil.generateNonce();
			this._b64n = Base64.encodeByteArray(nonce);

			var scheme: String = _u.scheme.toLocaleLowerCase();

			_secureSocket = new SecureSocket();
			_secureSocket.timeout = 10000;
			_secureSocket.addEventListener(Event.CONNECT, onConnect);
		}

		public function send(message: Object): void {

			var payloadBytes: ByteArray = new ByteArray();
			payloadBytes.writeUTFBytes(JSON.stringify(message));
			var payload: Payload = new Payload(Payload.OUTGOING_PAYLOAD, null,payloadBytes , Payload.UTF_PAYLOAD);
			_socket.writeBytes(payload.frameBytes, 0, payload.frameBytes.length);
			_socket.flush()
		}

		private function handleSocketClose(e: Event): void {

		}

		private function incomingData(e: ProgressEvent): void {

			if (!_connected) {
				var handshakeData: String = e.currentTarget.readUTFBytes(e.currentTarget.bytesAvailable);
				parseHandshake(handshakeData);
				return;
			} else {
				print("Incoming Data");
				getFrameData(e.currentTarget as IDataInput);				
			}


		}

		private function getFrameData(iDataInput: IDataInput): void {
			var payload: Payload = new Payload(Payload.INCOMING_PAYLOAD, iDataInput);
			if(Payload._frameState==Payload.COMPLETE){
			var dataObject: Object;
			var dataRaw: String = Payload._incomingBytes.readUTFBytes(Payload._incomingBytes.length)
			dataObject = JSON.parse(dataRaw);
			
			this.dispatchEvent(new WebSocketEvent(WebSocketEvent.NEW_MESSAGE, dataObject.d, dataObject.op));
			}
		}

		private function parseHandshake(data: String): void {
			var header: Array = data.split("\r\n");
			for (var i: int = 0; i < header.length; i++) print(header[i].toString());
			if (header[2] === "Connection: upgrade") {
				_connected = true;
				print("WSS Handshake Successful");
			}

		}

		private function securityError(e: SecurityErrorEvent): void {
			print("SECURITYERROR");
		}

		private function ioError(e: IOErrorEvent): void {
			print("ERROR");
		}

		private function onConnect(e: Event): void {
			_secureWebSocket.startTLS(_httpSocket, _host, _cfg);
			_socket.endian = Endian.BIG_ENDIAN;
			wSSHandShake();
		}

		private function wSSHandShake(): void {
			var header: String = "" + "GET " + "/" + _ve + " HTTP/1.1\r\n" + "Host: " + _host + ":443" + "\r\n" + "Upgrade: websocket\r\n" + "Connection: Upgrade\r\n" + "Sec-WebSocket-Key: " + _b64n + "\r\n" + "Origin: *" + "\r\n" + "Sec-WebSocket-Version: 13\r\n" + "\r\n";
			_socket.writeUTFBytes(header);
			_socket.flush();
		}

	}

}