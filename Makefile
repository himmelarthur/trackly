update:
	git checkout stable && git pull
	npm install .
	grunt
restart:
	forever stop app.js
	forever start app.js
up:
	make update restart
