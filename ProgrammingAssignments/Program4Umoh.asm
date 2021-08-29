;TITLE: Program 4 Umoh

;DESCRIPTION: Performs a merge sort on two predefined lists, in ascending order.

INCLUDE Irvine32.inc

.data

listOne			DWORD  2,4,6,8,10,12,14			;holds input list number 1   
listOneSize	 =  ($-listOne)/4							;holds the size of list one

listTwo			DWORD  1,3,5,7,9,11,13,15		;holds input list number 2   
listTwoSize	 =  ($-listTwo)/4							;holds the size of list two

mergedListSize = listOneSize + listTwoSize				;the size of the merge list is = size of list 1 + size of list 2
mergedList		DWORD mergedListSize DUP (?)			;holds merged list

intro			BYTE "CPSC 232 - Merge Sorted Lists",0	;intro message
listString		BYTE "Input List: ",0					;input list message
mergeString		BYTE "Merged List: ",0					;merged list message
comma			BYTE ", ",0								;comma to separate list


.code
	
main PROC

;print intro message
	mov		edx, OFFSET intro						
	call	WriteString								;print intro message
	call	Crlf
	call	Crlf
	

	mov		edx, OFFSET listString					
	call	WriteString								;print "Input List: " followed by listOne

	mov		esi, 0									;move 0 to esi for indexing
	mov		ecx, listOneSize						;move size of list one to ecx for looping

;Print both lists
print_lists:
	L1:												;PRINT LIST ONE
	mov		eax, [listOne + esi]					;move the current element of listone to eax
	add		esi,4									;increment esi by 4 since the lists are DWORDs
	call	WriteDec				
	
	mov		edx, OFFSET comma						;write a comma to output
	call	WriteString
	loop	L1										;loop through whole array
	call	Crlf

next: 
	mov		edx, OFFSET listString					;print "Input List: " followed by listTwo
	call	WriteString

	mov		esi, 0									;move 0 to esi for indexing of list two
	mov		ecx, listTwoSize						;move size of list two to ecx for looping
	
	L2:												;PRINT LIST TWO
	mov		eax, [listTwo + esi]					;move the current element of list two to eax
	add		esi, 4									;increment esi by 4 since list two is a DWORD
	call	WriteDec						

	mov		edx, OFFSET comma						;write a comma to the output to separate
	call	WriteString
	loop	L2
	call	Crlf

;Combine the Two Lists into one Merged List
combine:
	mov		esi, 0									;move 0 to esi for indexing
	mov		ecx, listOneSize						;move size of the merged list to ecx for looping

	L11:											;Stores all of list one's elements in mergedList
	mov		eax, [listOne + esi]					;move the current element of listone to eax
	mov		mergedList[esi], eax					;move the current element to the mergedList
	add		esi,4									;increment esi by 4 since the lists are DWORDs
	loop	L11										;lOOP THROUGH ARRAY

	push	esi
	pop		ebx										;hold esi value
	
	mov		esi, 0									;move 0 to esi for indexing of list two	
	mov		ecx, listTwoSize						;move size of list two to ecx for looping
	
	L22:											
	mov		eax, [listTwo + esi]					;move the current element of list two to eax
	mov		mergedList[ebx], eax
	add		esi,4									;increment esi by 4 since list two is a DWORD				
	add		ebx,4
	loop	L22

results:
	call	merge									;sort lists
	call	printMergedList							;print out list
exit
main ENDP

;sort the merged list using a bubble sort
merge PROC
	
	mov		ecx, mergedListSize					;move the size of the list to ecx for looping
	dec		ecx									;implement arraySize - 1, the max amount of times the bubble sort will run

L1:												;implements outer loop: for(int i = 0; i<mergedListSize; i++)

	push 	ecx									;save count of the outer loop 
	mov		esi, OFFSET mergedList				;move the beginning address of the array to esi for indexing

L2:												;implements inner loop: for(int k = 0; k <mergedListSize-i; k++)

	mov		eax, [esi]							;store current element in eax
	cmp		[esi+4], eax						;compare the next element with eax

	jg 		no_swap								;if mergedList[i]<mergedList[i+1], don't swap
	xchg	eax, [esi+4]						;else, implement mergedlist[i]=mergedList[i+1]
	mov		[esi], eax							;move mergedList[i+1] into esi to start from there during the next loop
	
no_swap:										
	add		esi, 4								;increment esi
	loop	L2

	pop 	ecx									;restore outer loop count
	loop 	L1

return:
	ret
merge ENDP

;Print the Merged List
printMergedList PROC

	mov		edx, OFFSET mergeString				;print "Merged List: " followed by listOne and listTwo merged 
	call	WriteString

	mov		esi, 0								;move 0 to esi for indexing of list two
	mov		ecx, mergedListSize					;move size of list two to ecx for looping
	
	L3:											;PRINT Merged list
	mov		eax, [mergedList + esi]				;move the current element of merged list to eax
	add		esi,4								;increment esi by 4 since merged list is a DWORD
	call	WriteDec						

	mov		edx, OFFSET comma					;write a comma to the output to separate elements of the list
	call	WriteString
	loop	L3

	call	Crlf

	ret
printMergedList ENDP
	
END main

