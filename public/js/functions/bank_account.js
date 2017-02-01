Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#bank_account',
  components: {
        "Multiselect": VueMultiselect.Multiselect
    },
  data()  {
    return {
    isProcessing: false,
    name: '',
    form: {},
    errors: {},
    bank_account:[]
  }},

  created: function () {  
      this.fetchData();
      Vue.set(this.$data, 'form', _form); 
    },
  methods: {  
      onInputType:function(val)
      {
        if(val)
        {this.form.bank_account_type=val.id; }
        else
        {this.form.bank_account_type=''; }      
      },
      fetchData: function()
      {    
        var vm = this;
       
                  axios.get('/getBankAccount_Type')
                      .then(function(response) {                   
                          Vue.set(vm.$data, 'bank_account', response.data);
                      })
                      .catch(function(error) {
                        console.log(error);
                      })                  
      },
      create: function() {      
          var vm = this;
          vm.isProcessing = true;
          axios.post('/bank_account', vm.form)
            .then(function (response) {
              if(response.data.created) {          
                window.location = '/bank_account';
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
        axios.put('/bank_account/' + vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {
              toastr.success('Registro actualizado correctamente.', 'Actualizado', {timeOut: 5000});
              window.location = '/bank_account';               
            } else {             
              vm.isProcessing = false;
              toastr.warning('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
            }
          })
          .catch(function(error) {
            vm.isProcessing = false;
            Vue.set(vm.$data, 'errors', error.response.data);
            toastr.error('No se ha podido actualizar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
          })
      }   
    }  
})


