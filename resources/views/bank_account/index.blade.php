
@extends('home',['title' =>  'Bancos'])

   

@section('content')
  
    <style>
        .green {color: green;}
        .red {color: red;}
    </style>

 {!!Html::script('/js/vue-library/vue.min.js')!!}
  {!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
  {!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!}  

    <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-sm-4">
                    <h2>Bancos</h2>
                    <ol class="breadcrumb">
                        <li class="active">
                            <strong>Inicio</strong>      
                        </li>
                    </ol>
                </div>                
            </div>           

   <div  class="row  border-bottom white-bg dashboard-header">
        <div class="panel-body">
       
           
              <div class="row">            
                <div class="col-lg-12 text-right">
                    <a href="{{route('bank_account.create')}}" class="btn btn-primary btn-sm btn-rounded pull-right"> 
                    <span class="glyphicon glyphicon-plus"></span>&nbsp;Nuevo banco</a>                     
                </div>               
            </div>           
            <div class="row">                                
                    @include('bank_account.index-grid')                     
            </div>       
        </div>   
    </div>


@include('partials.warm_itemNotFound')

<script>
var appBank = new Vue({
  el: '#sweetalert',
    data: function () {
    return {     
      bank: [],
      redirect: '/bank_account/',
    }
  },
  filters:{
       formatCurrency: function (value) {
      return accounting.formatMoney(value);
    }
  },
  
  methods: {     
    onInputBank: function (val) {
      if (val)
      { this.form.bank_account_id = val.id; }
      else
      { this.form.bank_account_id = ''; }
    },
    goShow: function(val){
        window.location = this.redirect+val;
    },
    goEdit: function(val){
        window.location = this.redirect+val+'/edit';
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
                axios.delete(this.redirect + val)
                    .then(function(response) {
                        if(response.data.deleted) {
                            swal("Eliminado!", "El registro ha sido eliminado correctamente!!.", "success");
                             $('#bankaccount-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');            
                        }
                    })
                    .catch(function(error) {
                         swal("Error!", "El registro no se ha eliminado correctamente, intente de nuevo!!.", "error");
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




