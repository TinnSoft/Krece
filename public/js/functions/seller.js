Vue.config.devtools = true;
Vue.config.debug = true;

var app = new Vue({
  el: '#seller',
  data() {
    return {
      isProcessing: false,
      form: {},
      errors: {}
    }
  },
  created: function () {
    Vue.set(this.$data, 'form', _form);
  },
  methods: {

    create: function () {
      var vm = this;
      vm.isProcessing = true;
      axios.post('/seller', vm.form)
        .then(function (response) {
          if (response.data.created) {
            window.location = '/seller/';
            toastr.success('Registro creado correctamente.', 'Creado', { timeOut: 5000 });
          } else {
            vm.isProcessing = false;
            toastr.error('No se ha podido crear el registro, intente de nuevo.', 'Error', { timeOut: 5000 });
          }
        })
        .catch(function (error) {
          vm.isProcessing = false;
          Vue.set(vm.$data, 'errors', error.response.data);
        });
    },

    update: function () {
      var vm = this;
      vm.isProcessing = true;
      axios.put('/seller/' + vm.form.id, vm.form)
        .then(function (response) {
          if (response.data.updated) {
            window.location = '/seller/';
            toastr.success('Registro actualizado correctamente.', 'Actualizado', { timeOut: 5000 });
          } else {
            vm.isProcessing = false;
          }
        })
        .catch(function (error) {
          vm.isProcessing = false;
          Vue.set(vm.$data, 'errors', error.response.data);
          toastr.error('No se ha podido guardar el registro, intente de nuevo.', 'Error', { timeOut: 5000 });
        })
    }
  }

})
