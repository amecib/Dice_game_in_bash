#!/bin/bash
#https://colors.sh/ : site internet pour la couleur et l'aspect graphique

NO_FORMAT="\033[0m"
F_BOLD="\033[1m"
F_UNDERLINED="\033[4m"
C_GOLD="\033[38;5;220m"      
C_WHITE="\033[38;5;230m" 
C_RED="\033[38;5;196m"
C_VIOLET="\033[38;5;163m"
C_BLUE="\033[38;5;51m"
clear

#fonction pour mettre en attente le jeu et les messages
pause(){
    sleep "$1"
}
#storyboard pour introduire le jeu :

echo -e "${C_VIOLET}Psss...${NO_FORMAT}"
pause 1
echo -e "${C_VIOLET}Psss... viens...${NO_FORMAT}"
pause 1
echo -e "${C_VIOLET}Viens au pays des plaisirs et du hasard...${NO_FORMAT}"
pause 1.5
echo -e "${F_BOLD}${C_GOLD}--- WELCOME TO CAESARS PALACE ---${NO_FORMAT}"
pause 1
echo -e "${C_WHITE}Vous allez commencer à jouer à notre fameux jeu de dés.${NO_FORMAT}"
pause 1
echo -e "${F_UNDERLINED}${F_BOLD}${C_BLUE}Rappel des règles : le joueur gagne la partie à condition : ${NO_FORMAT}"
echo ""
pause 1
echo -e "${C_WHITE}1. Tris : les trois dés ont la même valeur.${NO_FORMAT}"
pause 1
echo -e "${C_WHITE}2. Paire : au moins deux dés ont la même valeur.${NO_FORMAT}"
pause 1
echo -e "${C_WHITE}3. Échelle : les trois dés présentent des valeurs consécutives.${NO_FORMAT}"
pause 1
echo ""
echo -e "${F_BOLD}${C_RED}À chaque tour, au plus une seule combinaison peut être cochée.${NO_FORMAT}"
pause 1
echo -e "${F_BOLD}${C_WHITE}La partie se termine quand les trois combinaisons ont été validées.${NO_FORMAT}"
pause 1
echo -e "${F_BOLD}${C_GOLD}Bonne chance ! ;)${NO_FORMAT}"
pause 1.5

#fonction qui cherche le minimum et le maximum dans un tableau, indispensable pour l'échelle 

min_max(){
    minimum=$1
    maximum=$1
    for t in "$@"
    do
        if [ $t -gt $maximum ]
        then
            maximum=$t
        fi
        if [ $t -lt $minimum ]
        then
            minimum=$t
        fi
    done
    echo "$minimum $maximum" 
}

# Piste d'amélioration :  animation des dés, je me suis inspiré des machines de casino .
roll_animation_V2() {
   local f1=$1
   local f2=$2
   local f3=$3
    echo ""
    echo ""
    echo ""
    for j in {0..80}
    do
        tput cuu 3   # remonte proprement de 3 lignes , site internet : https://doc.ubuntu-fr.org/tutoriel/formater_le_texte_dans_le_terminal_avec_tput, section 3.3.3 Remonter d'une lign
        echo -e "${C_GOLD}+-----------+${NO_FORMAT}"
        echo -e "${C_WHITE}| $((RANDOM%6+1)) | $((RANDOM%6+1)) | $((RANDOM%6+1)) |${NO_FORMAT}" 
        echo -e "${C_GOLD}+-----------+${NO_FORMAT}"
        sleep 0.001
    done

    # Résultat final
    tput cuu 3
    echo -e "${C_GOLD}+-----------+${NO_FORMAT}"
    echo -e "${C_WHITE}| $f1 | $f2 | $f3 |${NO_FORMAT}"
    echo -e "${C_GOLD}+-----------+${NO_FORMAT}"
}

#on entre dans le jeu et on initialise

echo "Quel mode souhaitez-vous utiliser ? Entre 1 si 1 joueur et 2 si multijoueur"
read choix
if [[ "$choix" == "1" ]]
then 
    nb_joueurs=1
elif [[ "$choix" == "2" ]] 
then
    echo -n "Nombre de joueurs ?"
    read nb_joueurs
    if [[ "$nb_joueurs" -lt 2 ]] 
    then
        echo "Il fallait rentrer une valeur positive supérieure ou égale à 2. Mode solo par défaut"
        nb_joueurs=1
    fi
else
    echo "Mode inconnu : choix invalide (1 ou 2) => session solo par défaut."
    nb_joueurs=1
    sleep 1
fi
    for((i=0;i<$nb_joueurs;i++))
    do
        cpt[$i]=0                   #Comme on a pas de variables booléennes en Bash, l'utilisation des flags permet entre autres de "simuler" une variable booléene
        flag_tris[$i]=0             # le 0 correspond à False, on a toujours pas eu de tris/paire/ échelle, le 1 correspond à True on a obtenu une condition 
        flag_paire[$i]=0            #parmi les 3
        flag_echelle[$i]=0
        echo "Saisir le nom du joueur $((i+1))" #on travaille de {0,..., nb_joueurs -1} le +1 ici permet de réindexer par rapport à la "vraie vie"
        read -r nom_i
        nom[$i]="$nom_i"
    done
    vainqueur=-1
# le jeu commence
    while [ $vainqueur -eq -1 ]
    do
        for((i=0; i<$nb_joueurs; i++))
        do  
            ((cpt[$i]++))
            d1=$((RANDOM % 6 + 1))
            d2=$((RANDOM % 6 + 1))
            d3=$((RANDOM % 6 + 1))
            echo -e "${F_BOLD}${C_GOLD} ${nom[$i]}${NO_FORMAT} lance les dés…"
            pause 1
            roll_animation_V2 $d1 $d2 $d3
            pause 1
            result=$(min_max "$d1" "$d2" "$d3")
            val_min=$(echo "$result" | cut -d' ' -f1)
            val_max=$(echo "$result" | cut -d' ' -f2)      

#On utilise une structure  if - elif - else afin d'assurer l'unicité de la condition validée à chaque tour

            if [ "${flag_tris[$i]}" -eq 0 ] && [ $d1 -eq $d2 ] && [ $d2 -eq $d3 ]
            then
                echo -e "${F_BOLD}${C_RED} ${nom[$i]} : TRIS obtenu !${NO_FORMAT}"
                flag_tris[$i]=1
            elif [ "${flag_echelle[$i]}" -eq 0 ] && [ $((val_max - val_min)) -eq 2 ] && [ $d1 -ne $d2 ] && [ $d2 -ne $d3 ] && [ $d1 -ne $d3 ]
            then
                echo -e "${F_BOLD}${C_BLUE} ${nom[$i]} : ECHELLE obtenue !${NO_FORMAT}"
                flag_echelle[$i]=1      
            elif [ "${flag_paire[$i]}" -eq 0 ] && { [ $d1 -eq $d2 ] || [ $d2 -eq $d3 ] || [ $d1 -eq $d3 ]; }
            then
                echo -e "${F_BOLD}${C_BLUE} ${nom[$i]} : PAIRE obtenue !${NO_FORMAT}"
                flag_paire[$i]=1
            fi    

            
            echo ""
            echo -e "${C_GOLD}Score courant de ${nom[$i]} :  ${C_WHITE}Tris:${flag_tris[$i]} | Paire:${flag_paire[$i]} | Echelle:${flag_echelle[$i]}${NO_FORMAT}"
            echo ""


            total=$(( flag_tris[$i] + flag_paire[$i] + flag_echelle[$i] ))
            if [ $total -eq 3 ]
            then
                vainqueur=$i
                break 2                 # d'après ce site : https://linuxize.com/post/bash-break-continue/
            fi
            pause 0.5
        done
    done

#annonce du vainqueur et fin du jeu
echo -e "${F_BOLD}${C_GOLD}==============================================${NO_FORMAT}"
echo -e "${F_BOLD}${C_GOLD}Le grand vainqueur est : ${nom[$vainqueur]} en ${cpt[$vainqueur]} tours !!${NO_FORMAT}"
echo -e "${F_BOLD}${C_GOLD}==============================================${NO_FORMAT}"
pause 0.5
echo -e "${F_BOLD}${C_VIOLET}BRAVO !${NO_FORMAT}"
pause 0.5
echo -e "${F_BOLD}${C_RED}Vous remportez le million ! ${NO_FORMAT}"