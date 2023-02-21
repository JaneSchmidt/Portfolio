#include <stdio.h>
#include <stdio.h>
#include "file.h"
#include <sys/wait.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <unistd.h>
#define MAXBUFF 256
#include <time.h>
#include <sys/time.h>
#include <stdbool.h>

/**************************************************************
* gobackin c file - Jane Schmidt (schmija)
* CREATED: 12/1/2022
* 
* This is a program will be  
**************************************************************/

/* Add function definitions */
void gbn_server(char* iface, long port, FILE* fp) {
   int opt = 1, chat_sock = 0, bindNum;
   char rcvMessage[257], writeMessage[MAXBUFF], ack[1];

   //Specifying fields for getaddrinfo
   struct addrinfo *aiList = NULL, *ai, sock_addr;
   memset(&sock_addr, 0, sizeof(sock_addr));
   sock_addr.ai_family = AF_UNSPEC;
   sock_addr.ai_socktype = SOCK_DGRAM;
   sock_addr.ai_flags = AI_PASSIVE;
   sock_addr.ai_protocol = 0;
   sock_addr.ai_canonname = NULL;
   sock_addr.ai_addr = NULL;
   sock_addr.ai_next = NULL;

   //converts the port number to a long to be read by getaddrinfo
   char longPort[20];
   sprintf(longPort, "%ld", port);
   if(getaddrinfo(NULL, longPort, &sock_addr, &aiList) < 0){
      perror("getaddrinfo");
   }

   //setting the timeout for recv() 
   struct timeval tv = {
      .tv_usec = 600000
   };

   //iterating through the list of address structures returned by getaddrinfo
   //to find an addr struct that we are able to bind to 
   //sets socket options to reuse addr and to timeout the rcv() func
   for(ai = aiList; ai != NULL; ai = ai->ai_next){
      if((chat_sock = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol)) == -1){
         perror("socket");
         abort();
      }
      if (setsockopt(chat_sock, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(int)) < 0){
         perror("setsockopt");
      }
      if (setsockopt(chat_sock, SOL_SOCKET, SO_RCVTIMEO, (struct timeval *)&tv, sizeof(struct timeval)) < 0){
         perror("setsockopt");
      }
      if((bindNum = bind(chat_sock, ai->ai_addr, ai->ai_addrlen)) < 0){
         perror("bind");
      }
      break;
   }

   freeaddrinfo(aiList);

   //ack is the acknowledgment number sent by the client 
   ack[0] = 0;
   while(1){
      if(ack[0] == 20){
         ack[0] = 0;
      }
      int size = 0;
      memset(rcvMessage, 0, 257);
      memset(writeMessage, 0, MAXBUFF);
      
      //checks the size of the package sent by client
      //if size is zero send an ack to the client and close the socket 
      //if size is >0 and the package contains the correct ack, write to the file 
      for(int i = 0; i < 5; i++){
	 if((size = recvfrom(chat_sock, rcvMessage, 257, 0, ai->ai_addr, &ai->ai_addrlen))< 0){
	    continue;
         }
	 if(rcvMessage[0] == ack[0] && size > 0){
	    size--;
            for(int i = 0; i < size; i++){
               writeMessage[i] = rcvMessage[i+1];
	    }
            fwrite(writeMessage, 1, size, fp);
            ack[0]++;
	 }
	 if(size == 0){
	    if(sendto(chat_sock, "done", 4, 0, ai->ai_addr, ai->ai_addrlen) < 0){
               perror("sendto");
            }
	    close(chat_sock);
	    return;
	 }
	 else if(size < 256){
	    break;
	 }
      }
      //send last correct ack recieved to client 
      if(sendto(chat_sock, ack, 1, 0, ai->ai_addr, ai->ai_addrlen) < 0){
         perror("sendto");
      }
   }
}

void gbn_client(char* host, long port, FILE* fp) {
   char buffer[20][MAXBUFF], sendMessage[257], rcvMessage[10];
   int client_sock = 0, opt = 1;
   struct addrinfo *aiList = NULL, *ai, sock_addr;
   memset(&sock_addr, 0, sizeof(sock_addr));
   sock_addr.ai_family = AF_INET;
   sock_addr.ai_socktype = SOCK_DGRAM;
   sock_addr.ai_flags = AI_PASSIVE;
   sock_addr.ai_protocol = 0;
   sock_addr.ai_canonname = NULL;
   sock_addr.ai_addr = NULL;
   sock_addr.ai_next = NULL;

   char longPort[20];
   sprintf(longPort, "%ld", port);
   if(getaddrinfo(host, longPort, &sock_addr, &aiList) < 0){
      perror("getaddrinfo");
   }

   struct timeval tv = {
      .tv_usec = 600000
   };

   for(ai = aiList; ai != NULL; ai = ai->ai_next){
      if((client_sock = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol)) == -1){
         perror("socket");
         abort();
      }
      if (setsockopt(client_sock, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(int)) < 0){
         perror("setsockopt");
      }
      if (setsockopt(client_sock, SOL_SOCKET, SO_RCVTIMEO, (struct timeval *)&tv, sizeof(struct timeval)) < 0){
         perror("setsockopt");
      }
      break;
   }

   freeaddrinfo(aiList);

   while(1){
      bool end = false;
      int size = 0, ptr1 = 0, ptr2 = 5, endOfFile = 30;
      for(int i = 0; i<20; i++){
         memset(buffer[i], 0, MAXBUFF);
      }
      memset(sendMessage, 0, 257);
      memset(rcvMessage, 0, 10);
      size = 0;

      //reads in 20 packets of 256 words to the buffer 
      //takes note of the eof 
      for(int i = 0; i < 20; i++){
          if((size = fread(buffer[i], 1, 256, fp)) < 0){
             perror("fread");
	  }
	  if(size < 256 && size > 0){
	     endOfFile = i;
	     size++;
	     break;
	  }
	  else if(size == 0){
	     size = 257;
	     endOfFile = i-1;
	     break;
	  }
      }

      while(1){
	 if(ptr1 == 20){
	    break;
	 }
         
         //sends 5 packets at a time to server 
         for(int j = ptr1; j < ptr2 && j < 20; j++){
	    if(j == endOfFile){
	       end = true;
	       for(int i = 1; i <= size; i++){
                  sendMessage[i] = buffer[j][i-1];
               }
	       sendMessage[0] = j;
	       if(sendto(client_sock, sendMessage, size, 0, ai->ai_addr, ai->ai_addrlen) < 0){
                  perror("sendto");
               }
	       break;
	    }
	    else{
               for(int i = 1; i <= 256; i++){
                  sendMessage[i] = buffer[j][i-1];
               }
	       sendMessage[0] = j;
	       if(sendto(client_sock, sendMessage, 257, 0, ai->ai_addr, ai->ai_addrlen) < 0){
                  perror("sendto");
               }
	    }
	 }

         //checks the ack sent by the server, sets ptrs to the correct pakcet number 
         //accounts for lost or corrupted packets
	 if(recvfrom(client_sock, rcvMessage, 1, 0, ai->ai_addr, &ai->ai_addrlen)< 0){
            continue;
         } else{
	    ptr1 = rcvMessage[0];
	    ptr2 = ptr1+5;
	 } 
         //sends empty message to signify eof, closes socket 
	 if(end == true && ptr1 == endOfFile+1){
            while(1){
               if(sendto(client_sock, "", 0, 0, ai->ai_addr, ai->ai_addrlen) < 0){
                  perror("sendto");
               }
               if(recvfrom(client_sock, rcvMessage, 1, 0, ai->ai_addr, &ai->ai_addrlen)< 0){
                  continue;
               }
               if(rcvMessage[0] == 'd'){
                  close(client_sock);
                  return;
               }
            }
         }
      }
   }
}


