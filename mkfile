<fastqc.mk

FASTQC_TARGETS=`{find -L data/ -name '*.fastq' -o -name '*.fastq.gz' \
	| sed -e 's#data/#results/fastqc/#g' \
		-e 's#.fastq\(\.gz\)\?$#_fastqc.html#g' }

fastqc:V: $FASTQC_TARGETS

data/%.fastq:	data/%.fastq.gz
	gzip -d -c $prereq > $target

results/fastqc/%_fastqc.html:	data/%.fastq
	DIR=`dirname $target`
	mkdir -p $DIR
	fastqc $prereq -o $DIR
