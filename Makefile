# careful with slash in the end (don't put one), it won't match //ext then further down
VKDT=../vkdt
# prune bin/ tmp/ ext/ (bin would be sorted first and then destroy VPATH)
VKDT_MD_FILES:=$(shell find $(VKDT) -path $(VKDT)/bin -prune -false -o -path $(VKDT)/tmp -prune -false -o -path $(VKDT)/ext -prune -false -o -name "*.md")
LOCAL_MD_FILES:=$(shell find . -name "*.md")
VKDT_HTML_FILES:=$(patsubst $(VKDT)/%.md, %.html, $(VKDT_MD_FILES))
LOCAL_HTML_FILES:=$(patsubst %.md, %.html, $(LOCAL_MD_FILES))

all: $(VKDT_HTML_FILES) $(LOCAL_HTML_FILES)

VPATH=$(dir $(VKDT_MD_FILES))

%.html: %.md Makefile conv.sh
	@mkdir -p "$(@D)"
	@echo convert local "$<" to "$@"
	$(shell ./conv.sh $< $@)

clean:
	rm -f $(VKDT_HTML_FILES)
	rm -f $(LOCAL_HTML_FILES)
