	# Make file to commit and pull git

GIT:
	git add .
	git commit -am "Haciendo pruebas Ras-PC"
	git push
PC:
	git stash
	git pull
