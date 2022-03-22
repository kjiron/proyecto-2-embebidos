	# Make file to commit and pull git

GIT:
	git add .
	git commit -am "Creando el ambiente en SDL2"
	git push
PC:
	git stash
	git pull
