const Usuario = require('../models/usuario');
const Message = require('../models/message');

const usuarioConnect = async ( uid = '' ) => {
    const usuario  = await Usuario.findById( uid );
    usuario.online = true;
    await usuario.save();
    return usuario;
}

const usuarioDisConnect = async ( uid = '' ) => {
    const usuario  = await Usuario.findById( uid );
    usuario.online = false;
    await usuario.save();
    return usuario;
}

const recMessage = async ( payload ) => {
    /*
        {
            from: '',
            to: '',
            message: ''
        }
    */

    try {
        const message = Message( payload );
        await message.save();
        return true;
    } catch (error) {
        return false;
    }

}

module.exports = {
    usuarioConnect,
    usuarioDisConnect,
    recMessage
}