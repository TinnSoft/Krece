var appLogo = new Vue({
    el: '#logo',
    data: {
        logoSrc: {},
        errors: {}
    },
    created: function () {

        this.fetchData();
    },
    methods: {
        fetchData: function () {
            //carga de los datos del header
            var vm = this
            axios.get('/getLogo')
                .then(function (response) {
                    Vue.set(vm.$data, 'logoSrc', response.data);
                })
                .catch(function (error) {
                    console.log(error)
                })
        },
    }

});