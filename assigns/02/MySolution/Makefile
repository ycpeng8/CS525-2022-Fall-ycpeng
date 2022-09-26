######
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
######

test:: \
assign02_sol; ./assign02_sol

assign02_sol: \
assign02_sol.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.c
cleanall:: clean
cleanall:: ; rm -f assign02_sol

############ end of [Makefile] ############