local dialogue = {
-- maison
    dialogue1 = {
        { player = "Comment suis-je rentré à la maison ?\nC'est bizarre je me sens tout petit,\nje ne vois plus mes mains...\nAAAAAHHHHHH ! \nPourquoi je ressemble à un slime, c'est quoi ce bordel !" },
        { papy = "\nDu calme mon enfant, \ntu as été ramené avec cette petite pixie.\nTu devrais sortir de la maison, elle t'attend dehors !" },
    },

-- world
    dialogue2 = {
        {pixie = "\nLOYYYYYYYYYYD !!! \nJe suis contente que tu sois en vie !\nNotre déesse Aurile m'envoie t'aider à purifier l'Absolue."},
        {pixie = "\nL'Absolue s'est réincarnée, son influence grandit.\nLes monstres commencent à arriver dans cette région."},
        {pixie = "Tu devrais aller au village récolter des informations,\nn'oublie surtout pas le masque que ta confié Aurile,\nil te permet de garder ta conscience intacte\nface à la malédiction qui te touche."},
        {player = "\n\nSi je brise cette malédiction, je peux donc redevenir humain ?"},
        {pixie = "\n\nOui, mais il te faudra purifier la personne qui à lancée ce sort ! "},
        {player = "\n\nNe perdons pas de temps ! "},
    },

    dialogue3 = {
        {pixie = "\nUn instant Loyd,\nj'ai oublié de te dire que ce masque te confère deux pouvoirs."},
        {pixie = "\nLe premier, te permet d'invoquer ma magie de flamme gelée.\nTu devrais essayer de faire un clic-gauche."},
        {pixie = "\nLa seconde, te permet d'invoquer ton énergie de paladin,\ntu peux créer un bouclier purificateur.\nTu devrais essayer de faire un clic-droit."},
        {player = "\n\nJe peux donc me battre et me défendre !\nAllons d'abord au village"},

    },

-- Village
    dialogue4 = {
        {pixie = "\nIl y a une présence familière dans ce village.\nOn devrait se renseigner."},
    },

    dialogue5 = {
        {petitG = "\n\n. . ."},
    },

    dialogue6 = {
        {guerriere = "\n\nUn monstre dans le village !Prépare toi à mourir !"},
        {player = "\n\nAttendez je suis Loyd !!"},
        {guerriere = "\n\nQuoi . . . Comment ?"},
        {Guerriere = "\nT'as vachement rapetissé gamin! \nTu devrais aller voir l’érudit, il a une chambre à l'auberge."},
        {Guerriere = "\n\nSi un jour tu retrouves ta forme humaine, reviens me voir !"},
    },
    
    dialogue7 = {
        {aubergiste = "Bonjour, bienvenue à l'auberge du long repos. \nJe suis désolée \npour le moment nous ne pouvons pas te proposer nos services. \nLe village n'a pas encore reçu les ressources suffisantes \npour finir sa reconstruction."},
        {aubergiste = "Au revoir"},
    },

    dialogue8 = {
        {player = "\nBonjour, une amie m’a dit que vous pourriez \npeut-être me renseigner pour retrouver mon corps !"},
        {erudit = "\nINCROYABLE ! \nC'est la première fois que je vois un sortilège aussi puissant! \nSeule une sorcière pourrait jeter ce genre de malédiction."},
        {erudit = "\n\nIl semblerait par contre que les ténèbres \nn'affectent pas votre conscience."},
        {erudit = "\nTu devrais aller voir à l'extérieur du village au sud-est, \nil paraît qu'un donjon est apparu."},
        {player = "\nJe vais aller y faire un tour. . . \nQue devrais-je faire si je croise cette sorcière ?"},
        {erudit = "\n\nTu devras surement la vaincre, pour rompre le sortilège."},
    },
    
    dialogue9 = {
        {alchimiste = "Bonjour, je n'ai acctuellement plus d'ingrédient en stock. \nN'hésite pas à passer plus tard \nj'aurais sûrement des potions de soins a te fournir. \nSurtout reviens avec des rubis.\nJe ne fais pas crédit."},
    },

    dialogue10 = {
        {pixie = "\nJe pense que nous avons parlé a tous le monde. \nOn devrait aller fouiller le donjon."},
        {player = "\n\nBonne idée ! "},    
    },

    dialogue11 = {
        {narateur = "\n\nFERMER, \nmerci d'attendre la futur maj."},
    },

  -- Donjon entrer
    dialogue12 = {
        {narateur = "Toi qui entre dans ce donjon sache que  \ntu ne peux plus faire marche arrière ! \nEntre dans les tréfonds du chaos et survie à ces épreuves. \nCourage à toi qui incarne le serment d'Aurile."},
    },

-- Donjon mini boss
    dialogue13 = {
        {racoon = "\nDestruction. . . \nChaos . . ."},
    },

-- Donjon boss
    dialogue14 = {
        {pixie = "\nAttention, soyons prudent. \nJe ressens une aura maléfique pesante."},
        {player = "\nTu penses que c'est elle la sorcière ?"}, 
    },
 
    dialogue15 = {
        {witch = "\nHA HA HA HA ! \nJe vais t'achever minus. \nTous les êtres maudits doivent servir l'Absolue.\nTu le serviras dans le chaos sous mes ordres!"},
        {player = "\n\nLe minus, va te purifier, et briser cette malédiction."},
    },

    dialogue16 = {
        {pixie = "\nTu as vaincu cette maudite sorcière. \nOn dirait que tu reprends partiellement forme humaine! \nPeut être que si tu bats d'autres généraux tout se règlera."},
        {player = "\n\nEspérons le . . . "}, 
    },

-- win 
    dialogue17 = {
        {narateur = "\nFélicitation tu as vaincu l'un des généraux de l'Absolue. \nLa suite de l'aventure arrive prochainement! \nMerci d'avoir joué !"},
    },

-- loose 
    dialogue18 = {
        {narateur = "\nTu viens d'être corrompu par l'Absolue ! \nTu n'es plus maître de toi même. \nLa partie est finie !"},
},  
-- rajout
    
    dialogue19 = {
        {Arnes = "\nC'est impossible, \ntu as survécu à l'assaut de la sorcière du chaos. \nJe ne pourrais jamais te remercier comme il se doit \npour m'avoir protégé durant cette bataille."},
        {Arnes = "\nSi tu as besoin de compagnon de voyage \nn'hésite pas à revenir vers moi. \nJe me joindrais à toi avec grand plaisir"},

    },
}

return dialogue