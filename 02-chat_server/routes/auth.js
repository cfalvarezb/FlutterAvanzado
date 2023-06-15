/*
    path: api/login
*/
const { check } = require('express-validator');
const { Router } = require('express');
const { createUser, login, renewToken } = require('../controllers/auth');
const { validarCampos } = require('../middlewares/validar-campos');
const { validateJWT } = require('../middlewares/validar-jwt');
const router = Router();

router.post('/new', [ 
    check('nombre', 'El nombre es obligatorio').not().isEmpty(),
    check('email', 'El correo es obligatorio').isEmail(),
    check('password', 'La contraseña es obligatoria').not().isEmpty(),
    validarCampos
 ] , createUser);

router.post('/', [ 
    check('email', 'El correo es obligatorio').isEmail(),
    check('password', 'La contraseña es obligatoria').not().isEmpty()
 ] , login);


router.get('/renew', 
    validateJWT, 
    renewToken);


module.exports = router;