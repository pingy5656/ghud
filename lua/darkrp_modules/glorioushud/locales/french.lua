local lang = { --Don't change this
 
    langid = 'fr', --Identifier ( ru, en, de, ... )
    lang = 'French', --Printname here
 
    hp = 'Santé: ',
    armor = 'Armure: ',
    food = 'Nourriture: ',
    fuel = 'Carburant: ',
    props = 'Props: ',
    level = 'Niveau ',
 
    licensed = 'Licence',
    yes = 'Oui',
    no = 'Non',
    votequeue = ' votes en attente',
    agenda = 'Agenda',
    agenda_empty = 'L agenda est vide',
    arrest = 'Vous avez été arrêté !',
    arrest_timeleft = 'Il reste du temps :',
    lockdown = 'Le maire a lancé un couvre feu, retournez dans vos maisons !',
 
    wanted = 'Vous avez été recherché pour la raison:',
    forsale = 'A vendre',
    tobuy = 'Appuyez sur F2 pour acheter la porte',
    solddoor = 'Porte vendue',
    owner = 'Propriétaire:',
    doorsettings = 'Options des portes',
    vehiclesettings = 'Options du véhicule',
    buydoor = 'Acheter',
    selldoor = 'Vendre',
    adduser = 'Ajouter un utilisateur',
    removeuser = 'Supprimer l utilisateur',
    noavailable = 'Personne disponible',
    settitle = 'Définir le titre de la porte',
    setvtitle = 'Définir le titre du véhicule',
    editdoor = 'Modifier les groupes',
    doorgroups = 'Groupes de portes',
    jobs = 'Emplois',
    none = 'Aucun',
    add = 'Ajouter',
    remove = 'Retirer',
    allow = 'Permettre la propriété',
    disallow = 'Refuser la propriété',
    set = 'Définir',
    cancel = 'Annuler',
 
    cantbuy = 'Desactiver la propriété',
 
    wantednews = ' est recherché par la police ! Raison pour laquelle:',
 
    orderedby = '. Ordonné par: ',
 
    warrant = 'Mandat de perquisition approuvé pour ',
    reason = 'Raison : ',
    arrested = ' a été arrêté pour ',
    seconds = ' secondes!',
    unwanted = ' n est plus recherché par la police ! Révoqué par: ',
    gestures = 'Gestes',
 
    thumbsup = 'Levez le pouce',
    followme = 'Suivez-moi!',
    bow = 'Arc',
    nonverbalno = 'Non verbal non',
    wave = 'Vague',
    lionpose = 'Pose du lion',
    sexydance = 'Danse du sexe',
    laugh = 'Rire',
    dance = 'Danse',
 
    timeout_title = 'Oups. Connexion perdue!',
    timeout_description = 'Quelque chose a mal tourné, il semble que la connexion au serveur ait été interrompue. Veuillez patienter pendant que nous essayons d établir une nouvelle connexion.',
    timeout_reconnect = 'Reconnecter',
    timeout_leave = 'Laissez',
    timeout_seconds = ' secondes',
    timeout_autorc = 'Auto reconnexion dans ',
 
    kmh = ' km/h',
    mph = ' mp/h',
    rpm = 'RPM: ',
    simfphyscar = 'Voiture Simfphys',
 
    settings_title = 'Paramètres',
    settings_savebutton = 'Sauvegarder les changements',
    theme = 'Thème HUD et UI',
    darktheme = 'Sombre',
    whitetheme = 'Blanc',
    t_lang = 'Langue',
 
    drawrange = 'Distance de l hud de la tête du joueur',
 
    range = 'Portée',
 
    t_scale = 'Taille de l hud du joueur au dessus de la tete',
 
    scale = 'Taille',
    animspeed = 'Vitesse d animation des barres',
    speed = 'Vitesse',
    speedunit = 'Utiliser l unité de vitesse des véhicules KMH',
    model = 'Utiliser l icône du modèle au lieu de l icône de l avatar',
    anim = 'Activer les animations des barres',
    enablehud = 'Activer l affichage en haut de la tête (HUD)',
    enablevotes = 'Activer les votes',
    enableagenda = 'Activer l agenda',
    enablearrest = 'Permettre les arrestations',
    enablelockdown = 'Activer le couvre feu',
    enablewanted = 'Activer la recherche',
 
    enablepickup = 'Activer le HUD de collecte',
 
    enabledoors = 'Activez le texte 3D2D sur les portes',
    enablevehicle = 'Activer le HUD du véhicule',
    enabletimeout = 'Activer le menu de temporisation',
    enableoverhead = 'Activer l information sur les frais généraux du joueur',
    enablenews = 'Activer les nouvelles',
    enablevehicleind = 'Activer l indicateur du propriétaire du véhicule',
    enablemedkit = 'Activer la barre de santé du medkit HUD',
    showbarnames = 'Afficher les noms des bars',
    saved = 'Paramètres enregistrés.',
    confirmtitle = 'Confirmer ?',
    savetext = "Si vous n enregistrez pas les paramètres, ils seront réinitialisés après une connexion.",
    save = 'Sauvegarder',
    dsave = "Ne pas sauvegarder",
    settings_resetbutton = 'Réinitialisation des valeurs par défaut',
    settings_resettext = "Voulez-vous réinitialiser les paramètres par défaut ?",
    reset = 'Réinitialiser',
    reseted = 'Les paramètres sont réinitialisés aux valeurs par défaut.',
    outdate = 'La version du serveur est périmée, veuillez télécharger la dernière version. (dire aux admins)',
    enablevoicebar = 'Activer la barre de volume de la voix',
    enablevoicecolor = 'Colorer la barre de volume de la voix',
    liters = ' l',
    leveltime = "Durée d'affichage de la barre de niveau",
    time = 'Durée',
    levelalways = 'Ne pas masquer la barre de niveau',
    enablelevel = 'Activer la barre de niveau',
    enablestamina = "Activer la barre d'endurance",
 
}
 
hook.Add( 'glorioushud.initialized', 'glorioushud.initialized' .. lang[ 'langid' ], function()
 
    glorioushud.locales[ lang[ 'langid' ] ] = lang
 
end)