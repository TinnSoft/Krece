@extends('home',['title' =>  'Bancos'])

@section('content')

{!!Html::script('/js/vue-library/vue.min.js')!!}
{!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::script('/js/components/vue-multiselect/multiselect.min.js')!!}
{!!Html::script('/themes/krece/js/plugins/datapicker/bootstrap-datepicker.js')!!}    
{!!Html::style('/themes/krece/css/plugins/datapicker/datepicker3.css')!!}
{!!Html::script('/js/components/datepicker/datepicker-locale.es.min.js')!!}
{!!Html::script('/js/components/datepicker/datepicker-vue.js')!!} 
{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
{!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!} 

    <div class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2>Bancos</h2>
                <ol class="breadcrumb">
                <li>
                    <a href="{{route('bank_account.index')}}">Inicio</a>
                </li>
                <li class="active">
                    <strong>Ver</strong>                            
                </li>
            </ol>
        </div>
                
    </div>           
 
    <div id="bank" class="row wrapper wrapper-content">
      
            <div  class="ibox-title">
                 <div class="ibox-content">
                    <p>
                        <div class="col-lg-6">
                        <label><span>Banco</span></label>
                           <multiselect 
                                v-model="bank_account" 
                                :options="bank" 
                                :multiple="false" 
                                group-values="bank" 
                                group-label="description" 
                                placeholder="Seleccione..." 
                                track-by="bank_account_name" 
                                label="bank_account_name"
                                :show-labels="false"
                                :allow-empty="false"
                                 @input="onInputBank">                                
                        </multiselect>
                       
                        </div>
                        <div class="col-lg-6">
                            <div class="row">   
                                <div class="col-lg-12 text-right">
                                    <div class="btn-group ">
                                            <button data-toggle="dropdown" 
                                                    class="btn btn-info  btn-sm dropdown-toggle ">Mas acciones 
                                                <span class="caret">
                                                </span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a href="{{route('bank_account.edit', $account)}}">Editar</a></li>
                                                <li><a >Desactivar</a></li>                                               
                                                <li class="divider"></li>
                                                 <li><a >Ver conciliaciones</a></li>
                                            </ul>
                                        </div>
                                        
                                    <a href="{{route('bank_account.create')}}" class="btn btn-primary btn-sm "> 
                                        <span class="glyphicon glyphicon-plus">
                                        </span>&nbsp;Nuevo banco
                                    </a>                     
                                </div>               
                            </div>           
                        </div>
                    </p>
                   
            </div>
            
        </div>
        <div  class="ibox-title">
            <div class="ibox-content">
                 <p>
                        <a class="btn btn-primary  btn-outline btn-sm " @click="addMoney()"> 
                            <span class="fa fa-plus">
                            </span>&nbsp;Agregar dinero
                        </a> 
                        <a class="btn btn-primary  btn-outline btn-sm "  @click="removeMoney()"> 
                            <span class="fa fa-minus">
                            </span>&nbsp;Retirar dinero
                        </a> 
                        <a data-toggle="modal" class="btn btn-primary  btn-outline btn-sm " @click="addNewTransference"> 
                            <span class="fa fa-exchange">
                            </span>&nbsp;Transferir
                        </a> 
                      
                    </p>
            </div>
        </div>
       @include('bank_account.transference_modal',['header_modal'=>''])
       <pre>@{{$data}}</pre>
 </div>
          
    

<script>
var app = new Vue({
  el: '#bank',
   components: {
        "Multiselect": VueMultiselect.Multiselect
    },
   data()  {
    return {
        bank_account:[],
        bank_account_to:[],
        isProcesing:true,
        bank: [],
        transfer:{
            account_from:'',
            account_to:'',
            amount:'',
            date:'',
            observations:''
        },
        form:{}
  }},
  created: function () {
      this.fetchData();
      this.getCurrentDate();
  },
  watch: {
        'transfer.account_from': function (val) {
           this.allowToSave()
        },
        'transfer.account_to': function (val) {
           this.allowToSave()
        },
        'transfer.amount': function (val) {
           this.allowToSave()
        },
    },
   methods: {
       allowToSave: function ()
       {
            if ((this.transfer.account_from != '') && (this.transfer.account_to != '') && (this.transfer.amount > 0))
            {
                this.isProcesing=false;
            }
            else
            {
                 this.isProcesing=true;
            }
       },
        getCurrentDate: function () {
            var d = new Date();
            var n = d.toLocaleDateString();
            this.transfer.date = n;
           
        },
        accountTo: function (val) {
            if (val)
            { 
                this.transfer.account_to = val.id; 
            }
            else
            { this.transfer.account_to = ''; }
        },
         accountFrom: function (val) {
            if (val)
            { 
                this.transfer.account_from = val.id; 
            }
            else
            { this.transfer.account_from  = ''; }
        },
         onInputBank: function (val) {
            if (val)
            { this.bank_account_id = val.id; 
                this.goShow(val.id);
            }
            else
            { this.bank_account_id = ''; }
        },
    goShow: function(val){
        window.location = '/bank_account/'+val;
    },
     addMoney: function(val){
        window.location = '/payment-in/create';
    },
     removeMoney: function(val){
        window.location = '/payment-out/create';
    },
    fetchData: function () {
      var vm = this
      axios.get('/getPaymentBaseInfo')
        .then(function (response) {
        Vue.set(vm.$data, 'bank_account', {!!$account!!});        
          Vue.set(vm.$data, 'bank', response.data.bank); 
          Vue.set(vm.$data.transfer, 'account_from', vm.bank_account.id); //Inicializa el array de transferencia
        })
        .catch(function (error) {
          Vue.set(vm.$data, 'errors', error);
        })
    },
      addNewTransference: function(e) {  
        var vm = this;
          vm.transfer.observations='';
          vm.transfer.account_to='';
          vm.transfer.amount='';
          vm.bank_account_to=[];
          $('#transferenceModal').modal('toggle')        
      },
      preparePaymentBeforeSave: function() //Prepara el objeto de pago para ser enviado 
      {
        var vm=this;
        vm.form={};
        Vue.set(vm.$data.form, 'date', vm.transfer.date); 
        Vue.set(vm.$data.form, 'payment_method_id', ''); 
        Vue.set(vm.$data.form, 'bank_account_id', ''); 
      },
     create: function () {
      var vm = this;
      vm.isProcessing = true;
      $('#transferenceModal').modal('toggle')
      console.log(vm.form);
      return false;
     
      axios.post('/payment-out/', vm.form)
        .then(function (response) {
          if (response.data.created) {
              swal("Creado!", "El registro ha sido creado correctamente!!.", "success");
          } else {
            vm.isProcessing = false;
            swal("Oops..!", "No se ha podido realizar la transferencia, intente nuevamente!!.", "error");
          }
        })
        .catch(function (error) {
          vm.isProcessing = false;
          Vue.set(vm.$data, 'errors', error.response.data);
        });
        $('#transferenceModal').modal('toggle')
    },

   }

 
})


</script>

 

@endsection
