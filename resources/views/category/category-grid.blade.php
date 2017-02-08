

      
    {!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!} 
    {!!Html::style('/themes/krece/css/plugins/jqgrid/ui.jqGrid.css')!!}  
    {!!Html::script('/themes/krece/js/plugins/jqgrid/jquery.jqGrid52.min.js')!!}  
    {!!Html::script('/themes/krece/js/plugins/jquery-layout/jquery.layout.js')!!}
    {!!Html::script('/themes/krece/js/plugins/jqgrid/i18n/grid.locale-es.js')!!}  

    {!!Html::style('/themes/krece/css/plugins/jqueryui/jquery-ui.css')!!}


        <div class="jqGrid_wrapper"> 
           <div class="ibox-content">     
                <table id="category-grid"></table>       
            </div>  
    <div>

    
    <script>

       jQuery(document).ready(function($) {  
            jQuery('#category-grid').jqGrid({
                url: "/getCategoryAll",
                datatype: "json",                 
                colModel:[                   
                    {name:'name', label:'Nombre', "width":70,index:'name'},
                    {name:'description', label:'Descripción',"width":170, index:'description'},
                    {name:'niif_account', label:'# Cuenta',"width":60, index:'niif_account'},
                    {name:'id',key:true,"width":30, label:'Acciones', index:'id',  "align":"right", 
                        formatter: displayButtons},
                    {name:"parent_id",hidden:true},
                    {name:"lft",hidden:true},
                    {name:"rgt",hidden:true},
                    {name:"depth",hidden:true},
                    {name:"id",hidden:true},
                    {name:"isEditable",hidden:true}
				],
				"width":"780",
				"viewrecords":false,
				"gridview":true,
				"height":"auto",
				"sortname":"lft",
				"loadonce":false,
				"rowNum":100,
				"scrollrows":true,
				"treeGrid":true,
                caption:"",
				"ExpandColumn":"name",
				"treedatatype":"json",
				"treeGridModel":"nested",
                "ExpandColClick" : true,
			    "treeReader":{
					"left_field":"lft",
					"right_field":"rgt",
					"level_field":"depth"
				},
				"sortorder":"asc",
                loadComplete: function () {                  
                    resizewidth();
                    if (categoryApp.form.category_id)
                    {
                        jQuery('#category-grid').jqGrid('setSelection',categoryApp.form.category_id);
                    }
                },
                "onSelectRow" : function( rowid ) {
					if(rowid) 
					{
						var rdata = $('#category-grid').jqGrid('getRowData', rowid);
                        app.setCategoryId(rdata.id);
					} 
				}     
            });            

             function displayButtons(cellvalue, options, rowObject) {
            
                
                var edit = '<div  title= "editar"  class="fa fa-pencil" style="cursor: pointer; color:green" onClick="categoryApp.updateNode(\''+rowObject.description+'\',\''+rowObject.name+'\',\''+rowObject.id+'\',\''+rowObject.niif_account+'\')"></div><span > </span>',
                    Details = "<div title= 'ver' class='fa fa-eye' style='cursor: pointer; color:blue'  onClick=categoryApp.updateNode(\""+options+"\")></div><span > </span>",
                    Delete = "<div title= 'eliminar' class='fa fa-remove'  style='cursor: pointer; color:red' onclick=categoryApp.remove(\""+cellvalue+"\")/></div><span > </span>";
                    Add = "<div title= 'Crear sub-categoria' class='fa fa-plus'  style='cursor: pointer; color:green' onclick=categoryApp.addNewNode(\""+cellvalue+"\")/></div><span > </span>";
                
                if (rowObject.isEditable==0)
                {
                    Delete = "<div title= 'Eliminar' class='fa fa-remove '  style='color:#F3D8D5'/></div><span > </span>";
                    edit = "<div  title= 'Editar'  class='fa fa-pencil ' style='color:#ABEBC6'/></div><span > </span>";                   
                }

                return Add + edit + Details + Delete;
            }   
            myfunc=function (desc,name,id,account)
            {
                console.log(desc);
                console.log(name);
                console.log(id);
                console.log(account);
            };

             $(window).bind('resize', function () {
               resizewidth();
            });

            function resizewidth()
            {
                var width = $('.jqGrid_wrapper').width();
                $('#category-grid').setGridWidth(width); 
            }  
        });


    </script>
