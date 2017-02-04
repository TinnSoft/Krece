

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>Bienvenido a Krece</title>
     
    {!!Html::style('/themes/krece/css/plugins/select2/select2.min.css')!!}
    {!!Html::style('/themes/krece/css/bootstrap.min.css')!!}
    {!!Html::style('/themes/krece/font-awesome/css/font-awesome.css')!!}
    {!!Html::style('/themes/krece/css/animate.css')!!}
    {!!Html::style('/themes/krece/css/style.css')!!}
    {!!Html::style('/themes/krece/css/plugins/dataTables/datatables.min.css')!!}
    {!!Html::style('/themes/krece/css/plugins/toastr/toastr.min.css')!!}
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!}
    {!!Html::script('/js/libraries/moment.min.js')!!}
    


</head>

<body class="fixed-sidebar fixed-navbar md-skin">

    <div id="wrapper">
    
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav metismenu" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element"> <span>
                            <!--<img alt="image" class="img-circle" src="/themes/krece/img/krece.png" />-->
                             </span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold">{{Auth::user()->email}}</strong>
                             </span> <span class="text-muted text-xs block">Opciones<b class="caret"></b></span> </span> </a>
                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                <li><a href="">Mi Perfil</a></li>
                                <li><a href="">Configuración</a></li>
                                <li class="divider"></li>
                                <li><a href="{{ url('/logout') }}"  onclick="event.preventDefault();
                                                     document.getElementById('logout-form').submit();">Salir</a></li>
                                 <form id="logout-form" action="{{ url('/logout') }}" method="POST" style="display: none;">
                                            {{ csrf_field() }}
                                        </form>
                            </ul>
                        </div>
                        <div class="logo-element">
                            K+
                        </div>
                    </li>
                        <li>
                        <a href=""><i class="fa fa-windows"></i> <span class="nav-label">Inicio</span> </a>
                        
                       </li>
                         <li>
                        <a href=""><i class="fa fa-line-chart"></i> <span class="nav-label">Mis Ingresos </span><span class="fa arrow"></span></a>
                     
                        <ul class="nav nav-second-level collapse">
                            <li><a href="">Factura de venta</a></li>
                            <li><a href="">Factura recurrente</a></li>
                            <li><a href="">Pagos recibidos</a></li>
                            <li><a href="">Notas credito</a></li>       
                            <li><a href="{{route('estimate.index')}}">Cotizaciones</a></li>
                        </ul>
                    </li>
                    
                     <li>
                        <a href=""><i class="fa fa-money"></i> <span class="nav-label">Mis Gastos </span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level collapse">
                            <li><a href="">Pagos</a></li>
                            <li><a href="">Factura proveedores</a></li>
                            <li><a href="">Pagos recurrentes</a></li>
                            <li><a href="">Notas débito</a></li>
                            <li><a href="">Ordenes de compra</a></li>
                        </ul>
                    </li>

                           <li>
                        <a ><i class="fa fa-users"></i> <span class="nav-label">Mis contactos</span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level collapse">
                            <li><a href="{{route('contact.index')}}">Contactos</a></li>
                            <li><a href="{{route('seller.index')}}">Vendedores</a></li>
                        </ul>
                    </li>                    

                          <li>
                        <a href=""><i class="fa fa-cubes"></i> <span class="nav-label">Mi Inventario</span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level collapse">
                            <li><a href="{{route('inventory.index')}}">Items de venta</a></li>
                            <li><a href="">Valor de inventario</a></li>
                            <li><a href="">Ajuste de inventario</a></li>                            
                            <li><a href="{{route('list_price.index')}}">Lista de precio</a></li>
                        </ul>
                    </li>
                    
                    <li >
                        <a href="{{route('bank_account.index')}}"><i class="fa fa-bank"></i> <span class="nav-label">Bancos</span> </a>
                    </li>
                    <li>
                        <a href=""><i class="fa fa-book"></i> <span class="nav-label">Categorias</span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level collapse">
                            <li><a href="{{route('category.index')}}">Categorias</a></li>
                            <li><a href="">Ajustes</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href=""><i class="fa fa-cogs"></i> <span class="nav-label">Configuración</span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level collapse">
                            <li><a href="{{route('taxes.index')}}">Impuestos</a></li>
                            <li><a href="{{route('retention.index')}}">Retenciones</a></li>
                            <li><a href="{{route('payterms.index')}}">Términos de Pago</a></li>
                            <li><a href="{{route('profile.edit',Auth::user()->id)}}">Mi perfil</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href=""><i class="fa fa-dashboard"></i> <span class="nav-label">Reportes</span></a>                       
                    </li>

                </ul>
                 
            </div>
            
        </nav>

        <div id="page-wrapper" class="gray-bg dashbard-1">
        <div class="row border-bottom">
        <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
            <form role="search" class="navbar-form-custom" action="">
                <div class="form-group">
                    <input type="text" placeholder="Buscar...." class="form-control" name="top-search" id="top-search">
                </div>
            </form>
        </div>
            <ul class="nav navbar-top-links navbar-right">
                <li>
                    <a>
                     <i class="fa fa-cogs"></i> Configuración
                    </a>                    
                </li>

                 <li>
                    <a>
                     <i class="fa fa-comments"></i> Soporte
                    </a>                    
                </li>

                 <li>
                    <a>
                     <i class="fa fa-exclamation-circle"></i> Ayuda
                    </a>                    
                </li>       
                              
                <li class="dropdown">
                    <a class="dropdown-toggle count-info" data-toggle="dropdown" href="">
                        <i class="fa fa-bell"></i>  <span class="label label-primary">0</span>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts">
                        <li>
                            <a href="">
                                <div>
                                    <i class="fa fa-envelope fa-fw"></i> Tienes notificaciones pendientes por leer
                                    <span class="pull-right text-muted small">Hace 1 minuto</span>
                                </div>
                            </a>
                        </li>                        
                        <li class="divider"></li>
                        <li>
                            <div class="text-center link-block">
                                <a href="notifications.html">
                                    <strong>Ver todas las alertas</strong>
                                    <i class="fa fa-angle-right"></i>
                                </a>
                            </div>
                        </li>
                    </ul>
                </li>


                <li>
                    <a  href="{{ url('/logout') }}"  onclick="event.preventDefault();
                                                     document.getElementById('logout-form').submit();">
                        <i class="fa fa-sign-out"></i> Salir
                    </a>

                                 <form id="logout-form" action="{{ url('/logout') }}" method="POST" style="display: none;">
                                            {{ csrf_field() }}
                                        </form>
                </li>

            </ul>

        </nav>
        </div>
         
              
                @yield('content')  

        </div>
      
       
    </div>


    @stack('scripts')


    {!!Html::script('/themes/krece/js/bootstrap.min.js')!!}  
    {!!Html::script('/themes/krece/js/inspinia.js')!!}  
    {!!Html::script('/themes/krece/js/plugins/metisMenu/jquery.metisMenu.js')!!}
    {!!Html::script('/themes/krece/js/plugins/slimscroll/jquery.slimscroll.min.js')!!} 
    {!!Html::script('/themes/krece/js/plugins/pace/pace.min.js')!!}
    {!!Html::script('/themes/krece/js/plugins/select2/select2.full.min.js')!!}
     {!!Html::script('/themes/krece/js/plugins/dataTables/datatables.min.js')!!}
     {!!Html::script('/themes/krece/js/plugins/toastr/toastr.min.js')!!}
     
     

</body>

</html>
