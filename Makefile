CC ?= gcc
CFLAGS = -Wall -O2 -march=native -fopenmp
LDFLAGS = -lm -fopenmp -lpthread

all: main

THIRD_PARTIES = stb_image.h stb_image_write.h
stb_image.h:
	wget https://raw.githubusercontent.com/nothings/stb/master/stb_image.h
stb_image_write.h:
	wget https://raw.githubusercontent.com/nothings/stb/master/stb_image_write.h

OBJS = main.o
deps := $(OBJS:%.o=%.o.d)

%.o: %.c
	$(CC) -o $@ $(CFLAGS) -c -MMD -MF $@.d $<
main: $(THIRD_PARTIES) $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)

check: main
	$(RM) out.jpg
	./main jserv.jpg

clean:
	$(RM) main $(OBJS) $(deps)
	$(RM) out.jpg

distclean: clean
	$(RM) $(THIRD_PARTIES)

-include $(deps)
