function socketList()
{
    socketdata=$(ss -s -f inet)
    tcpcount=$(echo $socketdata | head -2 | tail -1 | cut -d':' -f2)
    sockets=$(echo $socketdata | head -n +11)
    echo "Sockets TCP:$tcpcount"
    echo $sockets
}
