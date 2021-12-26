TIL:

OSI as a networks trubleshooting map 
1. Physical layer
2. Channel layer
mac address 2digit pairs of hexadecimal numbers devices unique id
vlan 0-4096 number. used for local network segregation. default vlan 1 cannot be deleted
vxlan extended vlan up to 16mln+
vxlan also works on layers 2,3,4
3. network
routing - mechanism of IP blocks exchange
RoutingInformationProtocol outdated. Maks 15 routers. Broadcast - insecure
OSPF - open standard. Unlimited number of routers. Fast delivery of routing information
BorderGatewayProtocol - becomes popular, globally used. up to 700000 records in the border router devices tables
OSPF takes milliseconds. Much faster than BGP (1 minute min)
VXLAN - also routing protocol
MPLS - segment routing
4. Transport layer TCP/UDP
TCP used in 90% of cases. Assured packages delivery
UDP not assured
TCP also has more fields (headers) than UDP
5. Session layer. Manages connections and layers
6. Presentation
7. Application (HTTPS, HTTP, FTP)

Network as a code concept
