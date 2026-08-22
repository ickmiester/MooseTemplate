extends Node

var MultiplayerName:String = ""
var HostIP:String = ""
var HostPort:String = ""
var ReadyQuit:bool = false
#the time set for the level in the options screen
var LevelTime:float = 60.0

var Random = RandomNumberGenerator.new()

signal MultiplayerInfoChanged

func LoadScene(scene:Enums.Scenes):
	get_tree().change_scene_to_file(Refs.GetScene(scene))

func hostMultiplayer(name:String, port:String) -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port.to_int(), 32)
	multiplayer.multiplayer_peer = peer
	print("i'm a server")
	peer.peer_connected.connect(peerConnected)
	MultiplayerName = name;
	HostIP = "Local"
	HostPort = port
	LoadScene(Enums.Scenes.Chat)
	pass

func joinMultiplayer(name:String, port:String, ip:String) -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port.to_int())
	multiplayer.multiplayer_peer = peer
	print("i'm a client")
	peer.peer_connected.connect(clientPeerConnected)	
	MultiplayerName = name;
	HostIP = ip
	HostPort = port
	LoadScene(Enums.Scenes.Chat)
	pass
	
func peerConnected(id:int):
	print("peer connected: " + str(id))
	
func clientPeerConnected(id:int):
	print("I'm a client and I see peer connected: " + str(id))
	
func transferHost() -> void:
	print("transfering host")
	var peers:PackedInt32Array = multiplayer.get_peers()
	if(peers.size() < 1):
		return
	var nextHost = peers[0]
	var targetPeer:ENetPacketPeer = (multiplayer.multiplayer_peer as ENetMultiplayerPeer).get_peer(nextHost)
	var nextHostIP:String = targetPeer.get_remote_address()
	print("transfering host to " + str(nextHost) + " at " + nextHostIP)
	var newPort:int = HostPort.to_int()+1
	TakeHost.rpc_id(nextHost, newPort)
	print("host transferred")
	reJoin.rpc(nextHostIP, newPort)

@rpc("authority", "call_remote")
func TakeHost(port:int) -> void:
	print("Taking Host")
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port, 32)
	HostIP = "Local"
	HostPort = str(port)
	multiplayer.multiplayer_peer = peer
	print("i'm swapped from a client to a server")
	emit_signal("MultiplayerInfoChanged")
	peer.peer_connected.connect(peerConnected)
	

@rpc("authority", "call_remote")
func reJoin(ip:String, port:int) -> void:
	print("rejoining on" + ip + ":" + str(port))
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	multiplayer.multiplayer_peer = peer
	print("i'm rejoining as a client")
	peer.peer_connected.connect(clientPeerConnected)	
	HostIP = ip
	HostPort = str(port)
	emit_signal("MultiplayerInfoChanged")
	pass
