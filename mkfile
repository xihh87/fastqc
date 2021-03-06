<config.mk

results/%_fastqc.html \
results/%_fastqc.zip:	data/%.fastq.gz
	DIR="`dirname $target | sort -u`"
	mkdir -p "$DIR"
	fastqc $prereq -o "$DIR" \
		--adapters config/adapter_list.txt \
		--limits config/limits.txt \
		-contaminants config/contaminant_list.txt

results/%_fastqc_data.txt.Basic_Statistics \
results/%_fastqc_data.txt.Per_base_sequence_quality \
results/%_fastqc_data.txt.Per_tile_sequence_quality \
results/%_fastqc_data.txt.Per_sequence_quality_scores \
results/%_fastqc_data.txt.Per_base_sequence_content \
results/%_fastqc_data.txt.Per_sequence_GC_content \
results/%_fastqc_data.txt.Per_base_N_content \
results/%_fastqc_data.txt.Sequence_Length_Distribution \
results/%_fastqc_data.txt.Sequence_Duplication_Levels \
results/%_fastqc_data.txt.Overrepresented_sequences \
results/%_fastqc_data.txt.Adapter_Content \
results/%_fastqc_data.txt.Kmer_Content:	results/%_fastqc_data.txt
	bin/quality $prereq

results/%_fastqc_data.txt: results/%_fastqc.zip
	FILENAME="`basename $stem`"
	unzip -p $prereq $FILENAME"_fastqc/fastqc_data.txt" \
	> $target".build" \
	&& mv $target".build" $target

%.counts:	%/
	find $prereq \
		-type f \
		-name '*.Basic_Statistics' \
		-print0 \
	| xargs -0 bin/fastq-reads \
	> $target'.build' \
	&& mv $target'.build' $target
