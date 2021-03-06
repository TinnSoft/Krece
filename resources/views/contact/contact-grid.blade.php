
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqGrid/ui.jqgrid.css')!!}  
     {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
     {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
      {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  
    {!!Html::style('/themes/krece/css/plugins/jQueryUI/jquery-ui.css')!!}

 <style>
          .green {color: green;}
        .red {color: red;}

    </style>

        <div id="contact2" class="jqGrid_wrapper">               
                    <div class="ibox-title">    
                    <div data-toggle="buttons" class="btn-group">
                        <label class="btn btn-sm btn-outline btn-primary active" id="refresh_all" > <input  type="radio" id="option1" name="options">Todos</label>
                        <label class="btn btn-sm btn-outline btn-primary " id="refresh_client"> <input  type="radio"  id="option2" name="options">Clientes</label>
                        <label class="btn btn-sm btn-outline btn-primary" id="refresh_providers"> <input type="radio"  id="option3" name="options">Proveedores</label>
                    </div>
                    </div> 
                <table id="contact-grid"></table>
                <div id="pager_list_2"></div>     
                 
    <div>

    <script>
        
        $(document).ready(function () {       
            var emptyMsgDiv = $("<div class='alert alert-info' role='alert'><span class='glyphicon glyphicon-exclamation-sign'" +
            "aria-hidden='true'></span><span class='sr-only'>Error:</span> Aún no tienes contactos creados." +
            " Por que no empiezas <a href='{{route('contact.create')}}'><strong>creando uno?</a> </strong></div> '");
          
            $("#contact-grid").jqGrid({
                url: "getContactlist/all",
                editurl: 'contact',
                datatype: "json",
                mtype: 'GET',
                emptyrecords:  "",
                colModel: [                   
                    { label: 'Nombre', name: 'name', index: 'name', width: 75, sorttype: "text" },
                    { label: 'Nit', name: 'nit', width: 90 },
                    { label: 'Teléfono', name: 'phone1', width: 90 },
                    { label: 'Observaciones', name: 'observation', width: 90 },
                     {name:'public_id',  keys: true,"width":70, label:'Acciones', index:'public_id',  "align":"right" , sortable: false, formatter: displayButtons }                  
                ],
                viewrecords: true, // show the current page, data rang and total records on the toolbar
                autowidth: true,
                shrinkToFit: true,

                height: 'auto',
                rowNum: 10,
                rowList: [10, 20, 50, 100],
                caption:"Contactos (todos)",
                loadonce:true,
                navOptions: { reloadGridOptions: { fromServer: true } },
                loadComplete: function () {
                    var count = $("#contact-grid").getGridParam();
                    var ts = $("#contact-grid")[0];
                    if (ts.p.reccount === 0) {
                        $("#contact-grid").hide();
                        emptyMsgDiv.insertAfter($("#contact-grid").parent());
                        emptyMsgDiv.show();
                    } else {
                        $("#contact-grid").show();
                        emptyMsgDiv.hide();
                    };
                   // resizewidth();
                },  
                 beforeRequest:function()
                {
                    resizewidth();
                },         
                pager:"#pager_list_2"
            });

          $("#export").on("click", function(){
				$("#contact-grid").jqGrid("exportToExcel",{
					includeLabels : true,
					includeGroupHeader : true,
					includeFooter: true,
					fileName : "jqGridExport.xlsx",
					maxlength : 40 
				})
			})

             $("#refresh_all").on("click", function(){             
                 refreshgrid('a','Contactos (todos)');
			})

            $("#refresh_client").on("click", function(){              
                refreshgrid('c','Contactos (Clientes)');
			})

            $("#refresh_providers").on("click", function(){             
                 refreshgrid('p','Contactos (Proveedores)');
			})

            function refreshgrid(filter, caption)
            {
                 $("#contact-grid").setGridParam({url:"getContactlist/"+filter});
                $('#contact-grid').jqGrid('setCaption', caption);
                 $('#contact-grid').setGridParam({datatype:'json', page:1}).trigger('reloadGrid');
            }

             jQuery('#contact-grid').jqGrid('navGrid','#pager_list_2',
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
                var Details = "<div  title= 'Ver'  class='fa fa-eye green fa-2x' style='cursor: pointer' onClick=app2.goShow(\""+cellvalue+"\") ></div><span > </span>",
                    edit = "<div title= 'Editar' class='fa fa-pencil green fa-2x' style='cursor: pointer'  onClick=app2.goEdit(\""+cellvalue+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove red fa-2x'  style='cursor: pointer' onclick=app2.remove(\""+cellvalue+"\")/></div><span > </span>";
                
                return edit + Details + Delete;
            }   

             $(window).bind('resize', function () {
               resizewidth();
            });
                //resize on load
            function resizewidth()
            {
                var width = $('.jqGrid_wrapper').width();
                $('#contact-grid').setGridWidth(width); 
            }  

            	// activate the toolbar searching
			$('#contact-grid').jqGrid('navGrid',"#pager_list_2", {                
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
					$("#contact-grid").jqGrid('filterInput', self.value);
				},0);
			});

        });


    </script>

