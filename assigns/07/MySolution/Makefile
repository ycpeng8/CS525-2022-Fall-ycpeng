######
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
######

test:: \
assign07_sol; ./assign07_sol

assign07_sol: \
assign07_sol.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.c
cleanall:: clean
cleanall:: ; rm -f assign07_sol

############ end of [Makefile] ############