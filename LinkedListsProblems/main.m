//
//  main.m
//  Foundation
//
//  Created by Bharath G M on 7/4/14.
//  Copyright (c) 2014 Bharath G M. All rights reserved.
//

#import <Foundation/Foundation.h>

//represents NODE
struct node
{
    int data;
    struct node *next;
};
typedef struct node* NODE;

//adds a NODE to the front of a linked list
void push(struct node*  *head, int new_data)
{
    NODE new_node = (struct node*)malloc(sizeof(struct node));
    if (!new_node)
    {
        printf("Out of memory in Heap!");
    }
    else
    {
        new_node->data = new_data;
        new_node->next = *head;
        *head = new_node;
    }
}

//prints linked list
void printLinkList(struct node* head)
{
    if (head == NULL)
    {
        printf("Empty linked list");
    }
    else
    {
        while (head != NULL)
        {
            printf("\n %d----->",head->data);
            head = head->next;
        }
    }
}

//removes duplicates from UnsortedLinkedList
void removeDuplicatesFromUnsortedLinkedList(struct node* head)
{
    NODE current, previous, duplicate;
    previous = head;
    
    if (head == NULL)
    {
        return;
    }
    
    while (previous != NULL)
    {
        current = previous;
        while (current->next != NULL)
        {
            if (current->next->data == previous->data)
            {
                duplicate = current->next;
                current->next = current->next->next;
                free(duplicate);
            }
            else
            {
                current = current->next;
            }
        }
        previous = previous->next;
    }
    
}


//removes duplicates from UnsortedLinkedList using Objective C API
void removeDuplicatesFromUnsortedLinkedListUsingObjectiveCApi(struct node* head)
{
    NODE previous;
    //we can also use NSMutableDictionary
    NSMapTable *hashTable = [[NSMapTable alloc] init];
    previous = NULL;
    
    if (head == NULL)
    {
        NSLog(@"List is empty!!");
        return;
    }
    
    while (head != NULL)
    {
        if ([hashTable objectForKey:[NSString stringWithFormat:@"%d",head->data]])
        {
            previous->next = head->next;
        }
        else
        {
            [hashTable setObject:[NSNumber numberWithInt:head->data] forKey:[NSString stringWithFormat:@"%d",head->data]];
            previous = head;
        }
        head = head->next;
    }
    
}


//gets nth node from the end of a linked list
void getNthNode(struct node* head, int n)
{
    NODE p1, p2;
    p1 = head;
    p2 = head;
    int count = 0;
    if (head != NULL)
    {
        if (p2 == NULL)
        {
            NSLog(@"Exceeds bounds");
        }
        while (count < n)
        {
            p2 = p2->next;
            count++;
        }
        
    }
    while (p2 != NULL)
    {
        p2 = p2->next;
        p1 = p1->next;
    }
    printf(" \n  Node no. %d from last is %d ",n, p1->data);
    printLinkList(p1);
    
}

//splits linked list into two halves.
//If the length is odd, the extra node should go in the front list.
//Uses the fast/slow pointer strategy

void fronAndBackSplit(struct node* head, struct node** frontReference, struct node** backReference)
{
    struct node* source = head;
    struct node* slow = head;
    struct node* fast = source->next;
    if (source == NULL || source->next == NULL)
    {
        *frontReference = source;
        *backReference = NULL;
        return;
    }
    
    while (fast != NULL)
    {
        fast = fast->next;
        if (fast != NULL)
        {
            slow = slow->next;
            fast = fast->next;
        }
    }
    
    *frontReference = source;
    *backReference = slow->next;
    slow->next = NULL;
}

struct node* sortedMerge(struct node* a, struct node* b)
{
    struct node* result = NULL;
    if (a == NULL)
    {
        return b;
    }
    else if (b == NULL)
    {
        return a;
    }
    
    if (a->data <= b->data)
    {
        result = a;
        result->next = sortedMerge(a->next, b);
    }
    else if (b->data <= a->data)
    {
        result = b;
        result->next = sortedMerge(a, b->next);
    }
    
    return result;
}

//merge sort
void mergeSort(struct node **headReference)
{
    struct node *head = (*headReference);
    struct node *a;
    struct node *b;
    if (head == NULL || head->next == NULL)
    {
        return;
    }
    fronAndBackSplit(head, &a, &b);
    mergeSort(&a);
    mergeSort(&b);
    
    (*headReference) = sortedMerge(a, b);
    
}


int main(int argc, const char * argv[])
{
    
    @autoreleasepool
    {
        struct node* a = NULL;
        push(&a, 4);
        push(&a, 2);
        push(&a, 1);
        push(&a, 0);
        push(&a, 3);
        push(&a, 2);
        push(&a, 4);
        
        printf("Unsorted linked list: ");
        printLinkList(a);
        printf("\n Link list after removing duplicates \n");
        
        //       use one of the methods below to remove duplicates
        //       removeDuplicatesFromUnsortedLinkedList(a);
        
        //        gets the second node from the end of a linked list.
        
        
        removeDuplicatesFromUnsortedLinkedListUsingObjectiveCApi(a);
        getNthNode(a, 4);
        mergeSort(&a);
        
        printLinkList(a);

    }
    return 0;
}

