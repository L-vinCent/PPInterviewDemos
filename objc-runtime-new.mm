```bash
static void methodizeClass(Class cls)
{
    runtimeLock.assertWriting();
    
    bool isMeta = cls->isMetaClass();
    auto rw = cls->data();
    auto ro = rw->ro;
    
    // Methodizing for the first time
    if (PrintConnecting) {
        _objc_inform("CLASS: methodizing class '%s' %s",
                     cls->nameForLogging(), isMeta ? "(meta)" : "");
    }
    
    // Install methods and properties that the class implements itself.
    method_list_t *list = ro->baseMethods();
    if (list) {
        prepareMethodLists(cls, &list, 1, YES, isBundleClass(cls));
        rw->methods.attachLists(&list, 1);
    }
    
    property_list_t *proplist = ro->baseProperties;
    if (proplist) {
        rw->properties.attachLists(&proplist, 1);
    }
    
    protocol_list_t *protolist = ro->baseProtocols;
    if (protolist) {
        rw->protocols.attachLists(&protolist, 1);
    }
    
    // Root classes get bonus method implementations if they don't have
    // them already. These apply before category replacements.
    if (cls->isRootMetaclass()) {
        // root metaclass
        addMethod(cls, SEL_initialize, (IMP)&objc_noop_imp, "", NO);
    }
    
    // Attach categories.
    //获取分类列表
    category_list *cats = unattachedCategoriesForClass(cls, true /*realizing*/);
    
    //将分类
    attachCategories(cls, cats, false /*don't flush caches*/);
    
    if (PrintConnecting) {
        if (cats) {
            for (uint32_t i = 0; i < cats->count; i++) {
                _objc_inform("CLASS: attached category %c%s(%s)",
                             isMeta ? '+' : '-',
                             cls->nameForLogging(), cats->list[i].cat->name);
            }
        }
    }
    
    if (cats) free(cats);
    
#if DEBUG
    // Debug: sanity-check all SELs; log method list contents
    for (const auto& meth : rw->methods) {
        if (PrintConnecting) {
            _objc_inform("METHOD %c[%s %s]", isMeta ? '+' : '-',
                         cls->nameForLogging(), sel_getName(meth.name));
        }
        assert(ignoreSelector(meth.name)  ||
               sel_registerName(sel_getName(meth.name)) == meth.name);
    }
#endif
}
```



```bash
static void 
attachCategories(Class cls, category_list *cats, bool flush_caches)
{
    if (!cats) return;
    if (PrintReplacedMethods) printReplacements(cls, cats);

    bool isMeta = cls->isMetaClass();

    // fixme rearrange to remove these intermediate allocations
    method_list_t **mlists = (method_list_t **)
        malloc(cats->count * sizeof(*mlists));
    property_list_t **proplists = (property_list_t **)
        malloc(cats->count * sizeof(*proplists));
    protocol_list_t **protolists = (protocol_list_t **)
        malloc(cats->count * sizeof(*protolists));

    // Count backwards through cats to get newest categories first
    int mcount = 0;
    int propcount = 0;
    int protocount = 0;
    int i = cats->count; //宿主类分类的总数
    bool fromBundle = NO;
    while (i--) { //这里是倒序遍历，最先访问最后编译的分类 ,所以 最后编译的最终生效
        auto& entry = cats->list[i];
	
		//获取分类的方法列表
        method_list_t *mlist = entry.cat->methodsForMeta(isMeta);
        if (mlist) {
        //最后编译的分类最先添加到分类数组中
            mlists[mcount++] = mlist;
            fromBundle |= entry.hi->isBundle();
        }
	
	//属性列表添加规则, 同方法列表添加规则
        property_list_t *proplist = entry.cat->propertiesForMeta(isMeta);
        if (proplist) {
            proplists[propcount++] = proplist;
        }
		//协议列表添加规则 ，
        protocol_list_t *protolist = entry.cat->protocols;
        if (protolist) {
            protolists[protocount++] = protolist;
        }
    }
	//获取宿主类当中的rw数据，其中包含宿主类的方法列表信息
    auto rw = cls->data();

// 主要是针对 分类中有关于内存管理相关方法情况下的一些特殊处理
    prepareMethodLists(cls, mlists, mcount, NO, fromBundle);
    rw->methods.attachLists(mlists, mcount);
    free(mlists);
    if (flush_caches  &&  mcount > 0) flushCaches(cls);
	/*  
	rw 代表类
	methhod 代表类的方法列表
	attachLists 方法的含义是 将含有mcount个元素的mlists拼接到rw的methods上 
	*/

    rw->properties.attachLists(proplists, propcount);
    free(proplists);

    rw->protocols.attachLists(protolists, protocount);
    free(protolists);
}
```


```bash

//addedLists 传递过来的二维数组

[[method_t,method_t,...][method_t,][method_t,......]] 假设这个是 addedLists 的数组， addedCount = 3;

 void attachLists(List* const * addedLists, uint32_t addedCount) {
        if (addedCount == 0) return;

        if (hasArray()) {
        //列表中原有元素总数  oldCount = 2
            // many lists -> many lists
            uint32_t oldCount = array()->count;
            
            //拼接之后的元素总和
            uint32_t newCount = oldCount + addedCount;
            //根据新总数重新分配内存
            setArray((array_t *)realloc(array(), array_t::byteSize(newCount)));
            //重新设置元素总和
            array()->count = newCount;
            memmove(array()->lists + addedCount, array()->lists, 
                    oldCount * sizeof(array()->lists[0]));
                    /*
                    内存拷贝
                    [
                    	A --> [addedList中的第一个元素]
                    	B --> [addedList中的第二个元素]
                    	C --> [addedList中的第三个元素]
                    	[原有的第一个元素]
                    	[原有的第二个元素]
                    
                    ]
                    这就是分类方法 会覆盖 宿主类的方法的原因
                    */
            memcpy(array()->lists, addedLists, 
                   addedCount * sizeof(array()->lists[0]));
        }
        else if (!list  &&  addedCount == 1) {
            // 0 lists -> 1 list
            list = addedLists[0];
        } 
        else {
            // 1 list -> many lists
            List* oldList = list;
            uint32_t oldCount = oldList ? 1 : 0;
            uint32_t newCount = oldCount + addedCount;
            setArray((array_t *)malloc(array_t::byteSize(newCount)));
            array()->count = newCount;
            if (oldList) array()->lists[addedCount] = oldList;
            memcpy(array()->lists, addedLists, 
                   addedCount * sizeof(array()->lists[0]));
        }
    }
```