@component('mail::message')

# Hola {{$company}}, te damos la bienvenida a Krece

Queremos ayudar a que tu negocio <strong>Krezca</strong>. Esta herramienta te permite gestionar <strong>fácilmente</strong> la información de tu empresa. 



@component('mail::panel')
    * Aquí puedes:

    * Crear, enviar e imprimir facturas
    * Gestionar tu inventario
    * Notificar a tus clientes acerca del estado de tus facturas
    * Trabajar en equipo: puedes crear otros usuarios para que trabajen con permisos restringidos
    * Tener visibilidad de lo que sucede en tu empresa mediante reportes detallados
    * Gestionar tus cuentas y realizar transacciones en diversas monedas.
@endcomponent



Nos encontramos trabajando para adaptar la nueva ley de facturación electrónica, entre otras mejoras sin ningún costo para ti.

@component('mail::button', ['url' => 'http://krece.co', 'color' => 'green'])
Empecemos a trabajar
@endcomponent

@component('mail::panel')
Si tienes dudas o deseas ayudarnos a mejorar la herramienta, puedes escribirnos <a href="http://krece.co">aquí</a>.
@endcomponent

<br>
Saludos,<br>

<strong>Equipo {{ config('app.name') }}</strong><br>
www.krece.co

@component('mail::subcopy')
Este sistema cumple con la normatividad de la DIAN.
@endcomponent

@endcomponent
