MODULES=hashtable
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES:=.ml)
MLIS=$(MODULES:=.mli)
TEST=test.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind
PKGS=oUnit

default: build
	utop

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) -tag debug $(TEST) && ./$(TEST)