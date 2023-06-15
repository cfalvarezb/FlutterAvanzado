const { response } = require('express');
const bcrypt = require('bcryptjs');
const Usuario = require('../models/usuario');
const { generateJWT } = require('../helpers/jwt');

const createUser = async (req, res = response ) => {

    const { email, password } = req.body;

    try {

        const existeEmail = await Usuario.findOne({ email });

        if ( existeEmail ) {
            return res.status(400).json({
                ok: false,
                msg: 'El correo ya esta registrado'
            });
        }

        const usuario = new Usuario( req.body );

        //Encrypt password
        const salt = bcrypt.genSaltSync();
        usuario.password = bcrypt.hashSync ( password, salt );

        await usuario.save();

        //Generate JWT
        const token = await generateJWT( usuario.id );

        res.json({
            ok: true,
            usuario,
            token
        });
        
    } catch (error) {
        console.log(error);
        res.status(500).json({
            ok: false,
            msg: 'Hable con el administrador'
        });
    }

    
}

const login = async ( req, res = response ) => {

    const { email, password } = req.body;

    try {

        const usuarioDB = await Usuario.findOne({ email });

        if ( !usuarioDB ) {
            return res.status(404).json({
                ok: false,
                msg: 'Email no encontrado'
            });
        }

        //Validate Password
        const validPassword = bcrypt.compareSync(password, usuarioDB.password);
        if ( !validPassword ) {
            return res.status(404).json({
                ok: false,
                msg: 'El password no es valido'
            });
        }

        //Generate JWT
        const token = await generateJWT( usuarioDB.id );
        res.json({
            ok: true,
            usuario: usuarioDB,
            token
        });
        
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            ok: false,
            msg: 'Hable con el administrador'
        });

    }

}

const renewToken = async (req, res = response) => {

    //Get uid user
    const uid = req.uid

    //Generate new JWT
    const token = await generateJWT( uid );

    //Get user by UID
    const usuario = await Usuario.findById( uid );

    return res.json({
        ok: true,
        usuario,
        token
    });
}

module.exports = {
    createUser,
    login,
    renewToken
}