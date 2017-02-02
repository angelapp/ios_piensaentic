# ios_piensaentic

Structure.plist:

    Homólogo al índice.

    Contenido de cada hoja y capítulo

    Colores, imágenes, links a presentar


Menu.HomeViewController:

    Presenta estructuralmente la aplicación general, con los capítulos y el menú.

    Administra capítulos y menú


Controllers.GeneralViewControllerr:

    Controlador general de las vistas, de este heredan los demás controladores.

    Presenta los contenidos de Structure.plist

    Los otros Controllers....ViewController gestionan funcionalidades específicas de las actividades, p.ej video, tablas dinámicamente, pintado de datos previos, etc.


Network.Network:

    Métodos de conexión con el servidor, utiliza Alamofire.


Storyboards:

    Plantillas de la UI

