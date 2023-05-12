const {io} = require('../index');

const Band = require('../models/band');
const Bands = require('../models/bands');
const bands = new Bands();

bands.addBand( new Band( 'Queen' ) );
bands.addBand( new Band( 'Queen1' ) );
bands.addBand( new Band( 'Queen2' ) );
bands.addBand( new Band( 'Queen3' ) );

//Mensajes de sockets
io.on('connection', client => {
    //client.on('event', data => {/* */});
    console.log('Cliente conectado');

    client.emit('active-bands', bands.getBands());

    client.on('disconnect', () => {
        console.log('Client disconnected');
    });

    client.on('connecting', () => {
        console.log('Client connecting');
    });

    client.on('mensaje', ( payload ) => {
        console.log('Mensaje recibido', payload);

        io.emit('mensaje', { admin: 'Nuevo mensaje' });
    });

    client.on('vote-band', (payload)=>{
        bands.voteBand( payload.id );
        io.emit('active-bands', bands.getBands());
    });

    client.on('add-band', (payload)=>{
        bands.addBand( new Band(payload.name) );
        io.emit('active-bands', bands.getBands());
    });

    client.on('delete-band', (payload)=>{
        bands.deleteBand( payload.id );
        io.emit('active-bands', bands.getBands());
    });

    // client.on('emitir-mensaje', ( payload ) => {
    //     //io.emit('nuevo-mensaje', payload); //emite para todos los clientes o sockets
    //     client.broadcast.emit('nuevo-mensaje', payload);//emite a todos menos al que lo envio 
    // });
});