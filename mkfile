<config.mk

results/%_fastqc.html:	data/%.fq.gz
	DIR="`dirname $target`"
	mkdir -p "$DIR"
	fastqc $prereq -o "$DIR" \
		--adapters config/adapter_list.txt \
		--limits config/limits.txt \
		-contaminants config/contaminant_list.txt

