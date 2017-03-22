@component('mail::message')
# Fernando Te damos la bienvenida a Krece

A partir de este momento tienes 30 días para que uses nuestra aplicación sin ningún costo

@component('mail::button', ['url' => 'http://krece.dev'])
Empezar a trabajar
@endcomponent


Cordialmente,<br>

Equipo {{ config('app.name') }}
@endcomponent
