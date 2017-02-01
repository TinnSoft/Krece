
@extends('home')

   

@section('content')
  
    <style>
        .green {color: green;}
        .red {color: red;}
    </style>

 {!!Html::script('/js/vue-library/vue.min.js')!!}
  {!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::script('/js/functions/DataTable_initializer.js')!!}
{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  

    <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2>Cotizaciones</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Cotizaciones</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           

   <div  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
       
            @if( $newestimate->count())  
              <div class="row">            
                <div class="col-lg-12 text-right">
                    <a href="{{route('estimate.create')}}" class="btn btn-primary btn-sm pull-right"> 
                    <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva Cotización</a>                     
                </div>               
            </div>           
            <div class="hr-line-dashed"></div>      

            <div id="sweetalert"  class="ibox-content">
               <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover dataTables-data">
                   
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>Cliente</th>
                        <th>Creacion</th>
                        <th>Total</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>     
                   
                    @foreach ($newestimate as $quot)
                        <tr>                                                  
                            <td><u><a href="{{route('estimate.show', $quot->public_id)}}" >{{$quot->public_id}} </a></u></td>                           
                            <td>{{$quot->contact->name}}</td>
                            <td>{{$quot->created_at->diffForHumans()}}</td>
                             
                            <td>{{$quot->total}}</td>
                            <td class="text-right">
                                <a href="{{route('estimate.show', $quot->public_id)}}" >
                                    <span id="icon-detail" 
                                        title="Ver cotización" 
                                        class="glyphicon glyphicon-eye-open fa-1x green">
                                    </span>
                                </a>
                                <a href="{{route('estimate.edit', $quot->public_id)}}" >
                                    <span id="icon-detail" 
                                        title="Editar cotización" 
                                        class="glyphicon glyphicon-pencil fa-1x green">
                                    </span>
                                </a>
                                <a>
                                    <span id="icon-detail"  
                                        @click="remove({{$quot->id}})" 
                                        title="Eliminar cotización" 
                                        class="glyphicon glyphicon-remove fa-1x red">
                                    </span>
                                </a>
                            </td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>


            {!! $newestimate->render() !!}
            
            @else
                  <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>No.</th>                        
                        <th>Cliente</th>
                        <th>Creación</th>
                        <th>Total</th>
                        <th colspan="2">Acciones</th>
                    </tr>
                </thead>
                </table>
              
                <div class="alert alert-info" role="alert">
                     <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                        <span class="sr-only">Error:</span>
                         Aún no tienes cotizaciones creadas. Por que no empiezas
                        <a href="{{route('estimate.create')}}"><strong>creando una?</a> </strong>
                </div>                   
            @endif
        </div>       
      

    </div>


@include('partials.warm_itemNotFound')

<script>
var app = new Vue({
  el: '#sweetalert',
   data()  {
    return {
    idsel:""
  }},
  methods: {
    remove:function(val) {
      let self = this;
      swal({
        title: "Estas seguro?",
        text: "Una vez eliminado este registro no se podrá recuperar",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        confirmButtonText: 'Si, eliminar',
        cancelButtonText: 'Cancelar',
        closeOnConfirm: false
      }, function(isConfirm) {
        if (isConfirm) {
             var vm = this
            // axios.put('/taxes/' + vm.form.id, vm.form)
                axios.delete('/taxes/' + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                            //vm.$router.push(vm.redirect)
                        }
                    })
                    .catch(function(error) {
                         swal("Error!", "El registro no se ha eliminado correctamente, intente de nuevo!!.", "error");
                        console.log(error)
                    })
          
        } else {
          swal("Cancelado", "Cancelado :)", "error");
        }
      }.bind(this)); 
    }
  }
})
</script>

@endsection




