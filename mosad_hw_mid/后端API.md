# 后端API

## User

### GET: /user/info/{userId:string} 

获取用户信息

```json
{
 "ID": "5b3510fe7a2bdd4aac29eb73",
 "State": "success",
 "Email": "a@zhenly.cn",
 "Name": "Test用户",
 "Class": 1,
 "Info": {
  "Name": "Test用户",
  "Avatar": "https://violet-1252808268.cos.ap-guangzhou.myqcloud.com/5b1fe672f2e85b26522ac546.jpg",
  "Bio": "我MJJ啊",
  "Gender": 0,
  "NikeName": ""
 },
 "MaxSize": 0,
 "UsedSize": 0,
 "SingleSize": 0
}
```

### POST: /user/register

用户注册

### POST: /user/name

修改用户名字

### POST: /user/logout

退出登陆

### POST: /user/login

用户密码登陆

### POST: /user/info

更新用户信息

## Content

### GET: /content/file/{id:string}/{path:string}

根据内容`id`和文件`path`获取内容文件

返回值：二进制文件

### GET: /content/detail/{id:string}

根据ID获取内容详情

返回值：

```json
{
 "State": "success",
 "Data": {
  "ID": "5c3774187a2bdd000111e10c",
  "Name": "测试",
  "Detail": "好土啊",
  "OwnID": "5b3510fe7a2bdd4aac29eb73",
  "PublishDate": 1547138072000,
  "EditDate": 1547138072000,
  "LikeNum": 1,
  "CommentNum": 0,
  "Public": true,
  "Native": false,
  "Type": "Album",
  "SubType": "",
  "Remarks": "",
  "Tag": [],
  "Image": [],
  "Files": [],
  "Movie": {
   "File": {
    "File": "",
    "Size": 0,
    "Title": "",
    "Time": 0,
    "Count": 0,
    "Type": ""
   },
   "URL": "",
   "Image": [],
   "Type": "",
   "Detail": "",
   "Watched": false
  },
  "Album": {
   "Images": [
    {
     "Native": true,
     "File": {
      "File": "./UserData/5b3510fe7a2bdd4aac29eb73/Album/154713807215556-file2-file2",
      "Size": 63105,
      "Title": "file2",
      "Time": 1547138072000,
      "Count": 0,
      "Type": "Album"
     },
     "URL": "",
     "Thumb": "154713807215556.png"
    },
    {
     "Native": true,
     "File": {
      "File": "./UserData/5b3510fe7a2bdd4aac29eb73/Album/154713807218894-file0-file0",
      "Size": 286379,
      "Title": "file0",
      "Time": 1547138072000,
      "Count": 0,
      "Type": "Album"
     },
     "URL": "",
     "Thumb": "154713807218894.png"
    },
    {
     "Native": true,
     "File": {
      "File": "./UserData/5b3510fe7a2bdd4aac29eb73/Album/154713807287088-file1-file1",
      "Size": 72402,
      "Title": "file1",
      "Time": 1547138072000,
      "Count": 0,
      "Type": "Album"
     },
     "URL": "",
     "Thumb": "154713807287088.png"
    }
   ],
   "Title": "测试",
   "Time": 1547138072000,
   "Location": ""
  },
  "App": {
   "File": {
    "File": "",
    "Size": 0,
    "Title": "",
    "Time": 0,
    "Count": 0,
    "Type": ""
   },
   "Web": "",
   "URL": "",
   "Image": [],
   "Version": ""
  }
 },
 "User": {
  "Name": "Test用户",
  "Avatar": "https://violet-1252808268.cos.ap-guangzhou.myqcloud.com/5b1fe672f2e85b26522ac546.jpg",
  "Gender": 0
 }
}

```



### GET: /content/texts/{userID:string}

获取用户的文本数据

```json
{
 "State": "success",
 "Data": [
  {
   "ID": "5b35115a7a2bdd4aac29eb74",
   "Name": "我是一个测试账户",
   "Detail": "由于这个DEMO所在服务器只有1M小水管，所以尽量避免大文件上传，Coffee系统本身是为局域网设备设计的",
   "OwnID": "5b3510fe7a2bdd4aac29eb73",
   "PublishDate": 1530204506000,
   "EditDate": 1530204506000,
   "LikeNum": 2,
   "CommentNum": 1,
   "Public": true,
   "Native": false,
   "Type": "Text",
   "SubType": "",
   "Remarks": "",
   "Tag": [
    "说明"
   ],
   "Image": [],
   "Files": [],
   "Movie": {
    "File": {
     "File": "",
     "Size": 0,
     "Title": "",
     "Time": 0,
     "Count": 0,
     "Type": ""
    },
    "URL": "",
    "Image": [],
    "Type": "",
    "Detail": "",
    "Watched": false
   },
   "Album": {
    "Images": [],
    "Title": "",
    "Time": 0,
    "Location": ""
   },
   "App": {
    "File": {
     "File": "",
     "Size": 0,
     "Title": "",
     "Time": 0,
     "Count": 0,
     "Type": ""
    },
    "Web": "",
    "URL": "",
    "Image": [],
    "Version": ""
   }
  }
 ]
}

```



### GET: /content/album/{userId:string}

获取用户的相册信息

```json
{
 "State": "success",
 "Data": [
  {
   "ID": "5c3774187a2bdd000111e10c",
   "Name": "测试",
   "Detail": "好土啊",
   "OwnID": "5b3510fe7a2bdd4aac29eb73",
   "PublishDate": 1547138072000,
   "EditDate": 1547138072000,
   "LikeNum": 1,
   "CommentNum": 0,
   "Public": true,
   "Native": false,
   "Type": "Album",
   "SubType": "",
   "Remarks": "",
   "Tag": [],
   "Image": [],
   "Files": [],
   "Movie": {
    "File": {
     "File": "",
     "Size": 0,
     "Title": "",
     "Time": 0,
     "Count": 0,
     "Type": ""
    },
    "URL": "",
    "Image": [],
    "Type": "",
    "Detail": "",
    "Watched": false
   },
   "Album": {
    "Images": [
     {
      "Native": true,
      "File": {
       "File": "./UserData/5b3510fe7a2bdd4aac29eb73/Album/154713807215556-file2-file2",
       "Size": 63105,
       "Title": "file2",
       "Time": 1547138072000,
       "Count": 0,
       "Type": "Album"
      },
      "URL": "",
      "Thumb": "154713807215556.png"
     },
     {
      "Native": true,
      "File": {
       "File": "./UserData/5b3510fe7a2bdd4aac29eb73/Album/154713807218894-file0-file0",
       "Size": 286379,
       "Title": "file0",
       "Time": 1547138072000,
       "Count": 0,
       "Type": "Album"
      },
      "URL": "",
      "Thumb": "154713807218894.png"
     },
     {
      "Native": true,
      "File": {
       "File": "./UserData/5b3510fe7a2bdd4aac29eb73/Album/154713807287088-file1-file1",
       "Size": 72402,
       "Title": "file1",
       "Time": 1547138072000,
       "Count": 0,
       "Type": "Album"
      },
      "URL": "",
      "Thumb": "154713807287088.png"
     }
    ],
    "Title": "测试",
    "Time": 1547138072000,
    "Location": ""
   },
   "App": {
    "File": {
     "File": "",
     "Size": 0,
     "Title": "",
     "Time": 0,
     "Count": 0,
     "Type": ""
    },
    "Web": "",
    "URL": "",
    "Image": [],
    "Version": ""
   }
  },
  {
   "ID": "5c2dd5d97a2bdd000111e0f7",
   "Name": "图片",
   "Detail": "我，秀秀，打钱",
   "OwnID": "5b3510fe7a2bdd4aac29eb73",
   "PublishDate": 1546507737000,
   "EditDate": 1546507737000,
   "LikeNum": 1,
   "CommentNum": 1,
   "Public": true,
   "Native": false,
   "Type": "Album",
   "SubType": "",
   "Remarks": "",
   "Tag": [
    "10000"
   ],
   "Image": [],
   "Files": [],
   "Movie": {
    "File": {
     "File": "",
     "Size": 0,
     "Title": "",
     "Time": 0,
     "Count": 0,
     "Type": ""
    },
    "URL": "",
    "Image": [],
    "Type": "",
    "Detail": "",
    "Watched": false
   },
   "Album": {
    "Images": [
     {
      "Native": true,
      "File": {
       "File": "./UserData/5b3510fe7a2bdd4aac29eb73/Album/154650773735860-file0-file0",
       "Size": 46114,
       "Title": "file0",
       "Time": 1546507737000,
       "Count": 0,
       "Type": "Album"
      },
      "URL": "",
      "Thumb": "154650773735860.png"
     }
    ],
    "Title": "图片",
    "Time": 1546507737000,
    "Location": ""
   },
   "App": {
    "File": {
     "File": "",
     "Size": 0,
     "Title": "",
     "Time": 0,
     "Count": 0,
     "Type": ""
    },
    "Web": "",
    "URL": "",
    "Image": [],
    "Version": ""
   }
  }
 ]
}

```



### GET: /comment/{contentID:string} 

获取指定内容的评论

```json
{
 "State": "success",
 "Data": [
  {
   "Comment": {
    "ID": "5c37669b7a2bdd000111e108",
    "ContentID": "5c3765bd7a2bdd000111e107",
    "FatherID": "5c27816d7a2bdd0001b0070f",
    "UserID": "5c27816d7a2bdd0001b0070f",
    "Date": 1547134619000,
    "Content": "啊",
    "LikeNum": 1
   },
   "User": {
    "Name": "yuyu",
    "Avatar": "https://violet-1252808268.cos.ap-guangzhou.myqcloud.com/5b55f12a86934176a2a7058a.jpg",
    "Gender": 0
   },
   "Replies": [
    {
     "Reply": {
      "ID": "5c3766a67a2bdd000111e109",
      "ContentID": "5c37669b7a2bdd000111e108",
      "FatherID": "5c27816d7a2bdd0001b0070f",
      "UserID": "5c27816d7a2bdd0001b0070f",
      "Date": 1547134630000,
      "Content": "啊啊",
      "LikeNum": 1
     },
     "User": {
      "Name": "yuyu",
      "Avatar": "https://violet-1252808268.cos.ap-guangzhou.myqcloud.com/5b55f12a86934176a2a7058a.jpg",
      "Gender": 0
     },
     "Father": {
      "Name": "yuyu",
      "Avatar": "https://violet-1252808268.cos.ap-guangzhou.myqcloud.com/5b55f12a86934176a2a7058a.jpg",
      "Gender": 0
     }
    },
    {
     "Reply": {
      "ID": "5c3770ab7a2bdd000111e10a",
      "ContentID": "5c37669b7a2bdd000111e108",
      "FatherID": "5c27816d7a2bdd0001b0070f",
      "UserID": "5b3510fe7a2bdd4aac29eb73",
      "Date": 1547137195000,
      "Content": "咯咯",
      "LikeNum": 0
     },
     "User": {
      "Name": "Test用户",
      "Avatar": "https://violet-1252808268.cos.ap-guangzhou.myqcloud.com/5b1fe672f2e85b26522ac546.jpg",
      "Gender": 0
     },
     "Father": {
      "Name": "yuyu",
      "Avatar": "https://violet-1252808268.cos.ap-guangzhou.myqcloud.com/5b55f12a86934176a2a7058a.jpg",
      "Gender": 0
     }
    }
   ]
  }
 ]
}

```





### GET: /content/public

获取公共内容

参数：

- page: 页面
- eachPage: 每页数量

```json
{
 "State": "success",
 "Data": [
  {
   "Data": {
    "ID": "5c3774187a2bdd000111e10c",
    "Name": "测试",
    "Detail": "好土啊",
    "OwnID": "5b3510fe7a2bdd4aac29eb73",
    "PublishDate": 1547138072000,
    "EditDate": 1547138072000,
    "LikeNum": 1,
    "CommentNum": 0,
    "Public": true,
    "Native": false,
    "Type": "Album",
    "SubType": "",
    "Remarks": "",
    "Tag": [],
    "Image": [],
    "Files": [],
    "Movie": {
     "File": {
      "File": "",
      "Size": 0,
      "Title": "",
      "Time": 0,
      "Count": 0,
      "Type": ""
     },
     "URL": "",
     "Image": [],
     "Type": "",
     "Detail": "",
     "Watched": false
    },
    "Album": {
     "Images": [
      {
       "Native": true,
       "File": {
        "File": "./UserData/5b3510fe7a2bdd4aac29eb73/Album/154713807215556-file2-file2",
        "Size": 63105,
        "Title": "file2",
        "Time": 1547138072000,
        "Count": 0,
        "Type": "Album"
       },
       "URL": "",
       "Thumb": "154713807215556.png"
      },
      {
       "Native": true,
       "File": {
        "File": "./UserData/5b3510fe7a2bdd4aac29eb73/Album/154713807218894-file0-file0",
        "Size": 286379,
        "Title": "file0",
        "Time": 1547138072000,
        "Count": 0,
        "Type": "Album"
       },
       "URL": "",
       "Thumb": "154713807218894.png"
      },
      {
       "Native": true,
       "File": {
        "File": "./UserData/5b3510fe7a2bdd4aac29eb73/Album/154713807287088-file1-file1",
        "Size": 72402,
        "Title": "file1",
        "Time": 1547138072000,
        "Count": 0,
        "Type": "Album"
       },
       "URL": "",
       "Thumb": "154713807287088.png"
      }
     ],
     "Title": "测试",
     "Time": 1547138072000,
     "Location": ""
    },
    "App": {
     "File": {
      "File": "",
      "Size": 0,
      "Title": "",
      "Time": 0,
      "Count": 0,
      "Type": ""
     },
     "Web": "",
     "URL": "",
     "Image": [],
     "Version": ""
    }
   },
   "User": {
    "Name": "Test用户",
    "Avatar": "https://violet-1252808268.cos.ap-guangzhou.myqcloud.com/5b1fe672f2e85b26522ac546.jpg",
    "Gender": 0
   }
  },
  {
   "Data": {
    "ID": "5c3765bd7a2bdd000111e107",
    "Name": "很小的图",
    "Detail": "",
    "OwnID": "5c27816d7a2bdd0001b0070f",
    "PublishDate": 1547134397000,
    "EditDate": 1547134397000,
    "LikeNum": 1,
    "CommentNum": 1,
    "Public": true,
    "Native": false,
    "Type": "Album",
    "SubType": "",
    "Remarks": "",
    "Tag": [
     "哈哈"
    ],
    "Image": [],
    "Files": [],
    "Movie": {
     "File": {
      "File": "",
      "Size": 0,
      "Title": "",
      "Time": 0,
      "Count": 0,
      "Type": ""
     },
     "URL": "",
     "Image": [],
     "Type": "",
     "Detail": "",
     "Watched": false
    },
    "Album": {
     "Images": [
      {
       "Native": true,
       "File": {
        "File": "./UserData/5c27816d7a2bdd0001b0070f/Album/154713439756448-file1-file1",
        "Size": 304,
        "Title": "file1",
        "Time": 1547134397000,
        "Count": 0,
        "Type": "Album"
       },
       "URL": "",
       "Thumb": "154713439756448.png"
      },
      {
       "Native": true,
       "File": {
        "File": "./UserData/5c27816d7a2bdd0001b0070f/Album/154713439761782-file0-file0",
        "Size": 175,
        "Title": "file0",
        "Time": 1547134397000,
        "Count"
       }
      ]
   }
 ]
}

```

### DELETE: /content/{param1:string}

删除指定内容

### PATCH: /content/all/{id:string}

修改内容

### OST: /content/album

增加相册内容

### POST: /content/text

增加文本内容

### POST: /user/email

发送验证码到用户邮箱

### DELETE: /comment/{id:string}

删除某评论

###  GET: /user/login

用户登陆

### POST: /comment

添加评论

###  PATCH: /like/{contentId:string}

对某内容取消点赞

###  POST: /like/{contentId:string}

对某内容点赞

###  DELETE: /notification/{notificationID:string}

删除指定通知

###   GET: /notification/all

获取当前用户的所有通知

### GET: /notification/unread

获取当前用户的未读通知

### PATCH: /notification/read/{notificaitonID:string}

将通知标记为已读/未读

### GET: /like

获取当前用户点赞信息