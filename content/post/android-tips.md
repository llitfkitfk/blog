---
title: "Android Tips"
date: 2015-06-24T19:02:00+08:00
lastmod: 2018-12-27T14:00:00+08:00
draft: false
tags: ["Android", "Tips"]
categories: ["Android"]
---

### 1. 统一重复组件风格

```
# styles.xml
<resources>

    <style name="FormRadioButton" parent="android:Widget.CompoundButton.RadioButton">
        <item name="android:minHeight">@dimen/buttonHeight</item>
        <item name="android:button">@null</item>
        <item name="android:background">@drawable/background_radio</item>
        <item name="android:gravity">center</item>
    </style>

</resources>


# activity_layout.xml
<...>

<RadioGroup
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal">
        <RadioButton
            style="@style/FormRadioButton"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="One"/>
        <RadioButton
            style="@style/FormRadioButton"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="Two"/>
        <RadioButton
            style="@style/FormRadioButton"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="Three"/>
</RadioGroup>

</...>
```

### 2. 系统界面元素触发

* `View.setSystemUiVisibility()`
* `View.getSystemUiVisibility()`


### 3. 自定义View

```
public class BullsEyeView extends View {
    private Paint mPaint;
    private Point mCenter;
    private float mRadius;
    
    /*
     * Java Constructor
     */
    public BullsEyeView(Context context) {
        this(context, null);
    }
    
    /*
     * XML Constructor
     */
    public BullsEyeView(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }
    
    /*
     * XML Constructor with Style
     */
    public BullsEyeView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        //在这里可以做自定义View的一些初始化配置

        //例如，创建一个可绘画的刷子
        mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);

        //设置刷子的风格
        mPaint.setStyle(Style.FILL);

        //创建绘画的中心点
        mCenter = new Point();
    }
    
    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int width, height;

        //设置大小
        int contentWidth = 200;
        int contentHeight = 200;
        width = getMeasurement(widthMeasureSpec, contentWidth);
        height = getMeasurement(heightMeasureSpec, contentHeight);

        //必须调用此方法
        setMeasuredDimension(width, height);
    }

    /*
     * 辅助设置大小的方法
     */
    private int getMeasurement(int measureSpec, int contentSize) {
        int specSize = MeasureSpec.getSize(measureSpec);
        switch (MeasureSpec.getMode(measureSpec)) {
            case MeasureSpec.AT_MOST:
                return Math.min(specSize, contentSize);
            case MeasureSpec.UNSPECIFIED:
                return contentSize;
            case MeasureSpec.EXACTLY:
                return specSize;
            default:
                return 0;
        }
    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        if (w != oldw || h != oldh) {
            //如果大小有变，要重置中心点以及半径
            mCenter.x = w / 2;
            mCenter.y = h / 2;
            mRadius = Math.min(mCenter.x, mCenter.y);
        } 
    }

    @Override
    protected void onDraw(Canvas canvas) {
        //绘制圆形
        // 用不同颜色从最小到最大绘制
        mPaint.setColor(Color.RED);
        canvas.drawCircle(mCenter.x, mCenter.y, mRadius, mPaint);
        mPaint.setColor(Color.WHITE);
        canvas.drawCircle(mCenter.x, mCenter.y, mRadius * 0.8f, mPaint);
        mPaint.setColor(Color.BLUE);
        canvas.drawCircle(mCenter.x, mCenter.y, mRadius * 0.6f, mPaint);
        mPaint.setColor(Color.WHITE);
        canvas.drawCircle(mCenter.x, mCenter.y, mRadius * 0.4f, mPaint);
        mPaint.setColor(Color.RED);
        canvas.drawCircle(mCenter.x, mCenter.y, mRadius * 0.2f, mPaint); 
    }
}
```

### 4. View动画

* `View.animate()`
* `ObjectAnimator`
* `AnimatorSet`

### 5. Layout动画

* `removeView(View)`
* `addView(View, LayoutParams)`

layout.xml需要添加：`android:animateLayoutChanges="true"`

* `Layout.setLayoutTransition(LayoutTransition)`


### 6. 方位调整

* 垂直：`res/layout-port`
* 水平：`res/layout-land`

### 7. AdapterView空数据时的处理

* `AdapterView.setEmptyView()`

### 8. 自定义ListView

```
# res/drawable/row_background_default.xml
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <gradient
        android:startColor="#EFEFEF"
        android:endColor="#989898"
        android:type="linear"
        android:angle="270" /> 
</shape>

# res/drawable/row_background_pressed.xml
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <gradient
        android:startColor="#0B8CF2"
        android:endColor="#0661E5"
        android:type="linear"
        android:angle="270" /> 
</shape>

# res/drawable/row_background.xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:state_pressed="true" android:drawable="@drawable/row_background_pressed"/>
    <item android:drawable="@drawable/row_background_default"/>
</selector>


# res/layout/custom_row.xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:padding="10dip"
    android:background="@drawable/row_background">
    <TextView
        android:id="@+id/line1"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_gravity="center"    />
</LinearLayout>

```

### 9. 带字段头的ListView


```
# Item
public class SectionItem<T> {
    private String mTitle;
    private T[] mItems;
    public SectionItem(String title, T[] items) {
        if (title == null) title = "";
        mTitle = title;
        mItems = items;
    }
    public String getTitle() {
        return mTitle;
    }
    public T getItem(int position) {
        return mItems[position];
    }
    public int getCount() {
        //包括额外的Item以及表头
        return (mItems == null ? 1 : 1 + mItems.length);
    }
    
    @Override
    public boolean equals(Object object) {
        //Two sections are equal if they have the same title
        if (object != null && object instanceof SectionItem) {
            return ((SectionItem) object).getTitle().equals(mTitle);
        }
        return false;
    }
}

# Adapter
public abstract class SimpleSectionsAdapter<T> extends BaseAdapter implements AdapterView.OnItemClickListener {
    /* 常量区分表头还是表身 */
    private static final int TYPE_HEADER = 0;
    private static final int TYPE_ITEM = 1;

    private LayoutInflater mLayoutInflater;
    private int mHeaderResource;
    private int mItemResource;

    /* 数据列表 */
    private List<SectionItem<T>> mSections;

    /* 列表分组 */
    private SparseArray<SectionItem<T>> mKeyedSections;
    
    public SimpleSectionsAdapter(ListView parent, int headerResId, int itemResId) {
        mLayoutInflater = LayoutInflater.from(parent.getContext());
        mHeaderResource = headerResId;
        mItemResource = itemResId;
        
        //初始化数据
        mSections = new ArrayList<SectionItem<T>>();
        mKeyedSections = new SparseArray<SectionItem<T>>();

        //添加监听器
        parent.setOnItemClickListener(this);
    }

    /*
     * 添加新的数据
     * 或者更新
     */
    public void addSection(String title, T[] items) {
        SectionItem<T> sectionItem = new SectionItem<T>(title, items);
        //添加数据, 更新已有的数据
        int currentIndex = mSections.indexOf(sectionItem);
        if (currentIndex >= 0) {
            mSections.remove(sectionItem);
            mSections.add(currentIndex, sectionItem);
        } else {
            mSections.add(sectionItem);
        }
        //排序
        reorderSections();
        //更新试图
        notifyDataSetChanged();
    }

    /*
     * 排序
     */
    private void reorderSections() {
        mKeyedSections.clear();
        int startPosition = 0;
        for (SectionItem<T> item : mSections) {
            mKeyedSections.put(startPosition, item);
            startPosition += item.getCount();
        } 
    }

    @Override
    public int getCount() {
        int count = 0;
        for (SectionItem<T> item : mSections) {
            count += item.getCount();
        }
        return count;
    }

    @Override
    public int getViewTypeCount() {
        //两种View类型：表头，表身
        return 2; 
    }

    @Override
    public int getItemViewType(int position) {
        if (isHeaderAtPosition(position)) {
            return TYPE_HEADER;
        } else {
            return TYPE_ITEM;
        }     
    }

    @Override
    public T getItem(int position) {
        return findSectionItemAtPosition(position);
    }
    
    @Override
    public long getItemId(int position) {
        return position;
    }

    /*
     * false：ListView的item不能点击
     */
    @Override
    public boolean areAllItemsEnabled() {
        return false;
    }

    /*
     * 判断哪个是ListView的表头
     */
    @Override
    public boolean isEnabled(int position) {
        return !isHeaderAtPosition(position);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        switch (getItemViewType(position)) {
            case TYPE_HEADER:
                return getHeaderView(position, convertView, parent);
            case TYPE_ITEM:
                return getItemView(position, convertView, parent);
           default:
                return convertView;
        }
    }

    private View getHeaderView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            convertView = mLayoutInflater.inflate(mHeaderResource, parent, false);
        }
        SectionItem<T> item = mKeyedSections.get(position);
        TextView textView = (TextView) convertView.findViewById(android.R.id.text1);
        textView.setText(item.getTitle());
        return convertView;
    }

    private View getItemView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            convertView = mLayoutInflater.inflate(mItemResource, parent, false);
        }
        T item = findSectionItemAtPosition(position);
        TextView textView = (TextView) convertView.findViewById(android.R.id.text1);
        textView.setText(item.toString());
        return convertView;
    }

    /** 监听点击事件 */
    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        T item = findSectionItemAtPosition(position);
        if (item != null) {
            onSectionItemClick(item);
        }
    }

    /**
     * 监听某段点击事件，由用户决定
     * @item 用户点击的某个item
     */
    public abstract void onSectionItemClick(T item);
    
    /* 帮助映射不同的item到不同的字段内 */
    /*
     * 判断是否是表头
     */
    private boolean isHeaderAtPosition(int position) {
        for (int i=0; i < mKeyedSections.size(); i++) {
            //判断位置是否是表头
            if (position == mKeyedSections.keyAt(i)) {
                return true;
            }
        }
        return false;
    }

    /*
     * 找出全局位置的Item
     */
    private T findSectionItemAtPosition(int position) {
        int firstIndex, lastIndex;
        for (int i=0; i < mKeyedSections.size(); i++) {
            firstIndex = mKeyedSections.keyAt(i);
            lastIndex = firstIndex + mKeyedSections.valueAt(i).getCount();
            if (position >= firstIndex && position < lastIndex) {
                int sectionPosition = position - firstIndex - 1;
                return mKeyedSections.valueAt(i).getItem(sectionPosition);
            }
        }
        return null;
    }
}
```

### 10. 创建简洁易懂的自定义组件

举例TextImageButton

```
public class TextImageButton extends FrameLayout {
    private ImageView imageView;
    private TextView textView;

    public TextImageButton(Context context) {
        this(context, null);
    }
        
    public TextImageButton(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }
    
    public TextImageButton(Context context, AttributeSet attrs,
            int defaultStyle) {
        // 用默认button风格初始化layout
        // 当前主题设置了可点击属性以及背景
        super(context, attrs, android.R.attr.buttonStyle);
        //创建子类视图
        imageView = new ImageView(context, attrs, defaultStyle);
        textView = new TextView(context, attrs, defaultStyle);
        //为子类视图创建LayoutParams
        FrameLayout.LayoutParams params = new 
            FrameLayout.LayoutParams(
            LayoutParams.WRAP_CONTENT,
            LayoutParams.WRAP_CONTENT, 
            Gravity.CENTER);

        //添加子类视图
        this.addView(imageView, params);
        this.addView(textView, params);

        //如果有图片，显示图片
        if(imageView.getDrawable() != null) {
            textView.setVisibility(View.GONE);
            imageView.setVisibility(View.VISIBLE);
        } else {
            textView.setVisibility(View.VISIBLE);
            imageView.setVisibility(View.GONE);
        }
    }
    
    /* 属性设置 */
    public void setText(CharSequence text) {
        //切换至Text视图
        textView.setVisibility(View.VISIBLE);
        imageView.setVisibility(View.GONE);
        //设置Text值
        textView.setText(text);
    }
    
    public void setImageResource(int resId) {
        //切换至图片视图
        textView.setVisibility(View.GONE);
        imageView.setVisibility(View.VISIBLE);
        //设置图片资源
        imageView.setImageResource(resId);
    }

    public void setImageDrawable(Drawable drawable) {
        //切换至图片视图
        textView.setVisibility(View.GONE);
        imageView.setVisibility(View.VISIBLE);
        //设置图片Drawable
        imageView.setImageDrawable(drawable);
    }
}
```

### 11. 自定义过渡动画

* Activity的用法

在startActivity()或者finish()后立即调用overridePendingTransition()

```
# startActivity()后的动画
res/anim/activity_open_enter.xml
res/anim/activity_open_exit.xml

# finish()后的动画
res/anim/activity_close_enter.xml
res/anim/activity_close_exit.xml


# res/anim/xxxx.xml
<?xml version="1.0" encoding="utf-8"?>
<set xmlns:android="http://schemas.android.com/apk/res/android">
    <rotate
        android:fromDegrees="90" android:toDegrees="0"
        android:pivotX="0%" android:pivotY="0%"
        android:fillEnabled="true"
        android:fillBefore="true" android:fillAfter="true"
        android:duration="500"  />
    <alpha
        android:fromAlpha="0.0" android:toAlpha="1.0"
        android:fillEnabled="true"
        android:fillBefore="true" android:fillAfter="true"
        android:duration="500" />
</set>

//开启新的acitvity的动画效果
Intent intent = new Intent(...);
startActivity(intent);
overridePendingTransition(R.anim.activity_open_enter, R.anim.activity_open_exit);
//关闭当前activity的动画效果
finish();
overridePendingTransition(R.anim.activity_close_enter, R.anim.activity_close_exit);

# res/values/styles.xml
<resources>
    <style name="AppTheme" parent="android:Theme.Holo.Light">
        <item name="android:windowAnimationStyle">
            @style/ActivityAnimation</item>
    </style>
    
    <style name="ActivityAnimation"
        parent="@android:style/Animation.Activity">
        <item name="android:activityOpenEnterAnimation">
            @anim/activity_open_enter</item>
        <item name="android:activityOpenExitAnimation">
            @anim/activity_open_exit</item>
        <item name="android:activityCloseEnterAnimation">
            @anim/activity_close_enter</item>
        <item name="android:activityCloseExitAnimation">
            @anim/activity_close_exit</item>
    </style>
</resources>

```

* 支持库中的Fragments的用法：

```
FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
    //必须第一个调用
    ft.setCustomAnimations(R.anim.activity_open_enter,
            R.anim.activity_open_exit,
            R.anim.activity_close_enter,
            R.anim.activity_close_exit);
    ft.replace(R.id.container_fragment, fragment);
    ft.addToBackStack(null);
ft.commit();

或者
// 覆写onCreateAnimation()方法
@Override
public Animation onCreateAnimation(int transit, boolean enter, int nextAnim) {
    switch (transit) {
        case FragmentTransaction.TRANSIT_FRAGMENT_FADE:
            if (enter) {
                return AnimationUtils.loadAnimation(getActivity(),
                        android.R.anim.fade_in);
            } else {
                return AnimationUtils.loadAnimation(getActivity(), android.R.anim.fade_out);
            }
        case FragmentTransaction.TRANSIT_FRAGMENT_CLOSE:
            if (enter) {
                return AnimationUtils.loadAnimation(getActivity(), R.anim.activity_close_enter);
            } else {
                return AnimationUtils.loadAnimation(getActivity(), R.anim.activity_close_exit);
            }
        case FragmentTransaction.TRANSIT_FRAGMENT_OPEN:
        default:
            if (enter) {
                return AnimationUtils.loadAnimation(getActivity(), R.anim.activity_open_enter);
            } else {
                return AnimationUtils.loadAnimation(getActivity(), R.anim.activity_open_exit);
            }
    }
}

FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
    //设置动画效果
    ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_OPEN);
    ft.replace(R.id.container_fragment, fragment);
    ft.addToBackStack(null);
ft.commit();

```

### 12. 创建View的变化

覆写自定义View的getChildStaticTransformation()
```
@Override
protected boolean getChildStaticTransformation(View child, Transformation t) {
    // 清除已有的变化
    t.clear();
    if (getOrientation() == HORIZONTAL) {
        // 基于离左边缘距离来改变子类View
        float delta = 1.0f - ((float) child.getLeft() / getWidth());
        t.getMatrix().setScale(delta, delta, child.getWidth() / 2, child.getHeight() / 2);
    } else {
        //基于离上边缘距离来改变子类View
        float delta = 1.0f - ((float) child.getTop() / getHeight());
        t.getMatrix().setScale(delta, delta, child.getWidth() / 2, child.getHeight() / 2);
        //基于子类View的位置渐变
        t.setAlpha(delta);
    }
    return true;
}
```


### 13. 创建可扩展的Collection Views<待续>

### 14. Action Bar

```
# AndroidManifest.xml
<activity
    ...
    android:theme="@style/AppTheme">
</activity>

# res/values/styles.xml
<resources>
    <style name="AppTheme" parent="@style/Theme.AppCompat.Light.DarkActionBar">
        ...
    </style>
</resources>

res/layout/activity_toolbar.xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    <!-- Toolbar widget -->
    <android.support.v7.widget.Toolbar
        android:id="@+id/toolbar"
        android:layout_height="wrap_content"
        android:layout_width="match_parent"
        android:minHeight="?attr/actionBarSize"
        android:background="?attr/colorPrimary"
        app:theme="@style/ThemeOverlay.AppCompat.Dark.ActionBar"/>
    <!-- Remaining application view contents here -->
</LinearLayout>

# Toolbar Activity
public class SupportToolbarActivity extends ActionBarActivity {
    private Toolbar mToolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_toolbar);

        //定位toolbar
        mToolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(mToolbar);
    }
    
    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        /*
         * 在调用onCreate()之后设置toolbar名字
         */
        mToolbar.setTitle("Android Recipes");

        mToolbar.setSubtitle("Toolbar Recipes");
    }
    
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.support, menu);
        return true;
    }
}
```

### 15. 锁定Acitivity方位

```
# AndroidManifest.xml
<activity
    ...
    android:screenOrientation="portrait">
    ...
</activity>

<activity android:name=".XxxActivity"
    android:screenOrientation="landscape"/>

```

### 16. 动态方位锁定

```
public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
    int current = getResources().getConfiguration().orientation;
    if(isChecked) {
        switch(current) {
            case Configuration.ORIENTATION_LANDSCAPE:
                setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
                break;
            case Configuration.ORIENTATION_PORTRAIT:
                setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
                break;
            default:
                setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED);
        }
    } else {
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED);
    } 
}
```

### 17. 手动处理屏幕旋转
```
public class ManualRotationActivity extends Activity {

    private EditText mEditText;
    private CheckBox mCheckBox;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //载入视图
        loadView();
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        //必需调用super
        super.onConfigurationChanged(newConfig);
        //只重载配置下的视图
        if (mCheckBox.isChecked()) {
            final Bundle uiState = new Bundle();
            //保存UI中重要的状态
            saveState(uiState);
            //重载视图
            loadView();
            //重载UI状态
            restoreState(uiState);
        }
    }
    
    //持久化UI状态
    private void saveState(Bundle state) {
        state.putBoolean("checkbox", mCheckBox.isChecked());
        state.putString("text", mEditText.getText().toString());
    }

    //重载UI状态
    private void restoreState(Bundle state) {
        mCheckBox.setChecked(state.getBoolean("checkbox"));
        mEditText.setText(state.getString("text"));
    }
    
    //初始化视图
    private void loadView() {
        setContentView(R.layout.activity_manual);

        mCheckBox = (CheckBox) findViewById(R.id.override);
        mEditText = (EditText) findViewById(R.id.text);
    }
}
```

### 17. 创建全局的Actions

```
public class ContextListItem extends LinearLayout implements PopupMenu.OnMenuItemClickListener, View.OnClickListener {
    private PopupMenu mPopupMenu;
    private TextView mTextView;
    public ContextListItem(Context context) {
        super(context);
    }
    public ContextListItem(Context context, AttributeSet attrs) {
        super(context, attrs);
    }
    public ContextListItem(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }
    
    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        mTextView = (TextView) findViewById(R.id.text);
        //添加点击事件
        View contextButton = findViewById(R.id.context);
        contextButton.setOnClickListener(this);
        //创建全局菜单
        mPopupMenu = new PopupMenu(getContext(), contextButton);
        mPopupMenu.setOnMenuItemClickListener(this);
        mPopupMenu.inflate(R.menu.contextmenu);
    }
    
    @Override
    public void onClick(View v) {
        //处理全局按钮点击，显示菜单
        mPopupMenu.show();
    }
    
    @Override
    public boolean onMenuItemClick(MenuItem item) {
        String itemText = mTextView.getText().toString();
        switch (item.getItemId()) {
            case R.id.menu_edit:
                Toast.makeText(getContext(), "Edit "+itemText, Toast.LENGTH_SHORT).show();
                break;
            case R.id.menu_delete:
                Toast.makeText(getContext(), "Delete "+itemText, Toast.LENGTH_SHORT).show();
                break; 
        }
        return true;
    }
}
```

### 18. 显示会话框
### 19. 自定义菜单和Actions
### 20. 自定义BACK

```
@Override
public void onBackPressed() {
    //自定义BACK按钮
    //调用super是正常处理 (比如说清除Acitivity)
    super.onBackPressed();
}
```

### 21. 效仿HOME按钮

```
Intent intent = new Intent(Intent.ACTION_MAIN);
intent.addCategory(Intent.CATEGORY_HOME);
startActivity(intent);

# 示例
@Override
public void onBackPressed() {
    Intent intent = new Intent(Intent.ACTION_MAIN);
    intent.addCategory(Intent.CATEGORY_HOME);
    startActivity(intent);
}
```

### 22. TextView监控

实现接口：android.text.TextWatcher

```
public void beforeTextChanged(CharSequence s, int start, int count, int after);
public void onTextChanged(CharSequence s, int start, int before, int count);
public void afterTextChanged(Editable s);
```

### 23. 自定义键盘动作
实现接口：TextView.OnEditorActionListener
```
@Override
public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
    if(actionId == EditorInfo.IME_ACTION_SEARCH) {
        //处理Search键
        return true;
    }
    if(actionId == EditorInfo.IME_ACTION_GO) {
        //处理go键
        return true;
    }
    return false;
}
```

### 24. 禁用Soft键盘

```
public void onClick(View view) {
    InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
    imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
}
```

### 25. 处理复杂的TOUCH事件

### 26. 转发TOUCH事件
覆写Layout类中的onSizeChanged()方法
```
    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh)
    {
        if (w != oldw || h != oldh) {
            //Apply the whole area of this view as the delegate area
            Rect bounds = new Rect(0, 0, w, h);
            TouchDelegate delegate = new TouchDelegate(bounds, mButton);
            setTouchDelegate(delegate);
        }
    }
```

### 27. 转移TOUCH到子类View
