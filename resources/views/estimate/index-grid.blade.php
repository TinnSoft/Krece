
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqGrid/ui.jqgrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
       {!!Html::script('/js/vue-library/vue.min.js')!!}
    {!!Html::style('/themes/krece/css/plugins/jQueryUI/jquery-ui.css')!!}
    <script>
        moment.locale('es');  
    </script>
    

 <style>
          .green {color: green;}
        .red {color: red;}

    </style>

        <div id="estimate_index" class="jqGrid_wrapper">            
           <!-- activar buscador 
            <div class="ibox-content">
                <ul class="todo-list m-t small-list  col-sm-5 pull-right">
                    <li>
                        <div  class="input-group"><input id="search_cells" type="text" placeholder="Buscar" class="input-sm form-control"> <span class="input-group-btn">
                        <button type="button" class="btn btn-sm btn-primary"><span class="fa fa-search"></span></button> </span></div>
                    </li>
                </ul>                      
            </div>-->
        
                <table id="estimate-grid"></table>
                <div id="pager_list_2"></div>     
                   
        <div>

    <script>
        
        $(document).ready(function () {       
             var emptyMsgDiv = $("<div class='ibox-content ibox-heading'>" +
            "<h3><i class='fa fa-exclamation'></i> No tienes cotizaciones creadas!</h3>" +
            " <div class='ibox-content ibox-heading'><a href='{{route('estimate.create')}}' class='btn btn-primary btn-outline btn-sm '>" +
            "<span class='fa fa-plus '></span>&nbsp;Crear Cotización</a> </div></div> '");
         
            $("#estimate-grid").jqGrid({
                url: "getEstimateList",
                editurl: 'estimate',
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'No', name: 'public_id', index: 'public_id', align:'center', width: 35, sorttype: "int",formatter:formatpublicID },
                    { label: 'Cliente', name: 'contact.name',  width: 150, sorttype: "text" },
                    { label: 'Creación', name: 'created_at.date', width: 70, formatter:diffForHumans},
                    { label: 'Total', name: 'total', width: 70, formatter:'currency', formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "} },
                     {name:'public_id', search:false, keys: true,"width":100, label:'Acciones', index:'public_id',  "align":"right" , sortable: false, formatter: displayButtons }                  
                ],
                autoresizeOnLoad: true,
                viewrecords: true, // show the current page, data rang and total records on the toolbar
                autowidth: true,
                shrinkToFit: true,
                autoResizing: {
                    compact: true
                    },
                 cmTemplate: {
                    autoResizable: true,
                    editable: true
                    },             
                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:" ",
                loadonce:true,
                navOptions: { reloadGridOptions: { fromServer: true } },
                loadComplete: function () {
                    var count = $("#estimate-grid").getGridParam();
                    var ts = $("#estimate-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#estimate-grid").hide();
                        emptyMsgDiv.insertAfter($("#estimate-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#estimate-grid").show();
                        emptyMsgDiv.hide();
                    };
                    //resizewidth();
                },       
                 beforeRequest:function()
                {
                 //   resizewidth();
                },        
                pager:"#pager_list_2"
            });
            
      
          $("#export").on("click", function(){
				$("#estimate-grid").jqGrid("exportToExcel",{
					includeLabels : true,
					includeGroupHeader : true,
					includeFooter: true,
					fileName : "jqGridExport.xlsx",
					maxlength : 40 
				})
			})

      
          

             jQuery('#estimate-grid').jqGrid('navGrid','#pager_list_2',
                {
                    "edit":false,
                    "add":false,
                    "del":false,
                    "search":true,
                    "refresh":false,
                    "view":false,
                    "excel":false,
                    "pdf":false,
                    "csv":false,
                    "columns":false
                },
                {"drag":true,"resize":true,"closeOnEscape":true,"dataheight":150},
                {"drag":true,"resize":true,"closeOnEscape":true,"dataheight":150}
                );
                                
              setTimeout(function(){
                $('.wrapper-content').removeClass('animated fadeInRight');
            },700);

             function displayButtons(cellvalue, options, rowObject) {
                var edit = "<div  title= 'editar'  class='fa fa-eye green fa-2x' style='cursor: pointer' onClick=estimateApp.goShow(\""+cellvalue+"\") ></div><span > </span>",
                    Details = "<div title= 'ver' class='fa fa-pencil green fa-2x' style='cursor: pointer'  onClick=estimateApp.goEdit(\""+cellvalue+"\")></div><span > </span>",
                    Print = "<div title= 'Imprimir' class='fa fa-print fa-2x' style='cursor: pointer'  onClick=estimateApp.printPdf(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove red fa-2x'  style='cursor: pointer' onclick=estimateApp.remove(\""+cellvalue+"\")/></div><span > </span>";
                
                return Details + Print + edit+ Delete;
            }   

            function formatpublicID(cellValue, options, rowObject) {
                    var goTo = "<p><a class='text-info' style='cursor: pointer; color:green;text-decoration: underline' onClick=estimateApp.goShow(\""+cellValue+"\") >"+rowObject.resolution_id+"</a></p>";
                    return goTo;
            }
             function diffForHumans(cellValue, options, rowObject) {
                    return estimateApp.moment(cellValue);
            }

             $(window).bind('resize', function () {
               resizewidth();

            });
                //resize on load
            function resizewidth()
            {
                var width = $('.jqGrid_wrapper').width();
                $('#estimate-grid').setGridWidth(width); 
            }  

            	// activate the toolbar searching
			$('#estimate-grid').jqGrid('navGrid',"#pager_list_2", {                
                search: false, // show search button on the toolbar
                add: false,
                edit: false,
                del: false,
                refresh: true
            });
			var timer;
			$("#search_cells").on("keyup", function() {
				var self = this;
				if(timer) { clearTimeout(timer); }
				timer = setTimeout(function(){
					$("#estimate-grid").jqGrid('filterInput', self.value);
				},0);
			});

        });


    </script>

