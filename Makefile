	# Make file to commit and pull git

GIT:
	git add .
	git commit -am "Realizando pruebas con el UART"
	git push
PC:
	git stash
	git pull
