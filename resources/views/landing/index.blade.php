<!DOCTYPE html>
<html lang="en">
    
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Bienvenido</title>

    {!!Html::style('/themes/krece/css/bootstrap.min.css')!!}
    {!!Html::style('/themes/krece/font-awesome/css/font-awesome.css')!!}
    {!!Html::style('/themes/krece/css/animate.css')!!}
    {!!Html::style('/themes/krece/css/style.css')!!}
</head>

<body id="page-top" class="landing-page no-skin-config">
<div class="navbar-wrapper">
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header page-scroll">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="http://app.krece.co/register" target="_blank">EMPIEZA YA MISMO TU MES GRATIS!</a>                    
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a class="page-scroll" href="#page-top">Inicio</a></li>
                        <li><a class="page-scroll" href="#features">Características</a></li>
                        <li><a class="page-scroll" href="#pricing">Planes</a></li>
                        <li><a class="page-scroll" href="#contact">Contáctenos</a></li>
                    </ul>
                </div>
            </div>
        </nav>
</div>
<div id="inSlider" class="carousel carousel-fade" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#inSlider" data-slide-to="0" class="active"></li>
        <li data-target="#inSlider" data-slide-to="1"></li>
    </ol>
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <div class="container">
                <div class="carousel-caption">
                    <h1>Krece<br/><br/></h1>
                       <h1 > Software para la gestión </br>de ingresos y gastos<br/>
                        de tu empresa</h1>
                    <p>Especialmente diseñado para pequeños negocios</p>
                    <p>
                        <a class="btn btn-lg btn-primary" href="#features" role="button">SABER MÁS</a>
                    </p>
                </div>
                <div class="carousel-image wow zoomIn">
                    <img src="landing/laptop.png" alt="laptop"/>
                </div>
            </div>
            <!-- Set background for slide in css -->
            <div class="header-back one"></div>

        </div>
        <div class="item">
            <div class="container">
                <div class="carousel-caption blank">
                    <h1>Gestiona Tu negocio, tus clientes<br/> con Una plataforma de facturación <br/>gratuita y potente</h1>
                    <p>desde cualquier lugar y a cualquier hora</p>
                    <p><a class="btn btn-lg btn-primary" href="#features" role="button">Saber más</a></p>
                </div>
            </div>
            <!-- Set background for slide in css -->
            <div class="header-back two"></div>
        </div>
    </div>
    <a class="left carousel-control" href="#inSlider" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Anterior</span>
    </a>
    <a class="right carousel-control" href="#inSlider" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Siguiente</span>
    </a>
</div>


<section id="features" class="container services">
    <div class="row">
        <div class="col-sm-3">
            <h2>Mantente organizado</h2>
            <p>Gestione sus ingresos y gastos sin esfuerzo en un solo lugar. Elimine la introducción manual de datos y no se preocupe por los detalles</p>
        </div>
        <div class="col-sm-3">
            <h2>Tus finanzas en un solo lugar</h2>
            <p>Disfrute de un conjunto completo de informes a la medida, personalizables para que sepas en que está tu negocio</p>
        </div>
        <div class="col-sm-3">
            <h2>Control</h2>
            <p>Monitoree fácilmente lo que sucede en tu negocio cada minuto y tome acciones cuando sea necesario</p>
        </div>
        <div class="col-sm-3">
            <h2>Personalización</h2>
            <p>Personalize los principales indicadores de tu negocio de manera amigable en el panel de configuración</p>
            
        </div>
    </div>
</section>

<section  class="container features">
    <div class="row">
        <div class="col-lg-12 text-center">
            <div class="navy-line"></div>
            <h1>Enfócate en hacer KRECER tu negocio<br/> <span class="navy"> con funciones accesibles a cualquier momento</span> </h1>
            <p>Estamos aquí para ayudarte con tus finanzas de manera fácil, ágil y segura</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3 text-center wow fadeInLeft">
            <div>
                <i class="fa fa-file-text features-icon"></i>
                <h2>Facturación</h2>
                <p>Crea facturas de ingreso o egreso fácilmente, imprimelas o envialas directamente a tus clientes.</p>
            </div>
            <div class="m-t-lg">
                <i class="fa fa-check-circle features-icon"></i>
                <h2>Normatividad DIAN</h2>
                <p>No te preocupes!, todos los documentos funcionan bajo la normatividad de la DIAN.</p>
            </div>
             <div class="m-t-lg">
                <i class="fa fa-user features-icon"></i>
                <h2>Gestion de contactos</h2>
                <p>Puedes gestionar tus contactos fácilmente, sean clientes o proveedores y generar informes de sus movimientos</p>
            </div>
        </div>
        <div class="col-md-6 text-center  wow zoomIn">
            <img src="landing/perspective.png" alt="dashboard" class="img-responsive">
        </div>
        <div class="col-md-3 text-center wow fadeInRight">
            <div>
                <i class="fa fa-cog features-icon"></i>
                <h2>Automatización</h2>
                <p>Optimize tiempo y esfuerzo con las funcionalidades de creación facturas automáticas y envio automático de recordatorios de pago a tus clientes</p>
            </div>
            <div class="m-t-lg">
                <i class="fa fa-money features-icon"></i>
                <h2>Multimoneda</h2>
                <p>Krece te permite realizar transacciones en diferentes monedas</p>
            </div>
             <div class="m-t-lg">
                <i class="fa fa-folder features-icon"></i>
                <h2>Inventario</h2>
                <p>Gestiona el stock de tus productos, nosotros te avisamos por email acerca de posibles acciones a tomar (ej. productos faltantes, movimientos.etc)</p>
            </div>
        </div>
    </div>
</section>




<section class="features">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="navy-line"></div>
                <h1>Aún tenemos más</h1>
                <p>Otras de las funcionalidades que puedes usar.  </p>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-5 col-lg-offset-1 features-text">
                <small>Reportes</small>
                <h2>Reportes inteligentes</h2>
                <i class="fa fa-bar-chart big-icon pull-right"></i>
                <p>Tenemos a tu disposición una serie de reportes que puedes acceder en tiempo real y los cuales te permitirán tomar mejores desiciones: ventas, clientes, productos, flujo de caja.etc)</p>
            </div>
            <div class="col-lg-5 features-text">
                <small>Categorías</small>
                <h2>Gestiona tus categorías contables</h2>
                <i class="fa fa-bolt big-icon pull-right"></i>
                <p>Crea, edita, elimina las categorías o asientos contables de manera fácil</p>
            </div>            
        </div>
        <div class="row">
            <div class="col-lg-5 col-lg-offset-1 features-text">
                <small>Bancos</small>
                <h2>Gestion de bancos</h2>
                <i class="fa fa-bank big-icon pull-right"></i>
                <p>Gestiona tus bancos, tus saldos, y mucho mas.</p>
            </div>
            <div class="col-lg-5 features-text">
                <small>Impuestos</small>
                <h2>Gestion de impuestos</h2>
                <i class="fa fa-list-alt big-icon pull-right"></i>
                <p>Crea, controla, gestiona tus impuestos que deben ser aplicados a cada uno de tus documentos</p>
            </div>           
        </div>
    </div>

</section>
<section id="pricing" class="pricing">
    <div class="container">
        <div class="row m-b-lg">
            <div class="col-lg-12 text-center">
                <div class="navy-line"></div>
                <h1>Nuestros planes</h1>
                <p>Seleccione el plan que mas se adapte a tus necesidades, o contáctenos y te asesoramos.</p>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 wow zoomIn">
                <ul class="pricing-plan list-unstyled">
                    <li class="pricing-title">
                        Basico
                    </li>
                    <li class="pricing-desc">
                        Diseñado para profesionales independientes y microempresas
                    </li>
                    <li class="pricing-price">
                        <span>$16</span> / month
                    </li>
                    <li>
                        Dashboards
                    </li>
                    <li>
                        Projects view
                    </li>
                    <li>
                        Contacts
                    </li>
                    <li>
                        Calendar
                    </li>
                    <li>
                        AngularJs
                    </li>
                    <li>
                        <a class="btn btn-primary btn-xs" href="https://krece.co/register">Seleccionar</a>
                    </li>
                </ul>
            </div>

            <div class="col-lg-4 wow zoomIn">
                <ul class="pricing-plan list-unstyled selected">
                    <li class="pricing-title">
                        Standard
                    </li>
                    <li class="pricing-desc">
                        Diseñado para pequeñas empresas
                    </li>
                    <li class="pricing-price">
                        <span>$22</span> / month
                    </li>
                    <li>
                        Dashboards
                    </li>
                    <li>
                        Projects view
                    </li>
                    <li>
                        Contacts
                    </li>
                    <li>
                        Calendar
                    </li>
                    <li>
                        AngularJs
                    </li>
                    <li>
                        <strong>Support platform</strong>
                    </li>
                    <li class="plan-action">
                        <a class="btn btn-primary btn-xs" href="https://krece.co/register">Seleccionar</a>
                    </li>
                </ul>
            </div>

            <div class="col-lg-4 wow zoomIn">
                <ul class="pricing-plan list-unstyled">
                    <li class="pricing-title">
                        Full
                    </li>
                    <li class="pricing-desc">
                        Para todo tipo de empresas
                    </li>
                    <li class="pricing-price">
                        <span>$160</span> / month
                    </li>
                    <li>
                        Dashboards
                    </li>
                    <li>
                        Projects view
                    </li>
                    <li>
                        Contacts
                    </li>
                    <li>
                        Calendar
                    </li>
                    <li>
                        AngularJs
                    </li>
                    <li>
                        <a class="btn btn-primary btn-xs" href="https://krece.co/register">Seleccionar</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="row m-t-lg">
            <div class="col-lg-8 col-lg-offset-2 text-center m-t-lg">
                <p>* Nos gusta ayudar a los que ayudan, si eres una fundación que ayuda, iglesia o una institución educativa, puedes <span class="navy">Krecer</span>  sin costo</p>
            </div>
        </div>
    </div>

</section>

<section id="contact" class="gray-section contact">
    <div class="container">
        <div class="row m-b-lg">
            <div class="col-lg-12 text-center">
                <div class="navy-line"></div>
                <h1>Tienes dudas? </br></br>Contáctanos</h1>
                <p>Si tienes dudas acerca de como usar la aplicación o deseas dejarnos feedback, envíanos un email.</p>
            </div>
        </div>
        <div class="row m-b-lg">
            <div class="col-lg-3 col-lg-offset-3">
                <address>
                    <strong><span class="navy">Krece.co</span></strong><br/>
                    <abbr title="Phone">Teléfono:</abbr> 312 3 63 37 53
                </address>
            </div>
            <div class="col-lg-4">
                <p class="text-color">
                    <h3>Cuentas con nosotros para ayudarte.</h3>
                </p>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 text-center">
                <a href="mailto:servicioalcliente@krece.co" class="btn btn-primary">Envíanos un email</a>
                <p class="m-t-sm">
                    Puedes seguirnos en las redes sociales
                </p>
                <ul class="list-inline social-icon">
                    <li><a href="#"><i class="fa fa-twitter"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-facebook"></i></a>
                    </li>
                    
                </ul>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 text-center m-t-lg m-b-lg">
                <p><strong>&copy; 2017 Krece</strong><br/> .</p>
            </div>
        </div>
    </div>
</section>


<!-- Mainly scripts -->
{!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!}
{!!Html::script('/themes/krece/js/bootstrap.min.js')!!} 
{!!Html::script('/themes/krece/js/plugins/metisMenu/jquery.metisMenu.js')!!}
{!!Html::script('/themes/krece/js/plugins/slimscroll/jquery.slimscroll.min.js')!!}

<!-- Custom and plugin javascript -->
{!!Html::script('/themes/krece/js/inspinia.js')!!} 
{!!Html::script('/themes/krece/js/plugins/pace/pace.min.js')!!}
{!!Html::script('/themes/krece/js/plugins/wow/wow.min.js')!!}


<script>

    $(document).ready(function () {

        $('body').scrollspy({
            target: '.navbar-fixed-top',
            offset: 80
        });

        // Page scrolling feature
        $('a.page-scroll').bind('click', function(event) {
            var link = $(this);
            $('html, body').stop().animate({
                scrollTop: $(link.attr('href')).offset().top - 50
            }, 500);
            event.preventDefault();
            $("#navbar").collapse('hide');
        });
    });

    var cbpAnimatedHeader = (function() {
        var docElem = document.documentElement,
                header = document.querySelector( '.navbar-default' ),
                didScroll = false,
                changeHeaderOn = 200;
        function init() {
            window.addEventListener( 'scroll', function( event ) {
                if( !didScroll ) {
                    didScroll = true;
                    setTimeout( scrollPage, 250 );
                }
            }, false );
        }
        function scrollPage() {
            var sy = scrollY();
            if ( sy >= changeHeaderOn ) {
                $(header).addClass('navbar-scroll')
            }
            else {
                $(header).removeClass('navbar-scroll')
            }
            didScroll = false;
        }
        function scrollY() {
            return window.pageYOffset || docElem.scrollTop;
        }
        init();

    })();

    // Activate WOW.js plugin for animation on scrol
    new WOW().init();


</script>

</body>
</html>
