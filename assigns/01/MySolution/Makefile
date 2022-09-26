######
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
######

test:: \
assign01_sol; ./assign01_sol

assign01_sol: \
assign01_sol.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.c
cleanall:: clean
cleanall:: ; rm -f assign01_sol

############ end of [Makefile] ############