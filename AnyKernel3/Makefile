NAME ?=  laurel

DATE := $(shell date "+%Y%m%d-%H%M")

CODE := 1.0

KERNELVERSION := $(shell cat ../Makefile | grep VERSION | head -n 1 | sed "s|.*=||1" | sed "s| ||g")

KERNELPATCHLEVEL := $(shell cat ../Makefile | grep PATCHLEVEL | head -n 1 | sed "s|.*=||1" | sed "s| ||g")

ZIP := $(NAME)-$(CODE)-$(DATE).zip

EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md*

normal: $(ZIP)

$(ZIP):
	@echo "Creating ZIP: $(ZIP)"
	@zip -r9 "$@" . -x $(EXCLUDE)
	@echo "Generating SHA1..."
	@sha1sum "$@" > "$@.sha1"
	@cat "$@.sha1"
	@echo "Done."


clean:
	@rm -vf *.zip*
	@rm -vf zImage
	@rm -vf Image*
	@echo "Cleaned Up."

