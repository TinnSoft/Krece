
@extends('home',['title' =>  'Nota Crédito'])

   

@section('content')
  
    <style>
        .green {color: green;}
        .red {color: red;}
    </style>

 {!!Html::script('/js/vue-library/vue.min.js')!!}
  {!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  
  {!!Html::script('/js/libraries/moment.min.js')!!}

    <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2>Nota Débito</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>            
   
      <div id="debitnote_index"  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
                <div class="ibox-content">   
                    <div class="row">
                            <a href="{{route('debit-note.create')}}" class="btn btn-primary btn-sm pull-right"> 
                            <span class="glyphicon glyphicon-plus"></span>&nbsp;Nueva Nota Débito</a>                     
                    </div>                    
                </div>  
               <div class="ibox-content">                                
                    @include('debit-note.index-grid')                           
                </div>  
        </div>   

    </div>


@include('partials.warm_itemNotFound')

<script>

 var debitnoteApp = new Vue({
  el: '#debitnote_index',
   data()  {
    return {
    idsel:""
  }},
  methods: {
      printPdf: function(val){
        window.open('/debit-note/'+val+'/pdf', '_blank');
    },
       goShow: function(val){
        window.location = '/debit-note/'+val;
    },
    goEdit: function(val){
        window.location = '/debit-note/'+val+'/edit';
    },
    moment: function (date) {
        return moment(date).fromNow();
    },
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
                axios.delete('/debit-note/' + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            $('#debitnote-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
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




