CFLAGS += -std=gnu11
EXES   =  stack q3
OBJS   =  stack.o q3.o list.o tree.o refcount.o

all: $(EXES)

stack: stack.o
q3: q3.o list.o tree.o refcount.o

clean:
	rm -f $(EXES) $(OBJS)
tidy:
	rm -f $(OBJS)