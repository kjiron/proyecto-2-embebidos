	# Make file to commit and pull git

GIT:
	git add .
	git commit -am "Condensando las progras Unix en una sola"
	git push
PC:
	git stash
	git pull
