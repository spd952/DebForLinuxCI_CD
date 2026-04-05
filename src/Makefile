CXX = g++
CXXFLAGS = -std=c++11 -Wall

TARGET = hello
SRC_DIR = ./

all: bin   # больше не вызывает install

bin: $(SRC_DIR)/main.cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC_DIR)/main.cpp

install: bin
	mkdir -p $(DESTDIR)/usr/bin
	cp $(TARGET) $(DESTDIR)/usr/bin/
	chmod +x $(DESTDIR)/usr/bin/$(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all bin install clean
