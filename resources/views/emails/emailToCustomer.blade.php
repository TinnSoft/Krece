@component('mail::message')


{!! html_entity_decode($body) !!}

@component('mail::subcopy')
Documento generado en el sistema <a href="http://krece.dev">Krece</a>.
@endcomponent

@endcomponent
