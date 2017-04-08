
@extends('home',['title' =>  'Inicio'])

@section('historical_bar')

     <a class="right-sidebar-toggle">
           <i class="fa fa-history"></i>Historial
     </a>

@endsection

@section('content')

<style>
[v-cloak] {
  display: none;
}
</style>



  
<div id="dashboard" v-cloak class="wrapper wrapper-content">

        <div id="right-sidebar" class="animated">
                <div class="sidebar-container">

                    <ul class="nav nav-tabs navs-3">
                        <li class="active"><a data-toggle="tab" href="#tab-1">
                            <i class="fa fa-history"></i>Historial
                            </a>
                        </li>                  
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                        
                            <ul class="sidebar-list">
                                        <template v-for="history in log">

                                             <li>
                                                 <div class="media-body">          
                                                <div v-if="!history.route" class="media-body">
                                                    @{{history.detail}}
                                                </div>
                                                <div v-else class="media-body">
                                                    @{{history.detail}} <strong><a :href="history.route"><br>ver...</a></strong>
                                                </div>
                                                <small class="text-muted">Usuario: @{{history.user.email}} </small><br>
                                                <small class="text-navy"> <i class="fa fa-clock-o"></i> @{{history.created_at}}</small>
                                            </div></li>
                                        </template>
                                        @if($historical->count()>0)
                                        <button class="btn btn-primary btn-block m-t"><i class="fa fa-arrow-right"></i> Ver todo</button>
                                        @endif 
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
 
    
        <div class="row ">
            <div class="col-sm-4 m-b-xs">
                <div data-toggle="buttons" class="btn-group">
                    <label class="btn btn-sm btn-outline btn-primary active" @click="setIndicator('d')" > <input type="radio" id="option1" name="options"> Hoy </label>
                    <label class="btn btn-sm btn-outline btn-primary " @click="setIndicator('w')"> <input type="radio"  id="option2" name="options"> Esta semana </label>
                    <label class="btn btn-sm btn-outline btn-primary" @click="setIndicator('m')"> <input type="radio"  id="option3" name="options"> Este mes </label>
                    <label class="btn btn-sm btn-outline btn-primary" @click="setIndicator('y')"> <input type="radio"  id="option4" name="options"> Este año </label>
                </div>
            </div>

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
                            
           
           
        </div>

        <div class="row white-bg ">

            <div class="col-lg-8 ">
                            <div class="ibox-content">
                                    <div>
                                        <span class="pull-right text-right">
                                        <small>Ventas realizadas vs gastos</small>
                                            <br/>                                            
                                        </span>
                                        <h1 class="m-b-xs">@{{income_value-outcome_value | formatCurrency}}</h1>
                                        <h3 class="font-bold no-margins">
                                            Margen de ingresos
                                        </h3>
                                        <small>Ventas</small>
                                    </div>
                                <div>
                                   <chartjs-line 
                                            :height="120"
                                            :labels="graph.rowlabels" 
                                            :datasets="graph.datasets"
                                            :option="graph.lineOptions"
                                            :bind="true"
                                            >
                                    </chartjs-line>

                                   
                                </div>
                            </div>
                        </div>     
                        <div class="col-lg-4 ">
                            <div class="ibox-content">
                                <h4>
                                    Distribución de gastos principales
                                </h4>
                                <div class="row text-center">
                                        <chartjs-doughnut  
                                            :datalabel="'TestDataLabel'" 
                                            :scalesdisplay="false"
                                            :width="150"                                        
                                            :option="doughnut._options"
                                            :labels="doughnut.d_labels" 
                                            :datasets="doughnut.d_dataset"
                                            :bind="true">
                                        </chartjs-doughnut>
                                </div>
                            </div>     
                        </div>            
            </div>


            

      @push('scripts')

      
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
                data2: [1, 2, 3, 4, 5, 6, 7,8],
                graph_data:[],
                pie_data:[],
                period_label:'Hoy',
                YearLabels:["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio","Agosto",
                    "Septiembre","Octubre","Noviembre","Diciembre"],
                WeekLabels:["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"],
                log: {},
                errors: {},
                income:{},
                outcome:{},
                doughnut:{
                     _options:{
                            responsive:true,
                            maintainAspectRatio:true,
                            legend: {
                                        display: true,
                                         position: 'bottom',
                                    }
                            },
                    d_labels: [],
                    d_dataset:[{
                        data: [],
                        backgroundColor: [
                            "#81DAF5",
                            "#a3e1d4",
                            "#FDD6C1",
                            "#9CC3DA",
                            '#17A589',
                            "#dedede"                            
                        ],
                       
                    }]                         
                },
                graph:{
                    rowlabels: [],
                    lineOptions: {
                                responsive:true,
                                maintainAspectRatio:true,
                                scales: {
                                        yAxes: [{
                                            ticks: {
                                               
                                            callback: function(value, index, values) {
                                                return value.toLocaleString("en-US",{style:"currency", currency:"USD"});
                                            }
                                            }
                                        }]
                                        }},
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
                Vue.set(this.$data, 'graph_data', {!! $graph_data->toJson() !!});
                Vue.set(this.$data, 'pie_data', {!! $pie_data->toJson() !!});
                Vue.set(this.$data, 'income_value', this.income.day);
                Vue.set(this.$data, 'outcome_value', this.outcome.day);

                this.graph.datasets[0].data=this.graph_data.weekData_income;
                this.graph.datasets[1].data=this.graph_data.weekData_outcome;
                this.graph.rowlabels=this.WeekLabels;
                
                this.doughnut.d_labels=this.pie_data.isToday.name;
                this.doughnut.d_dataset[0].data=this.pie_data.isToday.total;
                
            },
            methods: { 
                setIndicator: function(val){
                   
                    if(val=='d')
                    {
                        this.income_value=this.income.day;
                        this.outcome_value=this.outcome.day;
                        this.period_label="Hoy";
                        this.graph.rowlabels=this.WeekLabels;
                        this.graph.datasets[0].data=this.graph_data.weekData_income;
                        this.graph.datasets[1].data=this.graph_data.weekData_outcome;
                        this.doughnut.d_labels=this.pie_data.isToday.name;
                        this.doughnut.d_dataset[0].data=this.pie_data.isToday.total;
                    }
                    else if(val=='w')
                    {
                        this.income_value=this.income.week;
                        this.outcome_value=this.outcome.week;
                        this.period_label="Ésta semana";
                        this.graph.rowlabels=this.WeekLabels;
                        this.graph.datasets[0].data=this.graph_data.weekData_income;
                        this.graph.datasets[1].data=this.graph_data.weekData_outcome;
                        this.doughnut.d_labels=this.pie_data.isWeek.name;
                        this.doughnut.d_dataset[0].data=this.pie_data.isWeek.total;
                    }
                    else if(val=='m')
                    {
                        this.income_value=this.income.month;
                        this.outcome_value=this.outcome.month;
                        this.period_label="Éste mes";
                        this.graph.rowlabels=this.graph_data.labels_current_month;
                        this.graph.datasets[0].data=this.graph_data.data_by_day_current_month_in;
                        this.graph.datasets[1].data=this.graph_data.data_by_day_current_month_out;
                        this.doughnut.d_labels=this.pie_data.isMonth.name;
                        this.doughnut.d_dataset[0].data=this.pie_data.isMonth.total;
                    }
                    else if(val=='y')
                    {
                        this.income_value=this.income.year;
                        this.outcome_value=this.outcome.year;
                        this.period_label="Último año";
                        this.graph.rowlabels=this.YearLabels;
                        this.graph.datasets[0].data=this.graph_data.DataBymont_peryear_in;
                        this.graph.datasets[1].data=this.graph_data.DataBymont_peryear_out;
                        this.doughnut.d_labels=this.pie_data.isYear.name;
                        this.doughnut.d_dataset[0].data=this.pie_data.isYear.total;
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




