	# Make file to commit and pull git

GIT:
	git add .
	git commit -amUpdate
	git push
PC:
	git stash
	git pull
