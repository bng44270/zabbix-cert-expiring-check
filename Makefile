EDITOR = "vim"

define newsetting
@read -p "$(1) [$(3)]: " thisset ; [[ -z "$$thisset" ]] && echo "$(2) $(3)" >> $(4) || echo "$(2) $$thisset" | sed 's/\/$$//g' >> $(4)
endef

define getsetting
$$(grep "^$(2)[ \t]*" $(1) | sed 's/^$(2)[ \t]*//g')
endef

all: 
	@echo "Options:"
	@echo "      1) make edit -> edit list file"
	@echo "      2) make create -> create template"

create: clean build/certcheck.xml

edit:
	$(EDITOR) hostlist.txt

build/certcheck.xml: tmp/all-items.xml tmp/all-triggers.xml build
	m4 -DHOSTGROUP="$(call getsetting,tmp/settings.txt,GROUP)" -DZBXHOST="$(call getsetting,tmp/settings.txt,HOST)" -DALLITEMS="$$(cat tmp/all-items.xml)" -DALLTRIGGERS="$$(cat tmp/all-triggers.xml)" host.xml.m4 > build/certcheck.xml

tmp/all-items.xml: tmp/checklist.txt tmp tmp/settings.txt
	cat tmp/checklist.txt | while read line; do m4 -DCHECKINT="$(call getsetting,tmp/settings.txt,CHECKINT)" -DSITECN="$$(awk '{ print $$1 }' <<< "$$line")" -DSITEPORT="$$(awk '{ print $$2 }' <<< "$$line")" item.xml.m4 ; done > tmp/all-items.xml
	
tmp/all-triggers.xml: tmp/checklist.txt tmp tmp/settings.txt
	cat tmp/checklist.txt | while read line; do m4 -DSITECN="$$(awk '{ print $$1 }' <<< "$$line")" -DSITEPORT="$$(awk '{ print $$2 }' <<< "$$line")" -DZBXHOST="$(call getsetting,tmp/settings.txt,HOST)" -DCERTEXPIREAGE="$(call getsetting,tmp/settings.txt,CERTAGE)" trigger.xml.m4 ; done > tmp/all-triggers.xml

tmp/settings.txt: tmp
	$(call newsetting,Enter hostname in Zabbix,HOST,SSL-Checks,tmp/settings.txt)
	$(call newsetting,Enter Host Group name,GROUP,Hosts,tmp/settings.txt)
	$(call newsetting,Enter certificate age in days to alert on,CERTAGE,60,tmp/settings.txt)
	$(call newsetting,Enter check frequency in seconds,CHECKINT,3600,tmp/settings.txt)

tmp/checklist.txt: tmp
	grep -v '^#' hostlist.txt tmp/checklist.txt

tmp:
	mkdir tmp

build:
	mkdir build

clean:
	rm -rf tmp
	rm -rf build
