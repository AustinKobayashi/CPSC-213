CFLAGS += -std=gnu11 -g
EXES = sm sm-jt
OBJS = sm.o sm-jt.o

all: $(EXES)

sm: sm.o
sm-jt: sm-jt.o

clean:
	rm -f $(EXES) $(OBJS)

tidy:
	rm -f $(OBJS)
