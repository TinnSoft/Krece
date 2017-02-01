Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#retention',
  components: {
        "Multiselect": VueMultiselect.Multiselect
    },
  data()  {
    return {
    isProcessing: false,
    form: {},
    errors: {},
    retention:[]
  }},
  created: function () {  
      this.fetchData();
      Vue.set(this.$data, 'form', _form); 
    },

  methods: {  
      onInputretention:function(val)
      {
        if(val)
        {this.form.type_id=val.id; }
        else
        {this.form.type_id=''; }      
      },
      fetchData: function()
      {    
        //carga de los datos del header
        var vm = this
                  axios.get('/getRetentionBaseInfo')
                      .then(function(response) {                              
                          Vue.set(vm.$data, 'retention', response.data);
                      })
                      .catch(function(error) {
                           toastr.warning('Porfavor refresque la pagina nuevamente, algunos datos no se leyeron correctamente.', 'Alerta', {timeOut: 5000});
                      })                  
      },
      create: function() {      
          var vm = this;  
          vm.isProcessing = true;
          axios.post('/retention', vm.form)
            .then(function (response) {
              if(response.data.created) {          
                window.location = '/retention/';
                toastr.success('Registro creado correctamente.', 'Creado', {timeOut: 5000});                
              } else {
                vm.isProcessing = false;
                 toastr.error('No se ha podido crear el registro, intente de nuevo.', 'Error', {timeOut: 5000});
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
        axios.put('/retention/' + vm.form.id, vm.form)
          .then(function(response) {
            if(response.data.updated) {
              window.location = '/retention/';
              toastr.success('Registro actualizado correctamente.', 'Actualizado', {timeOut: 5000});
            } else {             
              vm.isProcessing = false;
            }
          })
          .catch(function(error) {
            vm.isProcessing = false;
            Vue.set(vm.$data, 'errors', error.response.data);
            toastr.error('No se ha podido guardar el registro, intente de nuevo.', 'Error', {timeOut: 5000});
          })
      }   
    }
  
})
