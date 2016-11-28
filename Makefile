PLATFORM=-linux-i32
SWIPL=swipl
SOLVERS=solvers/booleans.cat solvers/comparisons.cat solvers/fd.cat solvers/graphs.cat solvers/leq.cat solvers/min.cat solvers/rational_tree.cat solvers/union_find.cat

all: bin/chrat bin/chrat-top

clean:
	- rm bin/chrat bin/chrat-top

bin/chrat: src/chrat.chr
	mkdir -p bin
	$(SWIPL) -o bin/chrat -G35M -g main -c src/chrat.chr

src/chrat-top.chr: bin/chrat src/chrat-top.cat src/toplevel-tools.cat src/transformation.cat src/common.cat $(SOLVERS)
	bin/chrat -o src/chrat-top.chr src/chrat-top.cat $(SOLVERS)

bin/chrat-top: src/chrat-top.chr
	$(SWIPL) -o bin/chrat-top -g \''chrat-top:main'\' -c src/chrat-top.chr

src/chrat-online.chr: bin/chrat src/chrat-online.cat src/toplevel-tools.cat src/transformation.cat src/common.cat $(SOLVERS)
	bin/chrat -o src/chrat-online.chr src/chrat-online.cat $(SOLVERS)

bin/chrat-online: src/chrat-online.chr
	$(SWIPL) -o bin/chrat-online -g \''chrat-online:main'\' -c src/chrat-online.chr
