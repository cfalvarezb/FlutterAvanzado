const {io} = require('../index');
const { comprobarJWT } = require('../helpers/jwt');
const { usuarioConnect, usuarioDisConnect, recMessage } = require('../controllers/socket');

//Mensajes de sockets
io.on('connection', (client) => {
    console.log('Cliente conectado');
    const [ valido, uid ] = comprobarJWT( client.handshake.headers['x-token'] );

    // Validate Authentication
    if ( !valido ) { return client.disconnect(); }

    // Client Authenticate
    usuarioConnect(  uid );

    // Get user into a hall
    // Global Hall, client.id, 
    client.join( uid ); 

    // Listen event personal-message
    client.on('personal-message', async ( payload ) => {
        // TODO Rec Message
        await recMessage( payload );
        io.to( payload.to ).emit('personal-message', payload);
    });

    console.log(valido, uid);

    client.on('disconnect', () => {
        usuarioDisConnect( uid );
    });

   
});