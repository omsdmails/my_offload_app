from offload_lib import offload

@offload
def heavy_task(n):
    # مثال: مجموع الأعداد من 1 إلى n
    return sum(range(1, n+1))

if __name__ == "__main__":
    # اختبار سريع
    print(heavy_task(10))  # يجب أن يطبع 55
