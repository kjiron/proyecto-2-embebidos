	# Make file to commit and pull git

GIT:
	git add .
	git commit -am "Finalizando el proyecto y reacomodando carpetas"
	git push
PC:
	git stash
	git pull
