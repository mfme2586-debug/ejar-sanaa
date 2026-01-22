/*
  # قاعدة بيانات تطبيق إيجار صنعاء
  
  ## نظرة عامة
  هذا التطبيق لإيجار العقارات في أمانة العاصمة صنعاء، اليمن.
  يشمل شقق، فلل، محلات، صالونات أعراس، سيارات، دراجات، وبسطات.
  
  ## 1. الجداول الجديدة
  
  ### جدول `listings` (الإعلانات)
  يحتوي على جميع إعلانات الإيجار بتفاصيلها الكاملة:
  
  **المعلومات الأساسية:**
  - `id` (uuid) - المعرف الفريد للإعلان
  - `type` (text) - نوع العقار (apartment, villa, shop, wedding_hall, car, motorcycle, stall)
  - `title` (text) - عنوان الإعلان
  - `description` (text) - وصف تفصيلي
  
  **معلومات الموقع:**
  - `district` (text) - المديرية (أحد المديريات العشر في صنعاء)
  - `neighborhood` (text) - الحي
  - `street` (text) - الحارة/الشارع
  - `location_description` (text) - وصف إضافي للموقع
  
  **تفاصيل العقار:**
  - `building_type` (text) - نوع البناء (عمارة / شقة واحدة / مجموعة شقق)
  - `floor` (text) - رقم الدور
  - `room_count` (integer) - عدد الغرف
  - `has_kitchen` (boolean) - يوجد مطبخ
  - `kitchen_size` (text) - حجم المطبخ
  - `bathroom_count` (integer) - عدد الحمامات
  
  **المجلس الخارجي:**
  - `has_external_majlis` (boolean) - يوجد مجلس خارجي
  - `external_majlis_has_bathroom` (boolean) - المجلس الخارجي به حمام
  
  **المرافق - الماء:**
  - `water_source` (text) - مصدر الماء (حكومي/وايتات/خزان)
  - `water_independence` (text) - مستقل أو مشترك
  - `water_tank_capacity` (text) - سعة الخزان
  
  **المرافق - الكهرباء:**
  - `electricity_type` (text) - نوع الكهرباء (حكومي/تجاري/مولد)
  - `electricity_independence` (text) - مستقل أو مشترك
  - `has_solar_panels` (boolean) - يوجد ألواح شمسية
  
  **الشمس (مهم جداً للتدفئة الشتوية):**
  - `sunlight_direction` (text) - اتجاه دخول الشمس
  
  **السعر والشروط المالية:**
  - `price` (numeric) - سعر الإيجار الشهري
  - `currency` (text) - العملة (ريال قديم/جديد/دولار/ريال سعودي)
  - `price_includes_utilities` (boolean) - السعر شامل الماء والكهرباء
  - `deposit` (numeric) - مبلغ التأمين
  - `advance` (numeric) - المقدم (شهر أو أكثر)
  - `has_brokerage` (boolean) - يوجد ساعية (عمولة دلالة)
  - `negotiable` (boolean) - قابل للتفاوض
  - `requires_guarantee` (boolean) - يتطلب ضمانة
  - `guarantee_type` (text) - نوع الضمانة (تجاري/وظيفي)
  - `is_commercial` (boolean) - تجاري أو سكني
  
  **معلومات الاتصال:**
  - `contact_phone` (text) - رقم الهاتف
  - `seller_type` (text) - نوع البائع (مالك/وكيل/دلال)
  - `seller_name` (text) - اسم البائع
  
  **الصور والوسائط:**
  - `images` (text[]) - مصفوفة روابط الصور
  
  **بيانات تتبع النظام:**
  - `created_at` (timestamptz) - تاريخ الإنشاء
  - `updated_at` (timestamptz) - تاريخ آخر تحديث
  - `is_active` (boolean) - الإعلان نشط
  - `is_featured` (boolean) - إعلان مميز
  - `user_id` (uuid) - معرف المستخدم الذي أنشأ الإعلان
  
  ### جدول `room_details` (تفاصيل الغرف)
  يحتوي على مقاسات وتفاصيل الغرف لكل إعلان:
  - `id` (uuid) - المعرف الفريد
  - `listing_id` (uuid) - ربط بجدول الإعلانات
  - `name` (text) - اسم الغرفة (غرفة 1، غرفة 2، مجلس، إلخ)
  - `length` (numeric) - الطول بالأمتار
  - `width` (numeric) - العرض بالأمتار
  - `created_at` (timestamptz) - تاريخ الإضافة
  
  ## 2. الأمان (Row Level Security)
  
  تم تفعيل RLS على جميع الجداول مع السياسات التالية:
  
  ### للإعلانات (listings):
  - **القراءة**: جميع المستخدمين (مسجلين وغير مسجلين) يمكنهم قراءة الإعلانات النشطة
  - **الإضافة**: المستخدمون المسجلون فقط يمكنهم إضافة إعلانات
  - **التحديث**: المستخدم يمكنه تحديث إعلاناته فقط
  - **الحذف**: المستخدم يمكنه حذف إعلاناته فقط
  
  ### لتفاصيل الغرف (room_details):
  - **القراءة**: الجميع يمكنهم قراءة تفاصيل الغرف للإعلانات النشطة
  - **الإضافة**: صاحب الإعلان فقط يمكنه إضافة تفاصيل الغرف
  - **التحديث**: صاحب الإعلان فقط يمكنه تحديث تفاصيل الغرف
  - **الحذف**: صاحب الإعلان فقط يمكنه حذف تفاصيل الغرف
  
  ## 3. الفهارس (Indexes)
  
  تم إنشاء فهارس لتسريع عمليات البحث الشائعة:
  - البحث حسب النوع (type)
  - البحث حسب المديرية (district)
  - البحث حسب السعر (price)
  - البحث حسب الحالة النشطة (is_active)
  - البحث حسب المستخدم (user_id)
  - ربط تفاصيل الغرف بالإعلانات (listing_id)
  
  ## 4. ملاحظات مهمة
  
  - جميع الحقول النصية تدعم اللغة العربية
  - الأسعار بصيغة numeric لدعم الحسابات المالية بدقة
  - نظام الصور يدعم روابط متعددة (text array)
  - التواريخ بتوقيت UTC مع إمكانية التحويل للتوقيت المحلي
*/

-- إنشاء جدول الإعلانات
CREATE TABLE IF NOT EXISTS listings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  
  -- المعلومات الأساسية
  type text NOT NULL,
  title text NOT NULL,
  description text DEFAULT '',
  
  -- الموقع
  district text NOT NULL,
  neighborhood text,
  street text,
  location_description text,
  
  -- تفاصيل العقار
  building_type text,
  floor text,
  room_count integer,
  has_kitchen boolean DEFAULT false,
  kitchen_size text,
  bathroom_count integer,
  
  -- المجلس الخارجي
  has_external_majlis boolean DEFAULT false,
  external_majlis_has_bathroom boolean DEFAULT false,
  
  -- المرافق - الماء
  water_source text,
  water_independence text,
  water_tank_capacity text,
  
  -- المرافق - الكهرباء
  electricity_type text,
  electricity_independence text,
  has_solar_panels boolean DEFAULT false,
  
  -- الشمس
  sunlight_direction text,
  
  -- السعر والشروط
  price numeric NOT NULL,
  currency text DEFAULT 'ريال يمني',
  price_includes_utilities boolean DEFAULT false,
  deposit numeric,
  advance numeric,
  has_brokerage boolean DEFAULT false,
  negotiable boolean DEFAULT false,
  requires_guarantee boolean DEFAULT false,
  guarantee_type text,
  is_commercial boolean DEFAULT false,
  
  -- معلومات الاتصال
  contact_phone text NOT NULL,
  seller_type text NOT NULL,
  seller_name text,
  
  -- الصور
  images text[] DEFAULT '{}',
  
  -- بيانات النظام
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  is_active boolean DEFAULT true,
  is_featured boolean DEFAULT false,
  
  -- قيود البيانات
  CONSTRAINT valid_type CHECK (type IN ('apartment', 'villa', 'shop', 'wedding_hall', 'car', 'motorcycle', 'stall', 'land', 'office', 'warehouse')),
  CONSTRAINT valid_seller_type CHECK (seller_type IN ('owner', 'agent', 'broker')),
  CONSTRAINT positive_price CHECK (price >= 0)
);

-- إنشاء جدول تفاصيل الغرف
CREATE TABLE IF NOT EXISTS room_details (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  listing_id uuid NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  name text NOT NULL,
  length numeric,
  width numeric,
  created_at timestamptz DEFAULT now(),
  
  CONSTRAINT positive_dimensions CHECK (
    (length IS NULL OR length > 0) AND 
    (width IS NULL OR width > 0)
  )
);

-- إنشاء فهارس لتحسين الأداء
CREATE INDEX IF NOT EXISTS idx_listings_type ON listings(type);
CREATE INDEX IF NOT EXISTS idx_listings_district ON listings(district);
CREATE INDEX IF NOT EXISTS idx_listings_price ON listings(price);
CREATE INDEX IF NOT EXISTS idx_listings_is_active ON listings(is_active);
CREATE INDEX IF NOT EXISTS idx_listings_is_featured ON listings(is_featured);
CREATE INDEX IF NOT EXISTS idx_listings_created_at ON listings(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_listings_user_id ON listings(user_id);
CREATE INDEX IF NOT EXISTS idx_room_details_listing_id ON room_details(listing_id);

-- تفعيل Row Level Security
ALTER TABLE listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE room_details ENABLE ROW LEVEL SECURITY;

-- سياسات الأمان لجدول listings

-- القراءة: الجميع يمكنهم قراءة الإعلانات النشطة
CREATE POLICY "Anyone can view active listings"
  ON listings FOR SELECT
  USING (is_active = true);

-- الإضافة: المستخدمون المسجلون فقط
CREATE POLICY "Authenticated users can create listings"
  ON listings FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- التحديث: المستخدم يمكنه تحديث إعلاناته فقط
CREATE POLICY "Users can update own listings"
  ON listings FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- الحذف: المستخدم يمكنه حذف إعلاناته فقط
CREATE POLICY "Users can delete own listings"
  ON listings FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- سياسات الأمان لجدول room_details

-- القراءة: الجميع يمكنهم قراءة تفاصيل الغرف للإعلانات النشطة
CREATE POLICY "Anyone can view room details for active listings"
  ON room_details FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM listings
      WHERE listings.id = room_details.listing_id
      AND listings.is_active = true
    )
  );

-- الإضافة: صاحب الإعلان فقط
CREATE POLICY "Listing owners can add room details"
  ON room_details FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM listings
      WHERE listings.id = room_details.listing_id
      AND listings.user_id = auth.uid()
    )
  );

-- التحديث: صاحب الإعلان فقط
CREATE POLICY "Listing owners can update room details"
  ON room_details FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM listings
      WHERE listings.id = room_details.listing_id
      AND listings.user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM listings
      WHERE listings.id = room_details.listing_id
      AND listings.user_id = auth.uid()
    )
  );

-- الحذف: صاحب الإعلان فقط
CREATE POLICY "Listing owners can delete room details"
  ON room_details FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM listings
      WHERE listings.id = room_details.listing_id
      AND listings.user_id = auth.uid()
    )
  );

-- دالة لتحديث updated_at تلقائياً
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- إضافة trigger لتحديث updated_at عند تعديل الإعلان
DROP TRIGGER IF EXISTS update_listings_updated_at ON listings;
CREATE TRIGGER update_listings_updated_at
  BEFORE UPDATE ON listings
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();