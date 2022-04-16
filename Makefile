	# Make file to commit and pull git

GIT:
	git add .
	git commit -am "Actualizando el juego en SDL"
	git push
PC:
	git stash
	git pull
