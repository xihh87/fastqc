<config.mk

results/%_fastqc.html:	data/%.fastq.gz
	DIR="`dirname $target`"
	mkdir -p "$DIR"
	fastqc $prereq -o "$DIR"
