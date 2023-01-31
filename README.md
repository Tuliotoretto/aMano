
# a Mano IOS.

Proyecto final del Diplomado de Desarrollo de Aplicaciones para dispositivos móviles. 

## Objetivo

El objetivo de esta aplicación es poder administrar tus deudas con amigos o familiares, de una forma facil. 

## Logo

El logo son las manos de dos personas dandose la mano. Haciendo referencia a que "cerraron el trato" y no hay deudas. en pocas palabras, estan "a mano"

## Instrucciones

- Inicia sesion con tu telefono celular
- crea grupos con tus amigos o familiares
- agrega gastos en cada uno de los grupos y sigue tus cuentas

## Dispositivo

Se eligió como dispositivo unicamente el iphone en orientación vertical, ya que el objetivo de esta aplicacion es tener a la mano tus cuentas. para verificarlas rapidamente.

la versión de la aplicacion es la 14.7. A la fecha actual la versión mas reciente es la 16.0. Por lo que dos versiones abajo darán el soporte necesario.

## Credenciales

usuario de prueba 1:\
numero: +1 650-555-1111 \
codigo: 111111

usuario de prueba w:\
numero: +1 1231231234 \
codigo: 111111

## Dependencias

Firebase

    pod 'FirebaseCore'
    pod 'FirebaseAuth'
    pod 'FirebaseFirestore'
    pod 'FirebaseFirestoreSwift'
    pod 'FirebaseStorage'
    pod 'FirebaseUI/Phone'
  
KeyboardManager

    pod 'IQKeyboardManagerSwift'
  
Form builder
  
    pod 'Eureka'

# Bugs

- La app explota si hay grupos con el mismo nombre
- La app explota si hay nombres repetidos dentro de los grupos