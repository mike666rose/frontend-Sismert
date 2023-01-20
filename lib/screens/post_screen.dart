import 'package:blogapp/constant.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/services/post_service.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'post_form.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<dynamic> _postList = [];
  int userId = 0;
  bool _loading = true;

  // get all posts
  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getPosts();

    if(response.error == null){
      setState(() {
        _postList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    }
    else if (response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }


  void _handleDeletePost(int postId) async {
    ApiResponse response = await deletePost(postId);
    if (response.error == null){
      retrievePosts();
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
      });
    } 
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }


  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? Center(child:CircularProgressIndicator()) :
    RefreshIndicator(
      onRefresh: () {
        return retrievePosts();
      },
      child: ListView.builder(
        itemCount: _postList.length,
        itemBuilder: (BuildContext context, int index){
          Post post = _postList[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              image: post.imagen1 != null ?
                                DecorationImage(image: NetworkImage('${post.imagen1}')) : null,
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.amber
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            '${post.supervisor_responsable}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17
                            ),
                          )
                        ],
                      ),
                    ),                    PopupMenuButton(
                      child: Padding(
                        padding: EdgeInsets.only(right:10),
                        child: Icon(Icons.more_vert, color: Colors.black,)
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Edit'),
                          value: 'edit'
                        ),
                        PopupMenuItem(
                          child: Text('Delete'),
                          value: 'delete'
                        )
                      ],
                      onSelected: (val){
                        if(val == 'edit'){
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostForm(
                             title: 'Edit Post',
                             post: post,
                           )));
                        } else {
                        }
                      },
                    )
                  ],
                ),
                SizedBox(height: 12,),
               Text('${ post.numero }'),
                Text('${ post.numero_tarjeta }'),
                Text('${ post.numero_placa }'),
                Text('${ post.calle_principal }'),
                Text('${ post.calle_transversal }'),
                Text('${ post.fecha }'),
                Text('${ post.hora }'),
                Text('${ post.tipo_contravencion_a }'),
                Text('${ post.tiempo_permanencia }'),
                Text('${ post.supervisor_responsable }'),
                Text('${ post.estado }'),
                Text('${ post.observacion }'),
                Text('${ post.valor_tiempo }'),
                Text('${ post.inmovilizado }'),
                Text('${ post.estado_rev }'),
                Text('${ post.latitud }'),
                Text('${ post.longitud }'),
                post.imagen1 != null ?
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${post.imagen1}'),
                      fit: BoxFit.cover
                    )
                  ),
                ) : SizedBox(height: post.imagen1 != null ? 0 : 10,),
                
              ],
            ),
          );
        }
      ),
    );
  }
}