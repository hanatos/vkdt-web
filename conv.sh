#!/bin/bash

# convert one md to one html
MD=$1
HTML=$2

TOP=$(realpath --relative-to=$(dirname ${HTML}) $(pwd))
STYLE=${TOP}/style.css

LEDE=$(echo ${HTML} | sha1sum)
LEDE=${LEDE:0:8}
LEDE=$(( 16#${LEDE} ))
LEDE=$(( (LEDE+1)%21 ))
LIND=$(printf "%02d" $LEDE)

# prepend header
cat > ${HTML} << EOF
<!DOCTYPE html>
<html>
<head>
<link rel=stylesheet type="text/css" href="${STYLE}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<div class="lede" style="background-image:url('${TOP}/lede_${LIND}.jpg')"></div>
<div class="nav">
<a href="#">top</a><br/>
<a href="${TOP}/readme.html">home</a><br/>
<a href="${TOP}/index.html">about</a><br/>
<a href="https://github.com/hanatos/vkdt">git</a><br/>
</div>
<div class="ledespace"></div>
<div class="body">
<a href="${TOP}/readme.html">home</a> | <a href="${TOP}/index.html">about</a> | <a href="https://github.com/hanatos/vkdt">git</a>
EOF

# run through markdown
markdown ${MD} >> ${HTML}

# append footer
cat >> ${HTML} << EOF
<div class="foot">$(date +"%B %Y")</div>
</div>
</body>
</html>
EOF

# repoint links to md to point to html now:
sed -i -e 's/href="\(.*\).md"/href="\1.html"/g' ${HTML}
