# Makefile for source rpm: ntfs-kmod
# $Id: Makefile,v 1.2 2008/09/30 17:05:40 thl Exp $
NAME := kmodtool
SPECFILE = $(firstword $(wildcard *.spec))

define find-makefile-common
for d in common ../common ../../common ../../../common ; do if [ -f $$d/Makefile.common ] ; then if [ -f $$d/.svn/entries -a -w $$/Makefile.common ] ; then cd $$d ; svn -q update ; fi ; echo "$$d/Makefile.common" ; break ; fi ; done
endef

MAKEFILE_COMMON	:= $(shell $(find-makefile-common))

ifeq ($(MAKEFILE_COMMON),)
# attept a checkout
define checkout-makefile-common
test -f .svn/entries && { svn -q checkout $$(svn info |grep '^URL :'|cut -d' ' -f 3|cut -d/ -f -4)/common && echo "common/Makefile.common" ; } || { echo "ERROR: I can't figure out how to checkout the 'common' directory module." ; exit -1 ; } >&2
endef

MAKEFILE_COMMON := $(shell $(checkout-makefile-common))
endif

include $(MAKEFILE_COMMON)
