#!/bin/bash

# careful with slash in the end, it won't match //ext then further down
VKDT=../vkdt

# find all md files
for file in $(find ${VKDT} -path ${VKDT}/ext -prune -false -o -name "*.md")
do

OUT0=${file%.md}.html
OUT1=${OUT0#$VKDT}
OUT2=${OUT1#/}
echo $OUT2

# create directory if necessary
mkdir -p $(dirname $OUT2)

TOP=$(realpath --relative-to=$(dirname ${OUT2}) $(pwd))
STYLE=${TOP}/style.css

# prepend header
cat > ${OUT2} << EOF
<!DOCTYPE html>
<html>
<head>
<link rel=stylesheet type="text/css" href="${STYLE}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<div class="lede" style="background-image:url('${TOP}/lede00.jpg')"></div>
<div class="ledespace"></div>
<div class="body">
<a href="${TOP}/readme.html">home</a> | <a href="https://github.com/hanatos/vkdt">git</a>
EOF

# run through markdown
markdown ${file} >> ${OUT2}

# append footer
cat >> ${OUT2} << EOF
</div>
</body>
</html>
EOF

# repoint links to md to point to html now:
sed -i -e 's/href="\(.*\).md"/href="\1.html"/g' ${OUT2}

done
