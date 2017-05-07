CFLAGS += -std=gnu11 -g
EXES = test testip myTest trunc
OBJS = list.o test.o testip.o myTest.o trunc.o

all: $(EXES)

test:   test.o list.o
testip: testip.o list.o
myTest: myTest.o list.o
trunc: trunc.o list.o

clean:
	rm -f $(EXES) $(OBJS)
	rm -rf $(LIBS)
tidy:
	rm -f $(OBJS)
