	# Make file to commit and pull git

GIT:
	git add .
	git commit -am "Se ha traducido la mayor parte del multijugador a SDL"
	git push
PC:
	git stash
	git pull
