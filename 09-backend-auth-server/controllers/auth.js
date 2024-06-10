const { response } = require('express');
const { validateGoogleIdToken } = require('../helpers/google-verify-token');

const googleAuth = async ( req, res = response ) => {
    //TODO Get Token
    const token = req.body.token;
    if( !token ) {
        return res.json({
            ok: false,
            msg: 'There is no token on the request'
        });
    }

    const googleUser = await validateGoogleIdToken( token );

    if ( !googleUser ) {
        return res.status(400).json({
            ok: false
        });
    }

    //TODO Save on DB own

    res.json({
        ok: true,
        googleUser
    });
}

module.exports = {
    googleAuth
}