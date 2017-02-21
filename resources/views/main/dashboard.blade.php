
@extends('home',['title' =>  'Inicio'])

@section('content')

<style>
[v-cloak] {
  display: none;
}
</style>

  
<div id="dashboard" v-cloak class="wrapper wrapper-content">
        <div class="row">
            
            <a>
                    <div class="btn-group">                    
                        <button  class="btn btn-outline btn-primary" @click="setIndicator('d')" type="button">Hoy</button>
                        <button  class="btn btn-outline btn-primary"  @click="setIndicator('w')"type="button">Esta semana</button>
                        <button  class="btn btn-outline btn-primary" @click="setIndicator('m')" type="button">Este mes</button>
                        <button  class="btn btn-outline btn-primary"  @click="setIndicator('y')" type="button">Este año</button>
                    </div>
            </a>
             <br><br>
            
                <div class="col-lg-4">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-success pull-right">@{{period_label}}</span>
                                <h5>Ingresos</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">@{{income_value | formatCurrency}}</h1>
                                <div class="stat-percent font-bold text-success"> <i class="fa fa-level-up"></i></div>
                                <small>Total entradas</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-info pull-right">@{{period_label}}</span>
                                <h5>Egresos</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">@{{outcome_value | formatCurrency}}</h1>
                                <div class="stat-percent font-bold text-info"><i class="fa fa-level-down"></i></div>
                                <small>Total gastos</small>
                            </div>
                        </div>
                    </div>
              
            <div class="col-lg-4">
                <div class="sidebar-panel">
                    <div>
                        <h4>Historial <span class="badge badge-info pull-right">{{$historical->count()}}</span></h4>
                        <div class="feed-activity-list">

                            <template v-for="history in log">
                                <div class="feed-element">                       
                                    <div v-if="!history.route"class="media-body">
                                        @{{history.detail}}
                                    </div>
                                    <div v-else class="media-body">
                                        @{{history.detail}} <strong><a href="">Ver...</a></strong>
                                    </div>
                                    <small class="text-muted">Usuario: @{{history.user.email}} </small><br>
                                     <small class="text-navy"> <i class="fa fa-clock-o"></i> @{{history.created_at}}</small>
                                </div> 
                            </template>
                            @if($historical->count()>0)
                            <button class="btn btn-primary btn-block m-t"><i class="fa fa-arrow-right"></i> Ver todo</button>
                            @endif
                        </div> 
                    </div>
                </div>
            </div>
            
            <div class="col-lg-8">

                 
                        <div class="ibox float-e-margins">
                            <div class="ibox-content">
                                    <div>
                                        <span class="pull-right text-right">
                                        <small>Ventas realizadas vs gastos</small>
                                            <br/>
                                            
                                        </span>
                                        <h1 class="m-b-xs">$ 50,992</h1>
                                        <h3 class="font-bold no-margins">
                                            Margen de ingresos
                                        </h3>
                                        <small>Ventas</small>
                                    </div>

                                <div>
                                   
                                   
                                   <chartjs-line 
                                            :labels="graph.rowlabels" 
                                            :datasets="graph.datasets"
                                            :option="graph.lineOptions"
                                            ></chartjs-line>
                                </div>


                            </div>
                        </div>
                 
            </div>

           

        </div>


        
            

      @push('scripts')

        {!!Html::script('/js/libraries/axios.min.js')!!}
        {!!Html::script('/js/vue-library/vue.min.js')!!}
        {!!Html::script('/js/libraries/accounting.js')!!}
        {!!Html::script('/themes/krece/js/plugins/chartJs/Chart.min.js')!!}
        {!!Html::script('/themes/krece/js/plugins/chartJs/vue-charts.js')!!}

        <script type="text/javascript">
            
            Vue.config.devtools = true;
            Vue.config.debug = true;
            
         
             Vue.use(VueCharts);
            var appDashboard = new Vue({
            el: '#dashboard',          
            data: {
                income_value:null,
                outcome_value:null,
                period_label:'Hoy',
                YearLabels:["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio","Agosto",
                    "Septiembre","Octubre","Noviembre","Diciembre"],
                log: {},
                errors: {},
                income:{},
                outcome:{},
                graph:{
                    rowlabels: [],
                    lineOptions: {
                                responsive:true,
                                maintainAspectRatio:true,},
                    datasets:[{
                        
                        label: "Ingresos",
                        fill: true,
                        //lineTension: 0.1,
                        backgroundColor: "rgba(26,179,148,0.5)",
                        borderColor:  "rgba(26,179,148,0.7)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "#fff",
                        pointBackgroundColor: "rgba(26,179,148,1)",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgba(75,192,192,1)",
                        pointHoverBorderColor: "rgba(220,220,220,1)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 1,
                        pointHitRadius: 10,
                        data: [65, 59, 80, 81, 56, 55, 40,0],
                        spanGaps: false,
                    },
                    {
                        label: "Gastos",
                        fill: true,
                        //lineTension: 0.1,
                        backgroundColor: "rgba(235, 200, 181,0.4)",
                        borderColor: "rgba(245, 127, 64,1)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgba(245, 127, 64,1)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgba(245, 127, 64,1)",
                        pointHoverBorderColor: "rgba(245, 127, 64,1)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 1,
                        pointHitRadius: 10,
                        data: [0, 20, 40, 41, 66, 25, 80,0],
                        spanGaps: false,
                    },]
                }
            },
            created: function () {
                Vue.set(this.$data, 'log', {!! $historical->toJson() !!});
                Vue.set(this.$data, 'income', {!! $income->toJson() !!});
                Vue.set(this.$data, 'outcome', {!! $outcome->toJson() !!});
                Vue.set(this.$data, 'income_value', this.income.day);
                Vue.set(this.$data, 'outcome_value', this.outcome.day);
                this.graph.rowlabels=this.YearLabels;
            },
            methods: {   
                setIndicator: function(val){
                   
                    if(val=='d')
                    {
                         this.income_value=this.income.day;
                         this.outcome_value=this.outcome.day;
                         this.period_label="Hoy";
                    }
                    else if(val=='w')
                    {
                         this.income_value=this.income.week;
                         this.outcome_value=this.outcome.week;
                         this.period_label="Ésta semana";
                    }
                    else if(val=='m')
                    {
                         this.income_value=this.income.month;
                         this.outcome_value=this.outcome.month;
                         this.period_label="Éste mes";
                    }
                    else if(val=='y')
                    {
                         this.income_value=this.income.year;
                         this.outcome_value=this.outcome.year;
                         this.period_label="Último año";
                    }
                }
            },
            filters: {
                formatCurrency:function(value)
                {
                     return accounting.formatMoney(value);
                }
            }

            })

            
        </script>
  
    
    @endpush




@endsection




