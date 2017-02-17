Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#payment',
  components: {
        "Multiselect": VueMultiselect.Multiselect
    },
  data:function()  {
    return {
    hasPendingPayment:1,
    isProcessing: false,
    form: {},
    errors: {},
    customer_list:[],
    paymentmethod:[],
    currency:[],  
    bank:[],
    redirect: '/payment/',  
  }},
    //similar on load event

  created: function () {  
      this.fetchData();
      Vue.set(this.$data, 'form', _form); 
    },
  beforeMount() {
             this.getCurrentDate();
        },

  methods: {  
       goShow: function(val){
        window.location = '/invoice/'+val;
      },
      //obtener el listado de facturas de venta pendientes por pagar
      getInvoiceSale:function()
      {
         var vm=this;   
          vm.hasPendingPayment=1;   
        if ( vm.form.isInvoice==1 && vm.form.customer_id!='')
        {
             var vm = this
                  axios.get('/getInvoicePendingtoPay/'+vm.form.customer_id)
                      .then(function(response) {                                                    
                          Vue.set(vm.$data.form, 'pending_payment_in', response.data.PendingByPayment);
                          
                          if (response.data.PendingByPayment.length==0)
                          {
                            vm.hasPendingPayment=0;
                          }
                          
                      })
                      .catch(function(error) {  
                          Vue.set(vm.$data, 'errors', error);                          
                      })            
        }      
      },
      DisplayPendingInvoiceSale:function()
      { 
        var vm=this;      
        if ( vm.form.isInvoice==1 && vm.form.customer_id!='' && vm.form.pending_payment_in.length>0)
        {
          return true;
        }        
        return false;
      },

      wasCustomerSelected:function()
      {
        var vm=this;
        if ( vm.form.isInvoice==1 && vm.form.customer_id=='')
        {
          return false;
        }     
        return true;
      },
      onInputContact:function(val)
      {
        
        if(val!='' && val)
        {
          this.form.customer_id=val.id; 
          this.getInvoiceSale();
        }
        else
        {
          this.form.customer_id=''; 
        }      
      },
      onInputBank:function(val)
      {
        if(val)
        {this.form.bank_account_id=val.id; }
        else
        {this.form.bank_account_id=''; }      
      },
     
      onInputPaymentMethod:function(val)
      {
        if(val)
        {this.form.payment_method_id=val.id; }
        else
        {this.form.payment_method_id=''; }   
      },
      
      getCurrentDate: function()
      {
        var d = new Date();      
        var n = d.toLocaleDateString();
        if (this.form.date=="")
        {
          this.form.date=n;
        }
      },
    
      fetchData: function()
      {    
        //carga de los datos del header
        var vm = this
                  axios.get('/getPaymentBaseInfo')
                      .then(function(response) {                          
                          Vue.set(vm.$data, 'customer_list', response.data.contacts);                        
                            Vue.set(vm.$data, 'paymentmethod', response.data.paymentmethod);
                          Vue.set(vm.$data, 'bank', response.data.bank);

                          if (vm.$data.form.resolution_id=="")
                          {                          
                            vm.$data.form.resolution_id=response.data.resolution_id.number;
                          }                          

                      })
                      .catch(function(error) {  
                          Vue.set(vm.$data, 'errors', error);
                      })                  
      },
      create: function() {      
          var vm = this;
          vm.isProcessing = true;
          axios.post(vm.redirect, vm.form)
            .then(function (response) {
              if(response.data.created) {          
                window.location = vm.redirect + response.data.id;
              } else {
                vm.isProcessing = false;
              }
            })
            .catch(function (error) {        
              vm.isProcessing = false;
              Vue.set(vm.$data, 'errors', error.response.data);
            });
      },

      update: function() {
      var vm = this;    
        vm.isProcessing = true;
        axios.put(vm.redirect+ vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {
               vm.isProcessing = false;             
                window.location =vm.redirect + response.data.id;;
            } else {             
              vm.isProcessing = false;
            }
          })
          .catch(function(error) {
            vm.isProcessing = false;
            Vue.set(vm.$data, 'errors', error.response.data);
          })
      }   
    },  
 //valores calculados
  computed: {
    GrandTotal: function() {
      var _total= this.form.pending_payment_in.reduce(function(carry, pending_payment_in) {
        return carry + (parseFloat(pending_payment_in.amount_receipt));
      }, 0);
      _total=isNaN(_total) ? 0:_total;
       this.form._total=_total;
      return _subtotal;
    }

   
    }
})


/*Formato de moneda */
Vue.filter('formatCurrency', function (value) {
   return accounting.formatMoney(value);
});
