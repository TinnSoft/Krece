@extends('home',['title' =>  'Bancos'])

@section('content')
<style>
[v-cloak] {
  display: none;
}
</style>

{!!Html::script('/js/vue-library/vue.min.js')!!}
{!!Html::script('/js/libraries/axios.min.js')!!}
{!!Html::script('/js/components/vue-multiselect/multiselect.min.js')!!}

{!!Html::style('/themes/krece/css/plugins/sweetalert/sweetalert.min.css')!!}  
{!!Html::script('/themes/krece/js/plugins/sweetalert/sweetalert.min.js')!!} 
{!!Html::script('/js/libraries/accounting.js')!!}

    <div class="row wrapper border-bottom white-bg page-heading">
            <div class="col-sm-4">
                <h2><span class ='fa fa-bank '></span>&nbsp;Bancos</h2>
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
    
   
                
    <div id="bank" class="row wrapper wrapper-content" v-cloak>
           
              <div class="row">
                    <div class="col-lg-5">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-success pull-right">hasta la fecha</span>
                                <h5>Saldo</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">@{{bank_account.initial_balance | formatCurrency}}</h1>
                                <small>Total saldo</small>
                            </div>
                        </div>
                    </div>
                       <div class="col-lg-5">
                                <div class="ibox float-e-margins">
                                    <div class="ibox-title">
                                        <h5>Gestion</h5>
                                        <div class="ibox-tools">
                                            <a class="collapse-link">
                                                <i class="fa fa-chevron-up"></i>
                                            </a>                                           
                                        </div>
                                    </div>
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
                            </div>

            </div>
            
                <div  class="ibox-title">
                    <div class="ibox-content">
                        <p>
                            <div class="col-lg-5">
                                <label><span>BANCO</span></label>
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
                        </p>
                    </div>
                </div>
         

            <div  class="ibox-title">
                <div class="ibox-content">
                    <p>                        
                            <a class="btn btn-primary  btn-outline btn-sm " @click='goEdit()'> 
                                <span class="fa fa-pencil">
                                </span>&nbsp;Editar
                            </a>   
                            <a class="btn btn-primary  btn-outline btn-sm "> 
                                <span class="fa fa-lock">
                                </span>&nbsp;Desactivar
                            </a>       
                            <a href="{{route('bank_account.create')}}" class="btn btn-primary btn-sm "> 
                            <span class="glyphicon glyphicon-plus">
                                </span>&nbsp;Nuevo banco
                            </a>                     
                                        
                        </p>
                </div>
                @include('bank_account.transferences-grid')
            </div>
       
       @include('bank_account.transference_modal',['header_modal'=>''])
       
 </div>
          
    

<script>
var appBankAccountShow = new Vue({
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
        errors:{},
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
        paymentOUT_printPdf: function(val){
            window.open('/payment-out/'+val+'/pdf', '_blank');
        },
       paymentOUT_Show: function(val){
            window.location = '/payment-out/'+val;
        },
        paymentOUT_Edit: function(val){
            window.location = '/payment-out/'+val+'/edit';
        },
        paymentIN_Show: function(val){
            window.location = '/payment-in/'+val;
        },
        paymentIN_Edit: function(val){
            window.location = '/payment-in/'+val+'/edit';
        },
       goEdit: function(){
        window.location = '/bank_account/'+this.bank_account.id+'/edit';
        },
       getwarningMessage: function(){
        if (this.transfer.amount > this.bank_account.initial_balance)
        {
            return true;
        }
        return false;
       } ,
       allowToSave: function ()
       {
           this.isProcesing=true;
            if ((this.transfer.account_from != '') && (this.transfer.account_to != '') 
            && (this.transfer.amount > 0) && (this.transfer.amount <= this.bank_account.initial_balance))
            {
                this.isProcesing=false;
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
     
     create: function () {
      var vm = this;
      vm.isProcessing = true;
     
      axios.post('/saveBankTransference/', vm.transfer)
        .then(function (response) {
          if (response.data.created) {
              swal("Creado!", "El registro ha sido creado correctamente!!.", "success");
             location.reload(); //recargar la página nuevamente
          } else {
            vm.isProcessing = false;
            swal("Oops..!", "No se ha podido realizar la transferencia, intente nuevamente!!.", "error");
            Vue.set(vm.$data, 'errors', error.response.data);
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
/*Formato de moneda */
Vue.filter('formatCurrency', function (value) {
  return accounting.formatMoney(value);
});


</script>

 

@endsection
