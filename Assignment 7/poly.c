#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*
 * Class Person
 */

struct Person_class {
    void*   super;
    void (* toString) (void*, char*, int);
};

struct Person {
    struct Person_class* class;
    char* name;
};

void Person_toString (void* thisv, char* buf, int bufSize){
    struct Person* this = thisv;
    snprintf(buf, bufSize, "Name: %s", this->name);
}

struct Person_class Person_class_obj = {NULL, Person_toString};

struct Person* new_Person(char* name) {
    struct Person* obj = malloc (sizeof (struct Person));
    obj->class = &Person_class_obj;
    obj->name = strdup(name);
    return obj;
}


/*
 * Class Student extends Person
 */

struct Student_class {
    struct Person_class* super;
    void (* toString) (void*, char*, int);
};

struct Student {
    struct Student_class* class;
    char* name;
    int sid;
};


void Student_toString (void* thisv, char* buf, int bufSize){
    struct Student* this = thisv;
    char str[bufSize];
    this->class->super->toString(this, str, bufSize);
    snprintf(buf, bufSize, "%s, SID: %i", str, this->sid); 
}

struct Student_class Student_class_obj = {&Person_class_obj, Student_toString};

struct Student* new_Student(char* name, int sid) {
    struct Student* obj = malloc (sizeof (struct Student));
    obj->class = &Student_class_obj;
    obj->name = strdup(name);
    obj->sid = sid;
    return obj;
}


/*
 * Main
 */

void print (struct Person* p){
        
    char buf[200];
    p->class->toString(p, buf, sizeof(buf));
    printf("%s\n", buf);
}

int main (int argc, char** argv) {
    
    struct Person* people[] = {new_Person("Alex"), (struct Person *) new_Student("Alice", 300)};
    for(int i = 0; i < 2; i++)
        print(people[i]);
}

















