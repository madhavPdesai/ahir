#include <iostream>
#include <pthread.h>
#include <arpa/inet.h>
#include <linux/if_packet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <net/if.h>
#include <netinet/ether.h>
#include "timer.h"

using namespace std;

 
#define MY_DEST_MAC0 0x00
#define MY_DEST_MAC1 0x0a
#define MY_DEST_MAC2 0x35
#define MY_DEST_MAC3 0x02
#define MY_DEST_MAC4 0x49
#define MY_DEST_MAC5 0xba
 
#define DEFAULT_IF "eth0"
#define BUF_SIZ 512 
#define DATA_SIZ 128




int beginSend = 0;
int numPacks = 4096; 


void * sender_fxn( void * ) 
{
	while(!beginSend){;} 
	int sockfd;
	// ifreq - interface request for ioctl commands in net/if.h
	// ifr name and union (one of addr, dest_addr, broad_addr, data, value)
	struct ifreq if_idx;
	struct ifreq if_mac;
	int tx_len = 0;
	unsigned char sendbuf[BUF_SIZ];
	unsigned char recvbuf[BUF_SIZ];
	struct ether_header *eh = (struct ether_header *) sendbuf;
	struct iphdr *iph = (struct iphdr *) (sendbuf + sizeof(struct ether_header));
	struct sockaddr_ll socket_address;
	char ifName[IFNAMSIZ]; //16
	GET_TIME_INIT(4);
	/* Get interface name */
	strcpy(ifName, DEFAULT_IF);
	 
	/* Open RAW socket to send on */
	// sockfd is the file descriptor for new socket//
	if ((sockfd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL))) == -1) 
	{
		perror("socket");
	}
	 
	/* Get the index of the interface to send on */
	memset(&if_idx, 0, sizeof(struct ifreq));
	strncpy(if_idx.ifr_name, ifName, IFNAMSIZ-1);
	//retrieveing the interface index of interface for the socket opened above i.e. eth0//
	if (ioctl(sockfd, SIOCGIFINDEX, &if_idx) < 0) //ioctl manipulates underlying device parameters of special files  with sockfd as descriptor
	{
		perror("SIOCGIFINDEX");
	}
	/* Get the MAC address of the eth0 interface */
	memset(&if_mac, 0, sizeof(struct ifreq));
	strncpy(if_mac.ifr_name, ifName, IFNAMSIZ-1);
	if (ioctl(sockfd, SIOCGIFHWADDR, &if_mac) < 0) 
	{
		perror("SIOCGIFHWADDR");
	} 
	/* Construct the Ethernet header */
	memset(sendbuf, 0, BUF_SIZ);
	/* Ethernet header */
	eh->ether_shost[0] = ((uint8_t *)&if_mac.ifr_hwaddr.sa_data)[0];
	eh->ether_shost[1] = ((uint8_t *)&if_mac.ifr_hwaddr.sa_data)[1];
	eh->ether_shost[2] = ((uint8_t *)&if_mac.ifr_hwaddr.sa_data)[2];
	eh->ether_shost[3] = ((uint8_t *)&if_mac.ifr_hwaddr.sa_data)[3];
	eh->ether_shost[4] = ((uint8_t *)&if_mac.ifr_hwaddr.sa_data)[4];
	eh->ether_shost[5] = ((uint8_t *)&if_mac.ifr_hwaddr.sa_data)[5];
	eh->ether_dhost[0] = MY_DEST_MAC0;
	eh->ether_dhost[1] = MY_DEST_MAC1;
	eh->ether_dhost[2] = MY_DEST_MAC2;
	eh->ether_dhost[3] = MY_DEST_MAC3;
	eh->ether_dhost[4] = MY_DEST_MAC4;
	eh->ether_dhost[5] = MY_DEST_MAC5;
	/* Ethertype field */
	eh->ether_type = htons(0x0800); // host to network byte order (big endian)
					// ether type indicates the ipv4 protocol being used here
	tx_len += sizeof(struct ether_header);
	int index;
	/* Packet data */
	while (tx_len < BUF_SIZ)
	{
		sendbuf[tx_len++] = 0xef;
	} 
	/* Index of the network device */
	socket_address.sll_ifindex = if_idx.ifr_ifindex;
	/* Address length*/
	socket_address.sll_halen = ETH_ALEN;
	/* Destination MAC */
	socket_address.sll_addr[0] = MY_DEST_MAC0;
	socket_address.sll_addr[1] = MY_DEST_MAC1;
	socket_address.sll_addr[2] = MY_DEST_MAC2;
	socket_address.sll_addr[3] = MY_DEST_MAC3;
	socket_address.sll_addr[4] = MY_DEST_MAC4;
	socket_address.sll_addr[5] = MY_DEST_MAC5;
	int sendBytes;
	GET_TIME_VAL(0);
	for (index=0; index<numPacks; index++){ 	
	/* Send packet */
//	while(!beginSend){;} 
		sendBytes = sendto(sockfd, sendbuf, tx_len, 0, (struct sockaddr*)&socket_address, sizeof(struct sockaddr_ll));
	      	if (sendBytes==-1){
			printf("error in transmission\n");
			exit(1);
	      	}
//		beginSend = 0;
	}
	GET_TIME_VAL(1);
	double dataSent = (BUF_SIZ-12)*numPacks;
	double timeTaken = (TIME_VAL_TO_MS(1)-TIME_VAL_TO_MS(0));
	printf("sending %f bytes data bw: %f MB/s in %fms \n", dataSent, (dataSent*1000)/(timeTaken*1024*1024), TIME_VAL_TO_MS(1)-TIME_VAL_TO_MS(0));
	for (index=0; index<sendBytes; index++)
	{
		printf("%02x ", sendbuf[index]);
	}
	printf("\n");
}


void * receiver_fxn( void * ) {

	struct sockaddr_in si_other, si_myself;
	int s, i;
	socklen_t slen=sizeof(si_other);
	unsigned char recvbuf[BUF_SIZ];
	int numbytes;
	int index;
//	GET_TIME_INIT(2);
	GET_TIME_INIT(4);
	
	if ((s=socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)))==-1)
	{
	    perror("socket");
	    exit(1);
	}
	
	
	listen(s, 1); // 1 specifies the length of queue (queue of number of devices trying to connect to that socket//
	beginSend = 1;
	GET_TIME_VAL(2);
	for (index=0; index<numPacks; index++) 
	{
		numbytes = recvfrom(s, (char *)recvbuf, BUF_SIZ, 0, NULL, NULL);
		numbytes = recvfrom(s, (char *)recvbuf, BUF_SIZ, 0, NULL, NULL);
	  	if (numbytes==-1)
		{
	    		printf("error in receive\n");
	    		exit(1);
	  	}
//	  	beginSend = 1;
	} 
	GET_TIME_VAL(3);	
	close(s);
	double dataSent = (BUF_SIZ-12)*numPacks;
	double timeTaken = (TIME_VAL_TO_MS(3)-TIME_VAL_TO_MS(2));
	printf("receiving %f bytes data bw: %f MB/s in %fms \n", dataSent, (dataSent*1000)/(timeTaken*1024*1024), TIME_VAL_TO_MS(3)-TIME_VAL_TO_MS(2));
	for (index=0; index<numbytes; index++)
	{
		printf("%02x ", recvbuf[index]);
	}
	printf("\n");
}


int main( int argc, const char** argv ) {

    pthread_t sender; 
    pthread_t receiver; 
    pthread_create(&sender, NULL, sender_fxn, NULL);
    pthread_create(&receiver, NULL, receiver_fxn, NULL);
    pthread_join(sender, NULL);
    pthread_join(receiver, NULL);

    return 0;
}

