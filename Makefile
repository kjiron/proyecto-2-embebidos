	# Make file to commit and pull git

GIT:
	git add .
	git commit -am "Traduciendo las funciones a SDL2"
	git push
PC:
	git stash
	git pull
