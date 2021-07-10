#!/bin/bash
choice=$(echo -e "Foglio di calcolo\nPresentazione\nRelazione" | dmenu -c -i -p "Aprire:")
#LOEFM=$(/home/mario/Documents/University/LOEFM)

case "$choice" in
	"Foglio di calcolo") choice=$(echo -e "e/m\nInteferometro\nLuce\nMillikan\nPrisma\nReticolo" | dmenu -c -i -p "Esperienza:")
		case "$choice" in
			"e/m") libreoffice "/home/mario/Documents/University/LOEFM/e-m/LU4--e-m--Zarrillo.xlsx" || notify-send "File not found";;
			"Interferometro") libreoffice "/home/mario/Documents/University/LOEFM/Interferometro/LU4--Inteferometro--Bocchino.xlsx" || notify-send "File not found";;
			"Luce") notify-send "File not found";;
			"Millikan") notify-send "File not found";;
			"Prisma") notify-send "File not found";;
			"Reticolo") libreoffice "/home/mario/Documents/University/LOEFM/Reticolo/LU4--Reticolo--Forzanini.ods" || notify-send "File not found";;
			*);;
			esac;;
	"Presentazione") choice=$(echo -e "Dispensa\ne/m\nInteferometro\nLuce\nMillikan\nPrisma\nReticolo" | dmenu -c -i -p "Esperienza:")
		case "$choice" in
			"Dispensa") zathura "/home/mario/Documents/University/LOEFM/Dispensa.pdf" || notify-send "File not found";;
			"e/m") notify-send "File not found";;
			"Interferometro") zathura "/home/mario/Documents/University/LOEFM/Interferometro/Interferometro.pptx" || notify-send "File not found";;
			"Luce") zathura "/home/mario/Documents/University/Luce/Luce.pdf" || notify-send "File not found";;
			"Millikan") zathura "/home/mario/Documents/University/LOEFM/Millikan/Millikan.pdf" || notify-send "File not found";;
			"Prisma") zathura "/home/mario/Documents/University/Prisma/Prisma.pdf" || notify-send "File not found";;
			"Reticolo") zathura "/home/mario/Documents/University/LOEFM/Reticolo/Reticolo.pdf" || notify-send "File not found";;
			*);;
			esac;;

	"Relazione") choice=$(echo -e "e/m\nInteferometro\nLuce\nMillikan\nPrisma\nReticolo" | dmenu -c -i -p "Esperienza:")
		case "$choice" in
			"e/m") zathura "/home/mario/Documents/University/LOEFM/e-m/Relazione/LU4-e-m.pdf" || notify-send "File not found";;
			"Interferometro") zathura "/home/mario/Documents/University/LOEFM/Interferometro/Relazione/LU4-Interferometro.pdf" || notify-send "File not found";;
			"Luce") notify-send "File not found";;
			"Millikan") zathura "/home/mario/Documents/University/LOEFM/Millikan/Relazione/Relazione.pdf" || notify-send "File not found";;
			"Prisma") notify-send "File not found";;
			"Reticolo") zathura "/home/mario/Documents/University/LOEFM/Reticolo/Relazione/Relazione.pdf" || notify-send "File not found";;
			*);;
			esac;;
		esac
