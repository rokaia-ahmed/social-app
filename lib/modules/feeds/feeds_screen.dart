import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context, state){} ,
      builder: (context, state){
        return BuildCondition(
          condition:SocialCubit.get(context).posts.length >0 &&
          SocialCubit.get(context).userModel !=null ,
          builder:(context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin:EdgeInsets.all(8.0) ,
                  child:Stack(
                    // alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage('https://image.freepik.com/free-vector/hand-holding-mobile-smart-phone-with-shopp-app-online-shopping-concept_3482-5683.jpg'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('communicate with friends',
                          style:Theme.of(context).textTheme.subtitle1,

                        ),
                      ),
                    ],
                  ) ,
                ),
                ListView.separated(
                  shrinkWrap:  true,
                  physics:NeverScrollableScrollPhysics() ,
                  itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder:(context,index) =>SizedBox(height: 8.0),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ) ,
          fallback:(context) => Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
  Widget buildPostItem(PostModel model, context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(
        horizontal: 8.0
    ),
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage:NetworkImage(
                    '${model.image}'
                ) ,
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${model.name}',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                        Icon(Icons.check_circle,
                          color: Colors.blue,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              IconButton(onPressed: (){},
                icon:Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color:Colors.grey[300] ,
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          if(model.postImage !='')
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15.0,
            ),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: NetworkImage(
                      '${model.postImage}'),
                  fit: BoxFit.cover,
                ),
              ) ,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size:16.0 ,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('${SocialCubit.get(context).likes[index]}',
                            style:Theme.of(context).textTheme.caption ,
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size:16.0 ,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('0 comment',
                            style:Theme.of(context).textTheme.caption ,
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color:Colors.grey[300] ,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage:NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'
                        ) ,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                        ),
                      ),
                    ],
                  ),
                  onTap: (){} ,
                ),
              ),
              InkWell(
                onTap: (){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                },
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size:16.0 ,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text('like',
                      style:Theme.of(context).textTheme.caption ,
                    ),
                  ],
                ),

              )

            ],
          ),
        ],
      ),
    ),
  );
}
