######
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
######

test:: \
assign06_sol; ./assign06_sol

assign06_sol: \
assign06_sol.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.c
cleanall:: clean
cleanall:: ; rm -f assign06_sol

############ end of [Makefile] ############