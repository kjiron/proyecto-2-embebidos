	# Make file to commit and pull git

GIT:
	git add .
	git commit -am "Acomodo de archivos para diferenciar los de linux de los de Ras"
	git push
PC:
	git stash
	git pull
